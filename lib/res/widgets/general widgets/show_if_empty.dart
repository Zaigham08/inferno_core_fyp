import 'package:flutter/material.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../constants.dart';

Center showIfEmpty(String text) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: txtColor.withOpacity(.5),
          size: 56,
        ),
        5.ph,
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: txtColor.withOpacity(.5),
          ),
        ),
      ],
    ),
  );
}