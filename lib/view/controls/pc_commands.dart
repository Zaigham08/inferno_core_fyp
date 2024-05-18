import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/widgets/button components/icon_text_btn.dart';
import '../../utils/utils.dart';
import '../../view models/controllers/io_attacker_controller.dart';

class PcCommandsPage extends StatelessWidget {
  final String targetId;

  const PcCommandsPage({super.key, required this.targetId});

  @override
  Widget build(BuildContext context) {
    IoAttackerController ioAttackerController = Get.put(IoAttackerController());
    return Scaffold(
      appBar: AppBar(title: const Text("PC Commands"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconTextBtn(
                  btnText: "Restart",
                  icon: Icons.restart_alt,
                  height: 120,
                  onTap: () {
                    ioAttackerController.submitCommand(
                      targetId: targetId,
                      data: {
                        "text": "RESTART",
                        "command_args": {}
                      },
                    );
                  },
                ),
                IconTextBtn(
                  btnText: "Shutdown",
                  icon: CupertinoIcons.power,
                  height: 120,
                  onTap: () {
                    ioAttackerController.submitCommand(
                      targetId: targetId,
                      data: {
                        "text": "SHUTDOWN",
                        "command_args": {}
                      },
                    );
                  },
                ),
                IconTextBtn(
                  btnText: "Freeze",
                  icon: Icons.pause,
                  height: 120,
                  onTap: () {
                    ioAttackerController.submitCommand(
                      targetId: targetId,
                      data: {
                        "text": "FREEZE_PC",
                        "command_args": {}
                      },
                    );
                  },
                ),
              ],
            ),
            25.ph,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    IconTextBtn(
                      btnText: "Minimize all windows",
                      icon: FontAwesomeIcons.minimize,
                      iconSize: 33,
                      height: 65,
                      isVertical: false,
                      onTap: () {
                        ioAttackerController.submitCommand(
                          targetId: targetId,
                          data: {
                            "text": "MINIMIZE_ALL_WINDOWS",
                            "command_args": {}
                          },
                        );
                      },
                    ),
                    20.ph,
                    IconTextBtn(
                      btnText: "Firewall On/Off",
                      icon: Icons.security,
                      isVertical: false,
                      onTap: () {
                        Utils.toastMsg("Command submitted successfully");
                        // ioAttackerController.submitCommand(
                        //   targetId: targetId,
                        //   data: {
                        //     "text": "LOGOUT",
                        //     "command_args": {}
                        //   },
                        // );
                      },
                    ),
                    20.ph,
                    IconTextBtn(
                      btnText: "Log Off",
                      icon: Icons.exit_to_app_outlined,
                      isVertical: false,
                      onTap: () {
                        ioAttackerController.submitCommand(
                          targetId: targetId,
                          data: {
                            "text": "LOGOUT",
                            "command_args": {}
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
