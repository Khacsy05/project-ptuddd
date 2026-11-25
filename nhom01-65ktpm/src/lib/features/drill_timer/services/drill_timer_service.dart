import 'dart:async';
import 'package:flutter/foundation.dart';
import '../models/drill_item.dart';

/// Các trạng thái của đồng hồ bấm giờ tập luyện
enum DrillTimerStatus {
  idle, // Chưa bắt đầu
  running, // Đang đếm ngược thời gian tập
  paused, // Đang tạm dừng
  resting, // Đang đếm ngược thời gian nghỉ giải lao giữa hiệp
  completed, // Đã hoàn thành toàn bộ các hiệp
}

/// Service quản lý logic đếm ngược thời gian tập luyện (Drill Timer Controller)
/// Phân hệ: Bộ đếm Phiên tập Huấn luyện (Drill Timer & Cloud Log)
/// Phụ trách: Bùi Đức Hiệp
class DrillTimerService extends ChangeNotifier {
  DrillItem? _selectedDrill;
  int _currentSet = 1;
  int _remainingSeconds = 0;
  int _totalElapsedSeconds = 0;
  DrillTimerStatus _status = DrillTimerStatus.idle;
  bool _isPausedFromRest = false;

  Timer? _timer;

  // Callbacks thông báo cho UI (âm thanh / rung phản hồi / chuyển màn hình)
  VoidCallback? onSetCompleted;
  VoidCallback? onRestCompleted;
  VoidCallback? onSessionCompleted;

  // Getters
  DrillItem? get selectedDrill => _selectedDrill;
  int get currentSet => _currentSet;
  int get remainingSeconds => _remainingSeconds;
  int get totalElapsedSeconds => _totalElapsedSeconds;
  DrillTimerStatus get status => _status;

  int get totalSets => _selectedDrill?.sets ?? 1;

  bool get isIdle => _status == DrillTimerStatus.idle;
  bool get isRunning => _status == DrillTimerStatus.running;
  bool get isPaused => _status == DrillTimerStatus.paused;
  bool get isResting => _status == DrillTimerStatus.resting;
  bool get isCompleted => _status == DrillTimerStatus.completed;

  /// Tổng thời gian của giai đoạn hiện tại (để tính phần trăm vòng tròn tiến độ)
  int get currentPhaseTotalSeconds {
    if (_selectedDrill == null) return 1;
    if (_status == DrillTimerStatus.resting ||
        (_status == DrillTimerStatus.paused && _isPausedFromRest)) {
      return _selectedDrill!.restSeconds > 0 ? _selectedDrill!.restSeconds : 1;
    }
    return _selectedDrill!.durationSeconds > 0
        ? _selectedDrill!.durationSeconds
        : 1;
  }

  /// Tỷ lệ tiến độ còn lại từ 0.0 -> 1.0 phục vụ hiển thị CircularProgressIndicator
  double get progress {
    final total = currentPhaseTotalSeconds;
    if (total <= 0) return 0.0;
    return (_remainingSeconds / total).clamp(0.0, 1.0);
  }

