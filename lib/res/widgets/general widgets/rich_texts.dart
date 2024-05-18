import 'package:flutter/material.dart';
import '../../constants.dart'; // Import your SignUpPage

class RichTexts extends StatelessWidget {
  final String text1, text2;
  final double fontSize;
  final Color text1Color, text2Color;
  final bool isText1Bold;

  const RichTexts({
    super.key,
    required this.text1,
    required this.text2,
    this.fontSize = 15.5,
    this.text1Color = txtColor,
    this.text2Color = txtColor,
    this.isText1Bold = true,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text1,
        style: TextStyle(
          color: text1Color,
          fontSize: fontSize,
          fontWeight: isText1Bold ? FontWeight.w900 : FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: text2,
            style: TextStyle(
              fontSize: fontSize,
              color: text2Color,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
