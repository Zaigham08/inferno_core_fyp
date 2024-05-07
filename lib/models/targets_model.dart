class TargetsModel {
  final String targetId;
  final String name;
  final List<String> accessibleByUsers;
  final String targetAccessKey;

  TargetsModel({
    required this.targetId,
    required this.name,
    required this.accessibleByUsers,
    required this.targetAccessKey,
  });

  factory TargetsModel.fromJson(Map<String, dynamic> json) {
    return TargetsModel(
      targetId: json['target_id'],
      name: json['name'],
      accessibleByUsers: List<String>.from(json['accessible_by_users']),
      targetAccessKey: json['target_access_key'],
    );
  }
}
