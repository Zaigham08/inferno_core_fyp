class Account {
  final int id;
  final String name;
  final String? host;

  Account({
    required this.id,
    required this.name,
    this.host,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as int,
      name: json['Name'] as String,
      host: json['Host'] as String?,
    );
  }
}
