import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/widgets/general widgets/my_text.dart';

class SystemFiles extends StatelessWidget {
  SystemFiles({Key? key}) : super(key: key);

  final List<FileItemModel> files = [
    FileItemModel(items: 1, name: "Folder 1", isFolder: true),
    FileItemModel(items: 3, name: "Folder 2", isFolder: true),
    FileItemModel(items: 5, name: "File 1", isFolder: false),
    FileItemModel(items: 2, name: "Folder 3", isFolder: true),
    FileItemModel(items: 2, name: "Folder 4", isFolder: true),
    FileItemModel(items: 8, name: "File 2", isFolder: false),
    FileItemModel(items: 16, name: "File 3", isFolder: false),
    FileItemModel(items: 11, name: "File 4", isFolder: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("System Files"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: 6),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: files.length,
            itemBuilder: (context, index) {
              return FileItem(
                name: files[index].name,
                items: files[index].items,
                isFolder: files[index].isFolder,
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
  final int items;
  final bool isFolder;

  const FileItem({super.key, required this.isFolder, required this.name, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Icon(isFolder ? Icons.folder : Icons.insert_drive_file, size: 31),
          20.pw,
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
                if(isFolder)
                MyText(
                  "$items items",
                  fontSize: 13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FileItemModel {
  final String name;
  final int items;
  final bool isFolder;

  FileItemModel({required this.isFolder, required this.name, required this.items});
}
