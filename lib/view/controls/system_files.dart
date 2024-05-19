import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/show_if_empty.dart';
import 'package:inferno_core_fyp/view%20models/controllers/io_attacker_controller.dart';
import 'package:uuid/uuid.dart';

import '../../res/widgets/general widgets/my_text.dart';
import '../../res/widgets/shimmer widgets/rectangle_shimmer.dart';
import '../../view models/controllers/general_controller.dart';

class SystemFiles extends StatefulWidget {
  final String targetId;

  const SystemFiles({super.key, required this.targetId});

  @override
  State<SystemFiles> createState() => _SystemFilesState();
}

class _SystemFilesState extends State<SystemFiles> {
  final generalController = GeneralController();
  final ioAttackerController = IoAttackerController();
  String sessionId = '';

  @override
  void initState() {
    var uuid = const Uuid();
    sessionId = uuid.v4();
    generalController.getCurrentDirAndFiles(widget.targetId, sessionId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("System Files"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => MyText(
                generalController.currentDir.value,
                fontSize: 15,
              ),
            ),
            const Divider(),
            5.ph,
            Expanded(
              child: Obx(() {
                if (generalController.loading.value) {
                  return const RectangleShimmer(
                    height: 60,
                    items: 3,
                    radius: 6,
                  );
                } else if (generalController.files.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: generalController.files.length,
                    itemBuilder: (context, index) {
                      return FileItem(
                        name: generalController.files[index].name,
                        targetId: widget.targetId,
                        sessionId: sessionId,
                        ioAttackerController: ioAttackerController,
                        generalController: generalController,
                        isFolder:
                            generalController.files[index].type == "folder",
                      );
                    },
                  );
                } else {
                  return showIfEmpty("This directory don't have any files");
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String name, targetId, sessionId;
  final bool isFolder;
  final GeneralController generalController;
  final IoAttackerController ioAttackerController;

  const FileItem({
    super.key,
    required this.name,
    required this.isFolder,
    required this.targetId,
    required this.sessionId,
    required this.ioAttackerController,
    required this.generalController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(
            isFolder ? Icons.folder : Icons.insert_drive_file,
            size: 32,
            color: isFolder ? Colors.blue : null,
          ),
          18.pw,
          Expanded(
            child: MyText(
              name,
              fontSize: 17.5,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          2.pw,
          InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      height: Get.height * .2,
                      child: Column(
                        children: [
                          8.ph,
                          Container(
                              height: 4,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              )),
                          10.ph,
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text(
                              'Delete',
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () async {
                              Get.back();
                              await ioAttackerController.submitCommand(
                                targetId: targetId,
                                data: {
                                  "text": isFolder
                                      ? "DELETE_FOLDER"
                                      : "DELETE_FILE",
                                  "command_args": {
                                    "session_id": sessionId,
                                    "path": name
                                  }
                                },
                              );
                              generalController.getFilesInDirectory(targetId, sessionId);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.save),
                            title: const Text(
                              'Save',
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () async {
                              Get.back();
                              await ioAttackerController.submitCommand(
                                targetId: targetId,
                                data: {
                                  "text": "UPLOAD_FILE",
                                  "command_args": {
                                    "file_path": "${generalController.currentDir.value}\\$name"
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.more_vert_outlined)),
        ],
      ),
    );
  }
}
