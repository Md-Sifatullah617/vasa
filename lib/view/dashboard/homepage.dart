import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:vasa/controller/checkbox_controller.dart';
import 'package:vasa/utils/colors.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});
  final CheckboxController controller = Get.put(CheckboxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Vasa'),
        ),
        body: Obx(() => IndexedStack(
              index: controller.currentIndex.value,
              children: controller.pages,
            )),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(LineIcons.home),
                label: 'Meet Now',
              ),
              BottomNavigationBarItem(
                icon: Icon(LineIcons.podcast),
                label: 'Meetings',
              ),
              BottomNavigationBarItem(
                  icon: Icon(LineIcons.cog), label: 'Settings'),
              BottomNavigationBarItem(
                  icon: Icon(LineIcons.user), label: 'Profile'),
            ],
            currentIndex: controller.currentIndex.value,
            selectedItemColor: AppColors.logoColor,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              controller.currentIndex.value = index;
              print(index);
            },
          ),
        ));
  }
}
