import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/login_controller.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/app_heading.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';
import 'package:vasa/utils/static_data.dart';
import 'package:vasa/view/auth/login_screen.dart';
import 'package:vasa/view/auth/new_password.dart';

class VerificationScreen extends StatelessWidget {
  final bool? isEmail;
  final bool? sendcodeForLogin;
  const VerificationScreen(
      {super.key, this.isEmail = false, this.sendcodeForLogin = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (controller) =>
            ListView(padding: EdgeInsets.all(Get.width * 0.05), children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          AppHeading(
              title: isEmail!
                  ? AppStaticData.verificationEmail
                  : AppStaticData.verification),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Text(
            textAlign: TextAlign.center,
            isEmail!
                ? AppStaticData.verificationCodeSentTo
                : AppStaticData.verificationCodeSent,
            style: subTitleStyle,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          isEmail!
              ? Icon(
                  Icons.verified,
                  size: Get.width * 0.2,
                  color: AppColors.redColor,
                )
              : CustomTextField(
                  hintText: AppStaticData.verificationCode,
                  title: "",
                ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          PrimaryBtn(
            title: sendcodeForLogin!
                ? AppStaticData.VerifyNow_SignIn
                : AppStaticData.verifyNow,
            onPressed: () {
              sendcodeForLogin!
                  ? Get.to(() => LoginScreen())
                  : Get.to(() => NewPasswordSetScreen());
            },
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppStaticData.minLeft, style: subTitleStyle),
              SizedBox(
                width: Get.width * 0.02,
              ),
              Text(
                AppStaticData.resend,
                style: subTitleStyle.copyWith(color: AppColors.redColor),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
