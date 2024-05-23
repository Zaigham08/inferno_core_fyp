import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import 'my_text.dart';

class CommandItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Callback onTap;
  final double iconSize;

  const CommandItem({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.iconSize = 28,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Icon(icon, size: iconSize),
          8.ph,
          Expanded(child: MyText(text, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
