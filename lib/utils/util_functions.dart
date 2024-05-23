import 'package:url_launcher/url_launcher.dart';

launchEmail(String toEmail, String subject) async {
  final url =
  Uri.parse('mailto:$toEmail?subject=${Uri.encodeComponent(subject)}');
  await launchUrl(url);
}
