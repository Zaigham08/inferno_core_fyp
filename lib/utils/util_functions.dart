import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void navigateToPage(BuildContext? context, Widget page) {
  Navigator.push(
    context!,
    MaterialPageRoute(builder: (context) => page),
  );
}

launchEmail(String toEmail, String subject) async {
  final url =
  Uri.parse('mailto:$toEmail?subject=${Uri.encodeComponent(subject)}');
  await launchUrl(url);
}
