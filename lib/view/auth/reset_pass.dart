import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasa/utils/custom_widgets/app_heading.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/static_data.dart';
import 'package:vasa/view/auth/verification_screen.dart';

class ResetPwdWithEmailPhone extends StatelessWidget {
  final bool? isEmail;
  const ResetPwdWithEmailPhone({super.key, this.isEmail = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(Get.width * 0.05), children: [
        SizedBox(
          height: Get.height * 0.05,
        ),
        AppHeading(title: AppStaticData.resetPassword),
        SizedBox(
          height: Get.height * 0.05,
        ),
        Column(
          children: [
            CustomTextField(
              isCountryPicker: isEmail! ? false : true,
              hintText: isEmail!
                  ? AppStaticData.emailAddress
                  : AppStaticData.phoneNumber,
              prefixIcon: Icons.email,
              title: "",
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            PrimaryBtn(
                title: AppStaticData.sendCode,
                onPressed: () {
                  Get.to(() => VerificationScreen(
                        isEmail: isEmail! ? true : false,
                      ));
                }),
          ],
        )
      ]),
    );
  }
}
