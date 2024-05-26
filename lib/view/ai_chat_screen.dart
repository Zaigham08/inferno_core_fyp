import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';
import 'package:share_plus/share_plus.dart';

import '../res/constants.dart';
import '../utils/utils.dart';
import '../view models/controllers/chat_controller.dart';

class ChatScreen extends StatefulWidget {
  final String targetId;

  const ChatScreen({
    super.key,
    required this.targetId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController chatController = Get.put(ChatController());

  @override
  void dispose() {
    super.dispose();
    chatController.promptController.value.clear();
    chatController.isAIResponseInProgress.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Chat with Ai"),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: chatController.messages.length,
                    itemBuilder: (context, index) {
                      return ChatMessages(
                        message: chatController.messages[index],
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.only(
                  bottom: 14,
                  right: kDefaultPadding,
                  left: kDefaultPadding,
                  top: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          controller: chatController.promptController.value,
                          style: const TextStyle(color: txtColor),
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            hintText: "Enter a message",
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                            ),
                            contentPadding: const EdgeInsets.only(left: 10),
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) {
                            chatController.getAiResponse(widget.targetId);
                          }),
                    ),
                    Obx(
                      () => chatController.isAIResponseInProgress.value
                          ? Container(
                              width: 32,
                              height: 32,
                              padding: const EdgeInsets.all(5),
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : IconButton(
                              onPressed: () {
                                chatController.getAiResponse(widget.targetId);
                              },
                              color: Colors.grey.shade500,
                              icon: const Icon(
                                Icons.send,
                                size: 30,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

class ChatMessages extends StatelessWidget {
  final ChatMessageModel message;
  final ChatController chatController = Get.put(ChatController());

  ChatMessages({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: message.sender == 'user'
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (message.sender == 'bot')
                SvgPicture.asset(
                  "assets/icons/robot_icon.svg",
                  height: 45,
                  fit: BoxFit.fitWidth,
                ),
              Flexible(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: Get.width * .75,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MyText(
                      message.text,
                      color: txtColor,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (message.sender == 'bot')
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.width * .125,
                ),
                buildContainer(
                  icon: Icons.copy,
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: message.text));
                    Utils.toastMsg("Copied to clipboard");
                  },
                ),
                10.pw,
                buildContainer(
                  icon: Icons.share,
                  onTap: () => Share.share(message.text),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Container buildContainer({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: GestureDetector(
          onTap: onTap,
          child: Icon(
            icon,
            size: 18,
            color: whiteColor,
          ),
        ),
      ),
    );
  }
}
