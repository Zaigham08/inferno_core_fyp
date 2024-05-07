import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';

class TaskManagerPage extends StatelessWidget {
  const TaskManagerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding - 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyText('Processes:', fontSize: 23),
              5.ph,
              Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  _buildTableRow(['P id', 'Name', 'CPU', 'Ram', ''],
                      isHeading: true),
                  _buildTableRow(
                      ['1', 'VLC Media Player', '5%', '400 MB', _addBtn()]),
                  _buildTableRow(
                      ['2', 'Google Chrome', '20%', '800 MB', _addBtn()]),
                  _buildTableRow(
                      ['3', 'Adobe Acrobat Reader', '2%', '100 MB', _addBtn()]),
                  _buildTableRow(['4', 'Skype', '1%', '50 MB', _addBtn()]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _addBtn() {
  return InkWell(
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.red,
      ),
      child: const Center(
        child: Icon(Icons.delete, size: 26),
      ),
    ),
  );
}

TableRow _buildTableRow(List<dynamic> data, {bool isHeading = false}) {
  final List<Widget> cells = data
      .map((cellData) {
        if (cellData is String) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
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
            padding: const EdgeInsets.all(6.5),
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
