import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/show_if_empty.dart';

import '../res/constants.dart';
import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/general widgets/my_text.dart';
import '../res/widgets/shimmer widgets/rectangle_shimmer.dart';
import '../view models/controllers/target_controller.dart';

class ExtractedFilesPage extends StatelessWidget {
  const ExtractedFilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TargetController targetController = Get.put(TargetController());
    return Scaffold(
      appBar: myAppBar(title: "Extracted Files"),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding - 5,
          vertical: 10,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => targetController.getAllTargetFiles(),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const MyText("Refresh", fontSize: 16),
                          4.pw,
                          const Icon(
                            Icons.refresh,
                            size: 28,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            5.ph,
            Expanded(
              child: Obx(
                () {
                  if (targetController.loading3.value) {
                    return const RectangleShimmer(
                      height: 56,
                      items: 4,
                      radius: 6,
                    );
                  } else if (targetController.targetFiles.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: targetController.targetFiles.length,
                      itemBuilder: (context, index) {
                        return FileItem(
                          name: targetController.targetFiles[index].fileName,
                          targetId:
                              targetController.targetFiles[index].targetId,
                          fileRef:
                              targetController.targetFiles[index].fileReference,
                          extractedFrom:
                              targetController.targetFiles[index].targetName,
                          targetController: targetController,
                        );
                      },
                    );
                  } else {
                    return showIfEmpty("No files extracted");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String name, targetId, fileRef;
  final String extractedFrom;
  final TargetController targetController;

  const FileItem({
    super.key,
    required this.name,
    required this.extractedFrom,
    required this.targetController,
    required this.targetId,
    required this.fileRef,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          const Icon(Icons.insert_drive_file, size: 32),
          15.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  name,
                  fontSize: 17.5,
                  overflow: TextOverflow.ellipsis,
                ),
                2.ph,
                MyText(
                  "Extracted from:  $extractedFrom",
                  fontSize: 13,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          5.pw,
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
                            leading: const Icon(Icons.download),
                            title: const Text(
                              'Download',
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () {
                              Get.back();
                              targetController.targetFileDownload(
                                targetId: targetId,
                                fileRef: fileRef,
                                fileName: name,
                              );
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.delete),
                            title: const Text(
                              'Delete',
                              style: TextStyle(
                                color: txtColor,
                                fontSize: 17,
                              ),
                            ),
                            onTap: () {
                              Get.back();
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

class ExtractedFilesModel {
  final String name;
  final String extractedFrom;

  ExtractedFilesModel({required this.extractedFrom, required this.name});
}
