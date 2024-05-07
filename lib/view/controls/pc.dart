import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';

import '../../res/widgets/button components/icon_text_btn.dart';

class PC extends StatelessWidget {
  const PC({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PC"), centerTitle: true),
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
                  onTap: () {},
                ),
                IconTextBtn(
                  btnText: "Shutdown",
                  icon: CupertinoIcons.power,
                  height: 120,
                  onTap: () {},
                ),
                IconTextBtn(
                  btnText: "Freeze",
                  icon: Icons.pause,
                  height: 120,
                  onTap: () {},
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
                      onTap: () {},
                    ),
                    20.ph,
                    IconTextBtn(
                      btnText: "Firewall On/Off",
                      icon: Icons.security,
                      isVertical: false,
                      onTap: () {},
                    ),
                    20.ph,
                    IconTextBtn(
                      btnText: "Log Off",
                      icon: Icons.exit_to_app_outlined,
                      isVertical: false,
                      onTap: () {},
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

