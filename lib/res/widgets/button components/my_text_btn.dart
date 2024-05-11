import 'package:flutter/material.dart';

import '../../constants.dart';

class MyTextButton extends StatelessWidget {
  final String text;
  final double? width, height;
  final double btnTxtSize, radius;
  final double? spacing;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color buttonColor;

  const MyTextButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height = 47,
    this.buttonColor = btnColor,
    this.isLoading = false,
    this.btnTxtSize = 15,
    this.radius = 10,
    this.spacing,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height,
        width: width,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: whiteColor,
                  strokeWidth: 3,
                )
              : Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: btnTxtSize,
                    fontWeight: FontWeight.w600,
                    color: whiteColor,
                    letterSpacing: spacing,
                  ),
                ),
        ),
      ),
    );
  }
}
