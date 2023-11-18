import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/checkbox_controller.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/app_heading.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';
import 'package:vasa/utils/static_data.dart';
import 'package:vasa/view/auth/login_screen.dart';
import 'package:vasa/view/auth/verification_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final CheckboxController controller = Get.put(CheckboxController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(Get.width * 0.05),
        children: [
          SizedBox(
            height: Get.height * 0.05,
          ),
          AppHeading(
            title: AppStaticData.reg,
          ),
          SizedBox(
            height: Get.height * 0.05,
          ),
          CustomTextField(
              hintText: AppStaticData.firstName,
              prefixIcon: Icons.person,
              title: AppStaticData.firstNameUpper),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomTextField(
              hintText: AppStaticData.lastName,
              prefixIcon: Icons.person,
              title: AppStaticData.lastNameUpper),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomTextField(
              hintText: AppStaticData.emailAddress,
              prefixIcon: Icons.email,
              title: AppStaticData.email),
          SizedBox(
            height: Get.height * 0.02,
          ),
          CustomTextField(
              isCountryPicker: true,
              hintText: AppStaticData.phoneNumber,
              prefixIcon: Icons.lock,
              title: AppStaticData.phoneNo),
          SizedBox(
            height: Get.height * 0.02,
          ),
          PrimaryBtn(
            title: AppStaticData.signUp,
            onPressed: () {
              Get.to(() => const VerificationScreen(
                    sendcodeForLogin: true,
                  ));
            },
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Obx(
            () => CheckboxListTile(
              value: controller.isCheck.value,
              onChanged: (value) {
                controller.changeStatus();
              },
              title: Text(
                AppStaticData.privacyPolicy,
                style: titleStyle.copyWith(
                  fontSize: 15,
                ),
              ),
              activeColor: AppColors.fadeBlue,
              checkColor: AppColors.primaryBlackColor,
              fillColor: MaterialStateColor.resolveWith(
                  (states) => AppColors.fadeBlue),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          TextInTheMiddle(text: AppStaticData.loginWith),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(FontAwesomeIcons.google)),
              SizedBox(
                width: Get.width * 0.02,
              ),
              IconButton(
                  onPressed: () {}, icon: const Icon(FontAwesomeIcons.apple)),
              SizedBox(
                width: Get.width * 0.02,
              ),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(FontAwesomeIcons.facebook)),
            ],
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStaticData.alreadyAccount,
                style: titleStyle.copyWith(
                  fontSize: 15,
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => LoginScreen());
                },
                child: Text(
                  AppStaticData.logIn,
                  style: titleStyle.copyWith(
                    fontSize: 15,
                    color: AppColors.redColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TextInTheMiddle extends StatelessWidget {
  final String text;
  const TextInTheMiddle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFC4C4C4),
          ),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        Text(
          text,
          style: titleStyle.copyWith(
            fontSize: 15,
          ),
        ),
        SizedBox(
          width: Get.width * 0.02,
        ),
        Expanded(
          child: Container(
            height: 1.5,
            color: const Color(0xFFC4C4C4),
          ),
        ),
      ],
    );
  }
}
