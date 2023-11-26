import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/login_controller.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/app_heading.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/custom_widgets/text_in_middle.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';
import 'package:vasa/utils/static_data.dart';
import 'package:vasa/view/auth/reset_pass.dart';
import 'package:vasa/view/auth/sign_up_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<LoginController>(
      builder: (controller) =>
          ListView(padding: EdgeInsets.all(1.sw * 0.05), children: [
        SizedBox(
          height: 1.sh * 0.05,
        ),
        AppHeading(title: AppStaticData.logIn),
        SizedBox(
          height: 1.sh * 0.05,
        ),
        CustomTextField(
          hintText: AppStaticData.emailAddress,
          prefixIcon: Icons.email,
          title: AppStaticData.email,
        ),
        SizedBox(
          height: 1.sh * 0.02,
        ),
        Obx(
          () => CustomTextField(
            hintText: AppStaticData.password,
            prefixIcon: Icons.lock,
            title: AppStaticData.password,
            obscureText: loginController.obscureText.value,
            suffixWidget: InkWell(
              onTap: () {
                loginController.changePasswordVisibility(true);
              },
              child: Icon(
                loginController.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: AppColors.secondaryBlackColor,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 1.sh * 0.02,
        ),
        InkWell(
          onTap: () {
            //create bottom sheet for forgot password chosse phone or email
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              context: context,
              builder: (BuildContext context) {
                return Container(
                  height: 1.sh * 0.35,
                  padding: EdgeInsets.all(1.sw * 0.05),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(AppStaticData.resetPassword, style: titleStyle),
                      SizedBox(
                        height: 1.sh * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.fadeBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => const ResetPwdWithEmailPhone(
                                  isEmail: true,
                                ));
                          },
                          leading: const Icon(
                            Icons.email,
                          ),
                          title: Text(
                            AppStaticData.email,
                            style: subTitleStyle,
                          ),
                          subtitle: Text(
                              AppStaticData.Resetviaemailverification,
                              style: subTitleStyle),
                        ),
                      ),
                      SizedBox(
                        height: 1.sh * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.fadeBlue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.to(() => const ResetPwdWithEmailPhone());
                          },
                          leading: const Icon(
                            Icons.phone,
                          ),
                          title: Text(
                            AppStaticData.phoneNo,
                            style: subTitleStyle,
                          ),
                          subtitle: Text(
                              AppStaticData.Resetviaphoneverification,
                              style: subTitleStyle),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text(
            textAlign: TextAlign.end,
            AppStaticData.forgotPassword,
            style: subTitleStyle.copyWith(color: AppColors.redColor),
          ),
        ),
        SizedBox(
          height: 1.sh * 0.02,
        ),
        PrimaryBtn(
          title: AppStaticData.logIn,
          btnColor: AppColors.logoColor,
          onPressed: () {},
        ),
        SizedBox(
          height: Get.height * 0.05,
        ),
        TextInTheMiddle(text: AppStaticData.loginWith),
        SizedBox(
          height: Get.height * 0.02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  controller.googleSignIn();
                },
                icon: const Icon(
                  FontAwesomeIcons.google,
                  color: AppColors.redColor,
                )),
            SizedBox(
              width: Get.width * 0.02,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.linkedinIn,
                  color: AppColors.linkedinColor,
                )),
            SizedBox(
              width: Get.width * 0.02,
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.facebook,
                  color: AppColors.facebookColor,
                )),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStaticData.newSignUp,
              style: titleStyle.copyWith(
                fontSize: 15,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(() => SignupScreen());
              },
              child: Text(
                AppStaticData.signUpNow,
                style: titleStyle.copyWith(
                  fontSize: 15,
                  color: AppColors.redColor,
                ),
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
