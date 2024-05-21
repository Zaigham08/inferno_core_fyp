import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../view models/controllers/general_controller.dart';

class TrollPage extends StatefulWidget {
  final String targetId;

  const TrollPage({super.key, required this.targetId});

  @override
  State<TrollPage> createState() => _AccountsState();
}

class _AccountsState extends State<TrollPage> {
  GeneralController generalController = Get.put(GeneralController());

  @override
  void initState() {
    generalController.getSystemInfo(widget.targetId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("TrollPage"), centerTitle: true),
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
              const Divider(thickness: 2),
            ],
          ),
        ),
      ),
    );
  }
}
