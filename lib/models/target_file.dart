class TargetFile {
  final String targetId;
  final String targetName;
  final String fileReference;
  final String fileName;

  TargetFile({
    required this.targetId,
    required this.targetName,
    required this.fileReference,
    required this.fileName,
  });

  factory TargetFile.fromJson(Map<String, dynamic> json) {
    return TargetFile(
      targetId: json['target_id'],
      targetName: json['target_name'],
      fileReference: json['file_reference'],
      fileName: json['file_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'target_id': targetId,
      'target_name': targetName,
      'file_reference': fileReference,
      'file_name': fileName,
    };
  }
}
