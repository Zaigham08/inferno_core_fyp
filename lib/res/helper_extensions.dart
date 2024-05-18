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

extension DoubleExtension on double {
  double roundOff(int decimalPlaces) {
    double mod = 10.0 * decimalPlaces;
    return ((this * mod).round().toDouble() / mod);
  }
}

extension PercentageParsing on String {
  double toPercentageValue() {
    final regex = RegExp(r'(\d+(\.\d+)?)');
    final match = regex.firstMatch(this);
    if (match != null) {
      return double.parse(match.group(0)!);
    }
    throw const FormatException("No percentage value found in the string");
  }
}


