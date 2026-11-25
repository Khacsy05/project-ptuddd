import 'package:flutter/material.dart';
import '../services/drill_timer_service.dart';

/// Widget hiển thị mặt đồng hồ đếm ngược tập luyện dạng vòng tròn thể thao
/// Tuân thủ bảng màu Design System BallerDiscipline (Neon Pitch Dark Theme)
/// Phụ trách: Bùi Đức Hiệp
class TimerDisplay extends StatelessWidget {
  final String formattedTime;
  final double progress;
  final DrillTimerStatus status;
  final int currentSet;
  final int totalSets;

  const TimerDisplay({
    super.key,
    required this.formattedTime,
    required this.progress,
    required this.status,
    required this.currentSet,
    required this.totalSets,
  });

  /// Lấy màu chủ đạo theo trạng thái hiện tại (Neon Pitch Palette)
  Color get _statusColor {
    switch (status) {
      case DrillTimerStatus.running:
        return const Color(0xFF10B981); // Emerald Green (Đang tập)
      case DrillTimerStatus.resting:
        return const Color(0xFF38BDF8); // Electric Sky Blue (Nghỉ hiệp)
      case DrillTimerStatus.paused:
        return const Color(0xFFF59E0B); // Amber (Tạm dừng)
      case DrillTimerStatus.completed:
        return const Color(0xFF22C55E); // Neon Green (Hoàn thành)
      case DrillTimerStatus.idle:
        return const Color(0xFF10B981); // Emerald Green (Sẵn sàng)
    }
  }

  /// Nhãn văn bản hiển thị trạng thái trên mặt đồng hồ
  String get _statusLabel {
    switch (status) {
      case DrillTimerStatus.running:
        return 'ĐANG TẬP LUYỆN';
      case DrillTimerStatus.resting:
        return 'NGHỈ GIẢI LAO';
      case DrillTimerStatus.paused:
        return 'TẠM DỪNG';
      case DrillTimerStatus.completed:
        return 'HOÀN THÀNH';
      case DrillTimerStatus.idle:
        return 'SẴN SÀNG';
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeColor = _statusColor;

    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF161F30), // Muted Stadium Surface
        boxShadow: [
          BoxShadow(
            color: activeColor.withOpacity(0.18),
            blurRadius: 28,
            spreadRadius: 4,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Vòng tròn tiến độ nền và thanh tiến trình đếm ngược
          SizedBox(
            width: 236,
            height: 236,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 12,
              strokeCap: StrokeCap.round,
              backgroundColor: const Color(0xFF1E293B), // Slate Card
              valueColor: AlwaysStoppedAnimation<Color>(activeColor),
            ),
          ),

          // Thông tin hiển thị bên trong tâm đồng hồ
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Nhãn trạng thái (Badge)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: activeColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: activeColor.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Text(
                  _statusLabel,
                  style: TextStyle(
                    color: activeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              // Số đồng hồ đếm ngược MM:SS
              Text(
                formattedTime,
                style: const TextStyle(
                  color: Color(0xFFF8FAFC), // Foreground Crisp White
                  fontSize: 56,
                  fontWeight: FontWeight.w700,
                  fontFeatures: [FontFeature.tabularFigures()],
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 12),

              // Thông tin hiệp tập hiện tại
              Text(
                'Hiệp $currentSet / $totalSets',
                style: const TextStyle(
                  color: Color(0xFF94A3B8), // Muted Slate
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

