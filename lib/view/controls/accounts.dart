import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/res/helper_extensions.dart';
import 'package:inferno_core_fyp/res/widgets/general%20widgets/my_text.dart';

import '../../res/widgets/button components/my_text_btn.dart';
import '../../res/widgets/shimmer widgets/rectangle_shimmer.dart';
import '../../view models/controllers/general_controller.dart';

class Accounts extends StatefulWidget {
  final String targetId;

  const Accounts({super.key, required this.targetId});

  @override
  State<Accounts> createState() => _AccountsState();
}

class _AccountsState extends State<Accounts> {
  GeneralController generalController = Get.put(GeneralController());

  @override
  void initState() {
    if (generalController.accounts.isEmpty) {
      generalController.getAccounts(widget.targetId);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Accounts"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const MyText(
              "User Accounts:",
              fontSize: 16,
            ),
            5.ph,
            Obx(
              () {
                if (generalController.loading.value) {
                  return const RectangleShimmer(
                    height: 60,
                    items: 3,
                    radius: 6,
                  );
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: generalController.accounts.length,
                    itemBuilder: (context, index) {
                      return AccountItem(
                        id: generalController.accounts[index].id.toString(),
                        username: generalController.accounts[index].name,
                        host: generalController.accounts[index].host ?? "Null",
                      );
                    },
                  );
                }
              },
            ),
            30.ph,
            Center(
              child: MyTextButton(
                width: 200,
                onPressed: () {},
                text: "Create Account",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountItem extends StatelessWidget {
  final String username, id, host;

  const AccountItem({
    super.key,
    required this.username,
    required this.id,
    required this.host,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            MyText(
              "$id. ",
              fontSize: 18,
              color: Colors.yellow,
            ),
            Expanded(
              child: ListTile(
                leading: const Icon(
                  Icons.account_circle,
                  size: 45,
                ),
                title: MyText(
                  username,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                subtitle: MyText(
                  "Host: $host",
                ),
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
