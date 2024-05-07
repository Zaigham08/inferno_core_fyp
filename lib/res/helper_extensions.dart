import 'package:flutter/cupertino.dart';

extension Pading on num{

  SizedBox get ph => SizedBox(height: toDouble(),);
  SizedBox get pw => SizedBox(width: toDouble(),);

}

extension StringFilePathExtension on String {
  String extractFileName() {
    List<String> parts = split('/');  // Split the path by '/'

    String fileNameWithExtension = parts.last;  // Get the last part, which should be the filename

    return fileNameWithExtension;
  }
}

