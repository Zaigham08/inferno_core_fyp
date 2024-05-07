import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../res/constants.dart';
import '../res/widgets/appBar components/my_appbar.dart';
import '../res/widgets/general widgets/my_text.dart';

class ExtractedFilesPage extends StatelessWidget {
  ExtractedFilesPage({super.key});

  final List<ExtractedFilesModel> files = [
    ExtractedFilesModel(name: "File 1", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 2", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 3", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 4", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 5", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 6", extractedFrom: "Zain Pc"),
    ExtractedFilesModel(name: "File 7", extractedFrom: "Zain Pc"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: "Extracted Files"),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding - 5, vertical: 10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) {
              return FileItem(
                name: files[index].name,
                extractedFrom: files[index].extractedFrom,
              );
            },
          ),
        ),
      ),
    );
  }
}

class FileItem extends StatelessWidget {
  final String name;
  final String extractedFrom;

  const FileItem({super.key, required this.name, required this.extractedFrom});

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
            child: const Icon(Icons.more_vert_outlined)
          ),
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
