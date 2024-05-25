import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/button%20components/my_text_btn.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';

import '../res/constants.dart';

class ShowFile extends StatelessWidget {
  final Uint8List? fileBytes;
  final VoidCallback onPressed, onPressedShared;
  final String appBarTitle;
  final String? text, imgPath;
  final bool isImage;

  const ShowFile({
    super.key,
    this.fileBytes,
    required this.onPressed,
    required this.onPressedShared,
    required this.appBarTitle,
    this.text,
    this.imgPath,
    this.isImage = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(appBarTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
            vertical: kDefaultPadding, horizontal: 10),
        child: Column(
          children: [
            15.ph,
            Center(
              child: isImage
                  ? Image.memory(fileBytes!)
                  : Column(
                      children: [
                        Text(
                          text!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        20.ph,
                        Image.asset(
                          imgPath!,
                          height: 120,
                        ),
                      ],
                    ),
            ),
            70.ph,
            MyTextButton(
              text: "Download",
              onPressed: onPressed,
              width: 170,
            ),
            18.ph,
            MyTextButton(
              text: "Share",
              onPressed: onPressedShared,
              width: 170,
            ),
            20.ph,
          ],
        ),
      ),
    );
  }
}
