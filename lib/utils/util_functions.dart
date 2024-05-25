import 'package:firebase_auth/firebase_auth.dart';
import 'package:inferno_core_fyp/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';

launchEmail(String toEmail, String subject) async {
  final url =
  Uri.parse('mailto:$toEmail?subject=${Uri.encodeComponent(subject)}');
  await launchUrl(url);
}

String constructWebSocketUrl(String baseUrl, Map<String, String> params) {
  Uri uri = Uri.parse(baseUrl);
  Uri updatedUri = uri.replace(queryParameters: params);
  return updatedUri.toString();
}

Future<String?> getIdToken() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    return await user.getIdToken();
  }
  else {
    Utils.toastMsg('User not logged in');
    return null;
  }
}