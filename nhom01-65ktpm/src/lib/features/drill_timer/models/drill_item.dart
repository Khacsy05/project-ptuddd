/// Model đại diện cho một bài tập huấn luyện bóng đá (Football Drill)
/// Phân hệ: Bộ đếm Phiên tập Huấn luyện (Drill Timer & Cloud Log)
/// Phụ trách: Bùi Đức Hiệp
class DrillItem {
  final String id;
  final String title;
  final String category; // Kỹ thuật, Thể lực, Chiến thuật, Khởi động
  final int durationSeconds; // Thời gian tập mỗi hiệp (tính bằng giây)
  final int restSeconds; // Thời gian nghỉ giải lao giữa hiệp (tính bằng giây)
  final int sets; // Số hiệp tập luyện
  final String description; // Hướng dẫn kỹ thuật thực hiện
  final String iconName; // Tên icon gợi nhớ

  const DrillItem({
    required this.id,
    required this.title,
    required this.category,
    required this.durationSeconds,
    this.restSeconds = 60,
    this.sets = 1,
    this.description = '',
    this.iconName = 'sports_soccer',
  });

  /// Chuyển đổi giây thành chuỗi hiển thị MM:SS (VD: 900s -> 15:00)
  String get formattedDuration {
    final minutes = (durationSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (durationSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Chuyển đổi thời gian nghỉ thành chuỗi hiển thị MM:SS (VD: 60s -> 01:00)
  String get formattedRestDuration {
    final minutes = (restSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (restSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Số phút tập tính theo đơn vị phút (làm tròn lên để lưu vào database)
  int get durationMinutes => (durationSeconds / 60).ceil();

  /// Chuyển đối tượng sang Map JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'category': category,
      'duration_seconds': durationSeconds,
      'rest_seconds': restSeconds,
      'sets': sets,
      'description': description,
      'icon_name': iconName,
    };
  }

  /// Khởi tạo đối tượng từ Map JSON
  factory DrillItem.fromJson(Map<String, dynamic> json) {
    return DrillItem(
      id: json['id'] as String,
      title: json['title'] as String,
      category: json['category'] as String? ?? 'Kỹ thuật',
      durationSeconds: json['duration_seconds'] as int? ?? 300,
      restSeconds: json['rest_seconds'] as int? ?? 60,
      sets: json['sets'] as int? ?? 1,
      description: json['description'] as String? ?? '',
      iconName: json['icon_name'] as String? ?? 'sports_soccer',
    );
  }

  /// Tạo bản sao với các thuộc tính cập nhật mới
  DrillItem copyWith({
    String? id,
    String? title,
    String? category,
    int? durationSeconds,
    int? restSeconds,
    int? sets,
    String? description,
    String? iconName,
  }) {
    return DrillItem(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      restSeconds: restSeconds ?? this.restSeconds,
      sets: sets ?? this.sets,
      description: description ?? this.description,
      iconName: iconName ?? this.iconName,
    );
  }
}
