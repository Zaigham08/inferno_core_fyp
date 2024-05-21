import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/rich_texts.dart';

import '../../models/hardware_info_model.dart';
import '../../res/constants.dart';
import '../../view models/controllers/general_controller.dart';

class HardwareInfoPage extends StatefulWidget {
  final String targetId;

  const HardwareInfoPage({super.key, required this.targetId});

  @override
  State<HardwareInfoPage> createState() => _HardwareInfoPageState();
}

class _HardwareInfoPageState extends State<HardwareInfoPage> {
  GeneralController generalController = Get.put(GeneralController());

  @override
  void initState() {
    if(generalController.cpuUsage.value == 0.0) {
      generalController.getHardwareInfo(widget.targetId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hardware Info"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => generalController.getHardwareInfo(widget.targetId),
            child: const Icon(Icons.refresh, size: 30),
          ),
          14.pw,
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HeadingText(text: "Ram Usage :"),
                    ramCircularIndicator(),
                  ],
                ),
                30.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const HeadingText(text: "CPU Usage :"),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * .54,
                          child: LinearProgressIndicator(
                            value: generalController.cpuUsage.value / 100,
                            minHeight: 18,
                            backgroundColor: Colors.grey.withOpacity(.5),
                            borderRadius: BorderRadius.circular(5),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue),
                          ),
                        ),
                        2.ph,
                        MyText(
                            "${generalController.cpuUsage.value.toString()} %",
                            fontSize: 17),
                      ],
                    ),
                  ],
                ),
                15.ph,
                const HeadingText(text: "Disk Usage :"),
                8.ph,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generalController.hardwareInfo.value.diskUsage
                      .map((disk) {
                    return DiskUsageWidget(disk: disk);
                  }).toList(),
                ),
                15.ph,
                Row(
                  children: [
                    const HeadingText(text: "Boot Time :   "),
                    MyText(generalController.hardwareInfo.value.bootTime,
                        fontSize: 16),
                  ],
                ),
                15.ph,
                Row(
                  children: [
                    const HeadingText(text: "Battery Information :  "),
                    Flexible(
                        child: MyText(
                            generalController.hardwareInfo.value.battery,
                            fontSize: 16)),
                  ],
                ),
                15.ph,
                const HeadingText(text: "Network Interfaces :"),
                10.ph,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: generalController
                      .hardwareInfo.value.networkInterfaces.entries
                      .map((entry) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '> ${entry.key} :',
                          style: const TextStyle(
                            fontSize: 16.5,
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        8.ph,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: entry.value.map((interface) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichTexts(
                                    text1: "    -- Address : ",
                                    text2: interface.address),
                                RichTexts(
                                    text1: "    -- Netmask : ",
                                    text2: interface.netmask ?? 'N/A'),
                                RichTexts(
                                    text1: "    -- Broadcast : ",
                                    text2: interface.broadcast ?? 'N/A'),
                                10.ph,
                              ],
                            );
                          }).toList(),
                        ),
                        10.ph,
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding ramCircularIndicator() {
    return Padding(
      padding: const EdgeInsets.only(right: 40),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              value: generalController.usedRam.value /
                  generalController.totalRam.value,
              backgroundColor: Colors.grey.withOpacity(.5),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              strokeWidth: 10,
            ),
          ),
          Row(
            children: [
              SizedBox(
                width: 32,
                child: Column(
                  children: [
                    MyText(
                      '${generalController.usedRam.value}',
                      fontSize: 16,
                      color: txtColor,
                    ),
                    const Divider(color: Colors.white, thickness: 2),
                    MyText(
                      '${generalController.totalRam.value}',
                      fontSize: 16,
                      color: txtColor,
                    ),
                  ],
                ),
              ),
              5.pw,
              const MyText("GB   ", fontSize: 16),
            ],
          ),
        ],
      ),
    );
  }
}

class DiskUsageWidget extends StatelessWidget {
  final DiskUsage disk;

  const DiskUsageWidget({
    super.key,
    required this.disk,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            "Local Disk (${disk.drive.replaceAll(r'\', '')})",
            fontSize: 15.5,
          ),
          2.ph,
          LinearProgressIndicator(
            value: disk.usedGb / disk.totalGb,
            minHeight: 18,
            backgroundColor: Colors.grey.withOpacity(.5),
            borderRadius: BorderRadius.circular(5),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          2.ph,
          MyText(
            "${(disk.totalGb - disk.usedGb).roundOff(2)} GB free of ${disk.totalGb.roundOff(2)} GB",
            fontSize: 15.5,
          ),
        ],
      ),
    );
  }
}

class HeadingText extends StatelessWidget {
  final String text;

  const HeadingText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return MyText(
      text,
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
  }
}
