import 'package:flutter/material.dart';

import 'my_text.dart';

Padding dotsSeparatedStrings({required String t1, required String t2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: MyText(
      "$t1 :  $t2",
      fontWeight: FontWeight.bold,
      fontSize: 17,
    ),
  );
}