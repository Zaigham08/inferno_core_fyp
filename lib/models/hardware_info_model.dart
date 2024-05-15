class HardwareInfo {
  final String cpuUsage;
  final RamUsage ramUsage;
  final List<DiskUsage> diskUsage;
  final String bootTime;
  final Map<String, List<NetworkInterface>> networkInterfaces;
  final String battery;

  HardwareInfo({
    required this.cpuUsage,
    required this.ramUsage,
    required this.diskUsage,
    required this.bootTime,
    required this.networkInterfaces,
    required this.battery,
  });

  factory HardwareInfo.fromJson(Map<String, dynamic> json) {
    Map<String, List<NetworkInterface>> networkInterfacesMap = {};
    json['result']['Network Interfaces'].forEach((key, value) {
      networkInterfacesMap[key] = List<NetworkInterface>.from(
          value.map((x) => NetworkInterface.fromJson(x)));
    });
    return HardwareInfo(
      cpuUsage: json['result']['CPU Usage'],
      ramUsage: RamUsage.fromJson(json['result']['RAM Usage']),
      diskUsage: List<DiskUsage>.from(json['result']['Disk Usage'].map(
        (diskJson) => DiskUsage.fromJson(diskJson),
      )),
      bootTime: json['result']['Boot Time'],
      networkInterfaces: networkInterfacesMap,
      battery: json['result']['Battery'],
    );
  }
}

class RamUsage {
  final double totalGb;
  final double usedGb;

  RamUsage({required this.totalGb, required this.usedGb});

  factory RamUsage.fromJson(Map<String, dynamic> json) {
    return RamUsage(
      totalGb: json['Total GB'],
      usedGb: json['Used GB'],
    );
  }
}

class DiskUsage {
  final double totalGb;
  final double usedGb;
  final String drive;

  DiskUsage({required this.totalGb, required this.usedGb, required this.drive});

  factory DiskUsage.fromJson(Map<String, dynamic> json) {
    return DiskUsage(
      totalGb: json['Total GB'],
      usedGb: json['Used GB'],
      drive: json['drive'],
    );
  }
}

class NetworkInterface {
  final String address;
  final String? netmask;
  final String? broadcast;

  NetworkInterface({required this.address, this.netmask, this.broadcast});

  factory NetworkInterface.fromJson(Map<String, dynamic> json) {
    return NetworkInterface(
      address: json['address'],
      netmask: json['netmask'],
      broadcast: json['broadcast'],
    );
  }
}
