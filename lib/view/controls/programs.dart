import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';

class Programs extends StatelessWidget {
  const Programs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Programs"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding - 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyText('Programs:', fontSize: 23),
              7.ph,
              Table(
                border: TableBorder.all(color: Colors.white),
                children: [
                  _buildTableRow(['Name', 'Publisher', 'Version', ''], isHeading: true),
                  _buildTableRow(['VLC Media Player', 'VideoLAN', '3.0.16', _addBtn()]),
                  _buildTableRow(['Google Chrome', 'Google LLC', '99.0.4844.82', _addBtn()]),
                  _buildTableRow(['Adobe Acrobat Reader', 'Adobe Inc.', 'DC 2021', _addBtn()]),
                  _buildTableRow(['Skype', 'Microsoft Corporation', '8.80.0.178', _addBtn()]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addBtn() {
    return MyTextButton(
      text: "Uninstall",
      height: 30,
      radius: 4,
      btnTxtSize: 13,
      onPressed: () {},
    );
  }

  TableRow _buildTableRow(List<dynamic> data, {bool isHeading = false}) {
    final List<Widget> cells = data
        .map((cellData) {
          if (cellData is String) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  cellData,
                  style: TextStyle(
                    color: isHeading ? Colors.yellow : whiteColor,
                    fontWeight: isHeading ? FontWeight.bold : null,
                  ),
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
}
