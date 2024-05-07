import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../constants.dart';

class ImageTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double height, width;
  final String imgPath, txt;

  const ImageTextButton({
    super.key,
    required this.onPressed,
    this.height = 50,
    this.width = 450,
    required this.imgPath, required this.txt,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: textFieldColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imgPath,
              height: 24,
              width: 24,
            ),
            20.pw,
            Text(
              txt,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
