/// Model đại diện cho một phiên tập huấn luyện (Drill Session)
/// Phân hệ: Bộ đếm Phiên tập Huấn luyện (Drill Timer & Cloud Log)
/// Phụ trách: Bùi Đức Hiệp
/// Khớp 100% với bảng CSDL `training_drills_sessions` trên Supabase
class DrillSession {
  final int? id;
  final String userId;
  final String drillName;
  final int durationMinutes;
  final int setsCompleted;
  final DateTime createdAt;
  final String? notes;

  const DrillSession({
    this.id,
    required this.userId,
    required this.drillName,
    required this.durationMinutes,
    this.setsCompleted = 1,
    required this.createdAt,
    this.notes,
  });

  /// Chuyển đổi dữ liệu sang dạng Map để Insert trực tiếp vào bảng Supabase `training_drills_sessions`
  Map<String, dynamic> toSupabaseMap() {
    return {
      'user_id': userId,
      'drill_name': drillName,
      'duration_minutes': durationMinutes,
      'sets_completed': setsCompleted,
      'created_at': createdAt.toIso8601String(),
    };
  }

  /// Khởi tạo đối tượng từ dữ liệu truy vấn từ Supabase
  factory DrillSession.fromSupabaseMap(Map<String, dynamic> map) {
    return DrillSession(
      id: map['id'] as int?,
      userId: map['user_id'] as String? ?? '',
      drillName: map['drill_name'] as String? ?? 'Bài tập bóng đá',
      durationMinutes: map['duration_minutes'] as int? ?? 0,
      setsCompleted: map['sets_completed'] as int? ?? 1,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'].toString())
          : DateTime.now(),
      notes: map['notes'] as String?,
    );
  }

  /// Định dạng ngày giờ tập hiển thị trực quan (VD: 24/11/2026 08:30)
  String get formattedDateTime {
    final day = createdAt.day.toString().padLeft(2, '0');
    final month = createdAt.month.toString().padLeft(2, '0');
    final year = createdAt.year.toString();
    final hour = createdAt.hour.toString().padLeft(2, '0');
    final minute = createdAt.minute.toString().padLeft(2, '0');
    return '$day/$month/$year $hour:$minute';
  }

  /// Định dạng tóm tắt thời lượng buổi tập
  String get summaryText {
    return '$setsCompleted hiệp • $durationMinutes phút';
  }

  /// Tạo bản sao với các thuộc tính cập nhật mới
  DrillSession copyWith({
    int? id,
    String? userId,
    String? drillName,
    int? durationMinutes,
    int? setsCompleted,
    DateTime? createdAt,
    String? notes,
  }) {
    return DrillSession(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      drillName: drillName ?? this.drillName,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      setsCompleted: setsCompleted ?? this.setsCompleted,
      createdAt: createdAt ?? this.createdAt,
      notes: notes ?? this.notes,
    );
  }
}
