import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/login_controller.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginController>(
      builder: (controller) => Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //exit button
            const SizedBox(height: 20),
            Align(
                alignment: Alignment.center,
                child: PrimaryBtn(
                    title: "Exit",
                    width: 200.w,
                    onPressed: () {
                      controller.signOut();
                    })),
          ]),
    ));
  }
}
