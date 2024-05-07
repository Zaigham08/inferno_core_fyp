import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inferno_core_fyp/res/constants.dart';
import 'package:inferno_core_fyp/view/files_page.dart';
import '../view models/controllers/general_controller.dart';
import '../view models/controllers/target_controller.dart';
import '../view models/controllers/user_controller.dart';
import 'home.dart';
import 'targets_page.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final GeneralController generalController = Get.put(GeneralController());
  final UserController userController = Get.put(UserController());
  final TargetController targetController = Get.put(TargetController());

  @override
  void initState() {
    userController.fetchUserData();
    targetController.getAllTargets();
    targetController.getAllTargetsOnline();

    super.initState();
  }

  final List<Widget> _pages = [
    const HomePage(),
    const AllTargetsPage(),
    ExtractedFilesPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Obx(
          () => _pages[generalController.selectedIndex.value],
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            elevation: 15,
            selectedItemColor: btnColor,
            unselectedItemColor: whiteColor,
            currentIndex: generalController.selectedIndex.value,
            onTap: (index) {
              generalController.selectedIndex.value = index;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.supervised_user_circle),
                label: 'Targets',
              ),
              BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.arrow_down_doc_fill),
                label: 'Files',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
