class Program {
  final String name;
  final String uninstallString;
  final String publisher;
  final String version;

  Program({
    required this.name,
    required this.uninstallString,
    required this.publisher,
    required this.version,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      name: json['name'],
      uninstallString: json['uninstall_string'],
      publisher: json['publisher'],
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uninstall_string': uninstallString,
      'publisher': publisher,
      'version': version,
    };
  }
}

class Programs {
  final List<Program> programs;

  Programs({required this.programs});

  factory Programs.fromJson(List<dynamic> json) {
    return Programs(
      programs: json.map((program) => Program.fromJson(program)).toList(),
    );
  }

  List<Map<String, dynamic>> toJson() {
    return programs.map((program) => program.toJson()).toList();
  }
}
