import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/constants.dart';
import '../../view models/controllers/general_controller.dart';

class HardwareInfoPage extends StatefulWidget {
  final String targetId;

  const HardwareInfoPage({super.key, required this.targetId});

  @override
  State<HardwareInfoPage> createState() => _HardwareInfoPageState();
}

class _HardwareInfoPageState extends State<HardwareInfoPage> {
  final generalController = GeneralController();

  @override
  void initState() {
    generalController.getHardwareInfo(widget.targetId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Hardware Info"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Obx(
            () => Column(
              children: [
                Text(
                  generalController.hardwareInfo.value.cpuUsage,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                16.ph,
                Text(
                  'RAM Usage: ${generalController.hardwareInfo.value.ramUsage.usedGb.roundOff(2)} GB / ${generalController.hardwareInfo.value.ramUsage.totalGb.roundOff(2)} GB',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                16.ph,
                const Text(
                  'Disk Usage:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                8.ph,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generalController.hardwareInfo.value.diskUsage
                      .map((disk) {
                    return Text(
                      '${disk.drive} ${disk.usedGb.roundOff(2)} GB (${disk.totalGb.roundOff(2)} GB)\n',
                      style: const TextStyle(fontSize: 16),
                    );
                  }).toList(),
                ),
                16.ph,
                Text(
                  'Boot Time: ${generalController.hardwareInfo.value.bootTime}',
                  style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                16.ph,
                const Text(
                  'Network Interfaces:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                8.ph,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generalController
                      .hardwareInfo.value.networkInterfaces.entries
                      .map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${entry.key}:',
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        8.ph,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: entry.value.map((interface) {
                            return Text(
                              'Address: ${interface.address}\nNetmask: ${interface.netmask ?? 'N/A'}\nBroadcast: ${interface.broadcast ?? 'N/A'}',
                              style: const TextStyle(fontSize: 14.0),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                16.ph,
                Text(
                  'Battery: ${generalController.hardwareInfo.value.battery}',
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
