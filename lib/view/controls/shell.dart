import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

import '../../res/widgets/general widgets/my_text.dart';
import '../../view models/controllers/general_controller.dart';

class Shell extends StatefulWidget {
  final String targetId;

  const Shell({super.key, required this.targetId});

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  String sessionId = '';
  final generalController = GeneralController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    var uuid = const Uuid();
    sessionId = uuid.v4();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Shell"), centerTitle: true),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(11),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      generalController.maxLines.value = 1;
                      generalController.commonController.value.clear();
                    },
                    child: const MyText(
                      "Clear  ",
                      fontSize: 16,
                      color: Colors.yellow,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.yellow,
                    ),
                  ),
                ],
              ),
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: MyText("> ", fontSize: 24),
                    ),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: generalController.commonController.value,
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: generalController.maxLines.value == 2
                              ? null
                              : generalController.maxLines.value,
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          cursorColor: Colors.white,
                          autofocus: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "";
                            }
                            return null;
                          },
                          onFieldSubmitted: (_) {
                            if (_formKey.currentState!.validate()) {
                              generalController.runShellCommand(
                                  widget.targetId, sessionId);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
