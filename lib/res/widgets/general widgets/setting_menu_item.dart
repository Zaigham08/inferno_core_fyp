import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants.dart';

class SettingMenuItem extends StatelessWidget {
  final String svgIconPath;
  final String title;
  final VoidCallback onPressed;

  const SettingMenuItem({
    super.key,
    required this.title, required this.svgIconPath, required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.5),
          child: InkWell(
            onTap: onPressed,
            child: ListTile(
              leading: SvgPicture.asset(
                svgIconPath,
                height: 28,
              ),
              title: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        const Divider(color: txtColor,height: 8),
      ],
    );
  }
}
