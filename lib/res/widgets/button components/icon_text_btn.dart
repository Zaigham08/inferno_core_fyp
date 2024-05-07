import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../constants.dart';
import '../general widgets/my_text.dart';

class IconTextBtn extends StatelessWidget {
  final String btnText;
  final IconData icon;
  final VoidCallback onTap;
  final double iconSize, textSize;
  final double? width, height;
  final bool isVertical;

  const IconTextBtn({
    super.key,
    required this.btnText,
    required this.icon,
    required this.onTap,
    this.iconSize = 40,
    this.textSize = 17,
    this.isVertical = true,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: whiteColor, width: 2),
        ),
        child: Center(
          child: isVertical
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: iconSize),
                    8.ph,
                    MyText(
                      btnText,
                      fontSize: textSize,
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: iconSize - 5),
                    10.pw,
                    MyText(
                      btnText,
                      fontSize: textSize,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
