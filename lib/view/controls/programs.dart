import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view/controls/task_manager.dart';

import '../../utils/utils.dart';
import '../../view models/controllers/general_controller.dart';
import '../../view models/controllers/io_attacker_controller.dart';

class Programs extends StatefulWidget {
  final String targetId;

  const Programs({super.key, required this.targetId});

  @override
  State<Programs> createState() => _ProgramsState();
}

class _ProgramsState extends State<Programs> {
  GeneralController generalController = Get.put(GeneralController());
  IoAttackerController ioAttackerController = Get.put(IoAttackerController());

  @override
  void initState() {
    if (generalController.programs.isEmpty) {
      generalController.getPrograms(widget.targetId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Programs"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding - 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText('Programs:', fontSize: 23),
                GestureDetector(
                  onTap: () => generalController.getPrograms(widget.targetId),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.refresh,
                        size: 30,
                        color: Colors.yellow,
                      ),
                      MyText(
                        "Refresh ",
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.ph,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Obx(
                  () => Table(
                    border: TableBorder.all(color: Colors.white),
                    columnWidths: const {
                      0: FlexColumnWidth(3.5),
                      1: FlexColumnWidth(2.7),
                      2: FlexColumnWidth(1.8),
                      3: FlexColumnWidth(1.3),
                    },
                    children: [
                      buildTableRow(['Name', 'Publisher', 'Version', ''],
                          isHeading: true),
                      for (var program in generalController.programs) ...[
                        buildTableRow(
                          [
                            program.name,
                            program.publisher,
                            program.version,
                            _addBtn(onTap: () {
                              Utils.showDeleteConfirmationDialog(
                                title: "Uninstall",
                                text: "Are you sure you want to uninstall?",
                                onConfirm: () {
                                  Utils.toastMsg(
                                      "function implemented but commented out");
                                  //ioAttackerController.submitCommand(
                                  //   targetId: widget.targetId,
                                  //   data: {
                                  //     "text": 'RUN_UNINSTALLER',
                                  //     "command_args": {
                                  //       "uninstall_string": program.uninstallString
                                  //     },
                                  //   },
                                  // ),
                                  Get.back();
                                },
                                onCancel: () => Get.back(),
                                confirmBtnTxt: "Uninstall"
                              );
                            }
                                ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addBtn({required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: const Icon(
        Icons.delete_forever_outlined,
        size: 28,
        color: Colors.red,
      ),
    );
  }
}
