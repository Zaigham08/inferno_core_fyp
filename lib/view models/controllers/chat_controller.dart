import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/repository/target_repository.dart';

import '../../utils/utils.dart';

class ChatController extends GetxController {
  final _repo = TargetRepository();
  final promptController = TextEditingController().obs;
  String userMessage = "";
  RxList<ChatMessageModel> messages = <ChatMessageModel>[].obs;
  List<List<String>> chatHistory = [];
  RxBool isAIResponseInProgress = false.obs;

  Future getAiResponse(String targetId) async {
    userMessage = promptController.value.text.trim();
    if (userMessage.isNotEmpty) {
      if (isAIResponseInProgress.value) {
        Utils.toastMsg('Please wait for the previous response to complete.');
        return;
      }
      ChatMessageModel message =
          ChatMessageModel(text: userMessage, sender: "user");
      messages.add(message);
      promptController.value.clear();
      isAIResponseInProgress.value = true;
      try {
        Map data = {
          "target_id": targetId,
          "prompt": userMessage,
          "chat_history": chatHistory,
        };
        Map<String, dynamic> response = await _repo.getAiResponse(data);
        isAIResponseInProgress.value = false;
        String aiResponse = response["output"];

        ChatMessageModel botMessage =
            ChatMessageModel(text: aiResponse, sender: "bot");
        messages.add(botMessage);
        chatHistory.add([userMessage, aiResponse]);
      } catch (error) {
        isAIResponseInProgress.value = false;
        Utils.toastMsg("Error: $error");
      }
    }
  }
}

class ChatMessageModel {
  final String text;
  final String sender;

  ChatMessageModel({required this.text, required this.sender});
}