  /// Định dạng thời gian còn lại thành MM:SS
  String get formattedRemainingTime {
    final minutes = (_remainingSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Tổng số phút tập luyện thực tế (tối thiểu 1 phút nếu đã tập > 0 giây)
  int get actualMinutesTrained {
    if (_totalElapsedSeconds == 0) return 0;
    return (_totalElapsedSeconds / 60).ceil();
  }

  /// Chọn bài tập mới và đặt lại toàn bộ thông số về ban đầu
  void selectDrill(DrillItem drill) {
    _stopTimer();
    _selectedDrill = drill;
    _currentSet = 1;
    _remainingSeconds = drill.durationSeconds;
    _totalElapsedSeconds = 0;
    _status = DrillTimerStatus.idle;
    _isPausedFromRest = false;
    notifyListeners();
  }

  /// Bắt đầu đếm ngược bài tập
  void start() {
    if (_selectedDrill == null) return;
    if (_status == DrillTimerStatus.running) return;

    if (_status == DrillTimerStatus.completed) {
      reset();
    }

    _status = DrillTimerStatus.running;
    _startPeriodicTimer();
    notifyListeners();
  }

  /// Tạm dừng đếm ngược
  void pause() {
    if (_status != DrillTimerStatus.running &&
        _status != DrillTimerStatus.resting) {
      return;
    }
    _isPausedFromRest = (_status == DrillTimerStatus.resting);
    _stopTimer();
    _status = DrillTimerStatus.paused;
    notifyListeners();
  }

  /// Tiếp tục đếm ngược từ trạng thái tạm dừng
  void resume() {
    if (_status != DrillTimerStatus.paused) return;
    _status = _isPausedFromRest
        ? DrillTimerStatus.resting
        : DrillTimerStatus.running;
    _startPeriodicTimer();
    notifyListeners();
  }

  /// Đặt lại bộ đếm về hiệp 1 của bài tập hiện tại
  void reset() {
    _stopTimer();
    if (_selectedDrill != null) {
      _currentSet = 1;
      _remainingSeconds = _selectedDrill!.durationSeconds;
      _totalElapsedSeconds = 0;
    }
    _status = DrillTimerStatus.idle;
    _isPausedFromRest = false;
    notifyListeners();
  }

  /// Kết thúc sớm hiệp hiện tại / Chuyển sang bài tập hoặc hiệp tiếp theo
  void nextSetOrFinish() {
    if (_selectedDrill == null) return;
    _stopTimer();

    if (_currentSet < _selectedDrill!.sets) {
      // Nếu còn hiệp tiếp theo và có thời gian nghỉ -> chuyển sang nghỉ giữa hiệp
      if (_selectedDrill!.restSeconds > 0 &&
          _status != DrillTimerStatus.resting) {
        _status = DrillTimerStatus.resting;
        _remainingSeconds = _selectedDrill!.restSeconds;
        _isPausedFromRest = false;
        onSetCompleted?.call();
        _startPeriodicTimer();
      } else {
        // Bắt đầu hiệp mới ngay lập tức
        _startNextSet();
      }
    } else {
      // Đã hoàn thành tất cả các hiệp
      _completeSession();
    }
    notifyListeners();
  }

  /// Bỏ qua thời gian nghỉ giữa hiệp để tập tiếp ngay
  void skipRest() {
    if (_status != DrillTimerStatus.resting &&
        !(_status == DrillTimerStatus.paused && _isPausedFromRest)) {
      return;
    }
    _stopTimer();
    _startNextSet();
    notifyListeners();
  }

  /// Kết thúc phiên tập ngay lập tức (dùng khi người dùng bấm Hết buổi tập)
  void finishSessionEarly() {
    _stopTimer();
    _completeSession();
    notifyListeners();
  }

  void _startNextSet() {
    if (_selectedDrill == null) return;
    _currentSet++;
    _status = DrillTimerStatus.running;
    _remainingSeconds = _selectedDrill!.durationSeconds;
    _isPausedFromRest = false;
    onRestCompleted?.call();
    _startPeriodicTimer();
  }

  void _completeSession() {
    _stopTimer();
    _remainingSeconds = 0;
    _status = DrillTimerStatus.completed;
    _isPausedFromRest = false;
    onSessionCompleted?.call();
  }

  void _startPeriodicTimer() {
    _stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        if (_status == DrillTimerStatus.running) {
          _totalElapsedSeconds++;
        }
        notifyListeners();
      } else {
        _handlePhaseFinished();
      }
    });
  }

  void _handlePhaseFinished() {
    if (_selectedDrill == null) return;
    _stopTimer();

    if (_status == DrillTimerStatus.running) {
      if (_currentSet < _selectedDrill!.sets) {
        if (_selectedDrill!.restSeconds > 0) {
          _status = DrillTimerStatus.resting;
          _remainingSeconds = _selectedDrill!.restSeconds;
          onSetCompleted?.call();
          _startPeriodicTimer();
        } else {
          _startNextSet();
        }
      } else {
        _completeSession();
      }
    } else if (_status == DrillTimerStatus.resting) {
      _startNextSet();
    }
    notifyListeners();
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}

