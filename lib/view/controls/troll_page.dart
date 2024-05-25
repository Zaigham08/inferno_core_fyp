import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/utils/utils.dart';
import 'package:inferno_core_fyp/view%20models/controllers/general_controller.dart';
import 'package:inferno_core_fyp/view%20models/controllers/io_attacker_controller.dart';
import 'package:inferno_core_fyp/view/controls_panel.dart';

import '../../res/widgets/general widgets/command_item.dart';

class TrollPage extends StatelessWidget {
  final String targetId;

  const TrollPage({super.key, required this.targetId});

  @override
  Widget build(BuildContext context) {
    IoAttackerController ioAttackerController = Get.put(IoAttackerController());
    GeneralController generalController = Get.put(GeneralController());
    return Scaffold(
      appBar: AppBar(title: const Text("Troll Page"), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            children: [
              14.ph,
              const Center(
                child: Icon(
                  FontAwesomeIcons.masksTheater,
                  size: 160,
                ),
              ),
              5.ph,
              CommandSection(
                sectionName: "Troll Commands",
                mainAxisExtent: 100,
                maxCrossAxisExtent: 150,
                items: [
                  CommandItem(
                    text: "Show Msg\nBox",
                    icon: FontAwesomeIcons.commentDots,
                    onTap: () {
                      Utils.showTextFieldDialog(
                        title: "Enter Message to send",
                        hintText: "Message..",
                        controller: generalController.commonController.value,
                        onTap: () {
                          Get.back();
                          ioAttackerController.submitCommand(
                            targetId: targetId,
                            data: {
                              "text": "SHOW_MESSAGE_BOX",
                              "command_args": {
                                "title": "Message Box",
                                "message": generalController
                                    .commonController.value.text
                                    .trim(),
                              }
                            },
                          );
                          generalController.commonController.value.clear();
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Open\nCamera",
                    icon: FontAwesomeIcons.camera,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {"text": "OPEN_CAMERA_APP", "command_args": {}},
                      );
                    },
                  ),
                  CommandItem(
                    text: "Show\nWebsite",
                    icon: FontAwesomeIcons.globe,
                    onTap: () {
                      Utils.showTextFieldDialog(
                        title: "Enter Url of the website",
                        hintText: "Url..",
                        controller: generalController.commonController.value,
                        onTap: () {
                          Get.back();
                          ioAttackerController.submitCommand(
                            targetId: targetId,
                            data: {
                              "text": "SHOW_WEBSITE",
                              "command_args": {
                                "url": generalController
                                    .commonController.value.text
                                    .trim(),
                                "blocktime": 10,
                              }
                            },
                          );
                          generalController.commonController.value.clear();
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Eject\nCD",
                    icon: FontAwesomeIcons.compactDisc,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {"text": "EJECT_CD", "command_args": {}},
                      );
                    },
                  ),
                  CommandItem(
                    text: "Eject CD Continuously",
                    icon: FontAwesomeIcons.compactDisc,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {
                          "text": "EJECT_CD_CONTINOUS",
                          "command_args": {}
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Stop CD\nEjector",
                    icon: FontAwesomeIcons.circleStop,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {"text": "STOP_CD_EJECTOR", "command_args": {}},
                      );
                    },
                  ),
                  CommandItem(
                    text: "Send Msg in Notepad",
                    icon: FontAwesomeIcons.keyboard,
                    onTap: () {
                      Utils.showTextFieldDialog(
                        title: "Enter Message to send",
                        hintText: "Message..",
                        controller: generalController.commonController.value,
                        onTap: () {
                          Get.back();
                          ioAttackerController.submitCommand(
                            targetId: targetId,
                            data: {
                              "text": "TYPE_MESSAGE_NOTEPAD",
                              "command_args": {
                                "message": generalController
                                    .commonController.value.text
                                    .trim(),
                                "blocktime": 10,
                              }
                            },
                          );
                          generalController.commonController.value.clear();
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Block\nMouse",
                    icon: FontAwesomeIcons.ban,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {"text": "BLOCK", "command_args": {}},
                      );
                    },
                  ),
                  CommandItem(
                    text: "Unblock\nMouse",
                    icon: FontAwesomeIcons.computerMouse,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {"text": "UNBLOCK", "command_args": {}},
                      );
                    },
                  ),
                  CommandItem(
                    text: "Start Window Troll",
                    icon: FontAwesomeIcons.play,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {
                          "text": "START_WINDOW_TROLL",
                          "command_args": {}
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Stop Window Troll",
                    icon: FontAwesomeIcons.stop,
                    onTap: () {
                      ioAttackerController.submitCommand(
                        targetId: targetId,
                        data: {
                          "text": "STOP_WINDOW_TROLL",
                          "command_args": {}
                        },
                      );
                    },
                  ),
                  CommandItem(
                    text: "Run Script",
                    icon: FontAwesomeIcons.code,
                    onTap: () {
                      Utils.showDropdownDialog(
                        title: "Enter script to run",
                        items: generalController.scriptNames,
                        value: generalController.selectedScript.value,
                        onValueChanged: (val) {
                          generalController.selectedScript.value = val!;
                        },
                        onTap: () {
                          Get.back();
                          ioAttackerController.submitCommand(
                            targetId: targetId,
                            data: {
                              "text": "RUN_TROLL_SCRIPT",
                              "command_args": {
                                "scriptName":
                                    generalController.selectedScript.value,
                                "blocktime": 10,
                              }
                            },
                          );
                        },
                      );
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
