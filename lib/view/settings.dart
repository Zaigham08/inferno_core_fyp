import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../res/widgets/general widgets/setting_menu_item.dart';
import '../utils/util_functions.dart';
import '../utils/utils.dart';
import '../view models/controllers/user_controller.dart';
import 'auth/login_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    userController.fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const MyText("Settings"),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            8.ph,
            ListTile(
              leading: const CircleAvatar(
                radius: 23,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 33,
                ),
              ),
              title: Obx(
                () => Row(
                  children: [
                    SizedBox(
                      width: 250,
                      child: Text(
                        userController.userEmail.value,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              subtitle: Obx(
                () => Text(
                  "UserId: ${userController.userId.value}",
                  style: const TextStyle(
                    fontSize: 11.5,
                  ),
                ),
              ),
              trailing: InkWell(
                onTap: () {
                  Clipboard.setData(
                      ClipboardData(text: userController.userId.value));
                  Utils.toastMsg("User id copied to the clipboard");
                },
                child: const Icon(
                  Icons.copy,
                ),
              ),
            ),
            20.ph,
            SettingMenuItem(
              title: 'Rate our App',
              svgIconPath: 'assets/icons/star1.svg',
              onPressed: () {
                launchUrl(Uri.parse(
                    "https://play.google.com/store/apps/details?id=com.ainnovate.academiaii"));
              },
            ),
            SettingMenuItem(
              title: 'Share our App',
              svgIconPath: 'assets/icons/Export.svg',
              onPressed: () {
                Share.share(
                    "🚀 Discover Academi.AI - Your Ultimate Study Companion!"
                    " 📚\n\nUnlock the power of advanced AI for more effective and "
                    " personalized studying. Download now "
                    "at:\n https://play.google.com/store/apps/details?id=com.ainnovate.academiaii\n"
                    "📲 #AcademiAI #StudySmart");
              },
            ),
            SettingMenuItem(
              title: 'Privacy Policy',
              svgIconPath: 'assets/icons/Lock.svg',
              onPressed: () {
                launchUrl(
                    Uri.parse("https://sites.google.com/view/academiai/home"));
              },
            ),
            SettingMenuItem(
              title: 'Contact Us',
              svgIconPath: 'assets/icons/Phone.svg',
              onPressed: () {
                launchEmail('Info@academiai.org', 'Feedback/Inquiry');
              },
            ),
            SettingMenuItem(
              title: 'Log out',
              svgIconPath: 'assets/icons/off_icon.svg',
              onPressed: () {
                // GoogleSignIn().disconnect();
                auth.signOut().then((response) {
                  Get.offAll(() => LoginPage());
                  Utils.toastMsg("Logged out Successfully");
                }).onError((error, stackTrace) {
                  Utils.toastMsg(error.toString());
                });
              },
            ),
            50.ph,
          ],
        ),
      ),
    );
  }
}
