class VideoItemEntity {
  final String videoUrl;
  final String videoName;
  final String videoAuthors;
  final String videoDescription;
  VideoItemEntity({
    required this.videoUrl,
    required this.videoName,
    required this.videoAuthors,
    required this.videoDescription,
  });

  // 从JSON创建实例
  factory VideoItemEntity.fromJson(Map<String, dynamic> json) {
    return VideoItemEntity(
      videoUrl: json['videoUrl'] as String,
      videoName: json['videoName'] as String,
      videoAuthors: json['videoAuthors'] as String,
      videoDescription: json['videoDescription'] as String,
    );
  }
}
