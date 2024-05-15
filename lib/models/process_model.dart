class Process {
  final String name;
  final int pid;
  final String cpuUsage;
  final String memoryUsage;

  Process({
    required this.name,
    required this.pid,
    required this.cpuUsage,
    required this.memoryUsage,
  });

  factory Process.fromJson(Map<String, dynamic> json) {
    return Process(
      name: json['name'] ?? '',
      pid: json['pid'] ?? 0,
      cpuUsage: json['cpu_usage'] ?? '',
      memoryUsage: json['memory_usage'] ?? '',
    );
  }
}
