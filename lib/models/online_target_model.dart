class OnlineTarget {
  final String targetId;
  final String name;
  final List<String> accessibleByUsers;
  final String targetAccessKey;

  OnlineTarget({
    required this.targetId,
    required this.name,
    required this.accessibleByUsers,
    required this.targetAccessKey,
  });

  factory OnlineTarget.fromJson(Map<String, dynamic> json) {
    return OnlineTarget(
      targetId: json['target_id'],
      name: json['name'],
      accessibleByUsers: List<String>.from(json['accessible_by_users']),
      targetAccessKey: json['target_access_key'],
    );
  }
}
