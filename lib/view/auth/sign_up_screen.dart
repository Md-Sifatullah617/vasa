import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/checkbox_controller.dart';
import 'package:vasa/controller/login_controller.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/app_heading.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/custom_toast.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/custom_widgets/text_in_middle.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';
import 'package:vasa/utils/static_data.dart';
import 'package:vasa/view/auth/email_verify.dart';
import 'package:vasa/view/auth/login_screen.dart';
import 'package:vasa/view/auth/verification_screen.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final CheckboxController controller = Get.put(CheckboxController());
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pwdController = TextEditingController();
  final TextEditingController cpwdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginController>(
        builder: (loginController) => Form(
          key: _formKey,
          child: ListView(
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
                  txtController: fnameController,
                  hintText: AppStaticData.firstName,
                  prefixIcon: Icons.person,
                  title: AppStaticData.firstNameUpper,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Please enter first name";
                    }
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                  txtController: lnameController,
                  hintText: AppStaticData.lastName,
                  prefixIcon: Icons.person,
                  title: AppStaticData.lastNameUpper,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Please enter last name";
                    }
                  }),

              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                  txtController: emailController,
                  hintText: AppStaticData.emailAddress,
                  prefixIcon: Icons.email,
                  title: AppStaticData.email,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Please enter email address";
                    } else if (!GetUtils.isEmail(value)) {
                      return "Please enter valid email address";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                  txtController: phoneController,
                  isCountryPicker: true,
                  hintText: AppStaticData.phoneNumber,
                  prefixIcon: Icons.lock,
                  title: AppStaticData.phoneNo,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "Please enter phone number";
                    } else if (!GetUtils.isPhoneNumber(value)) {
                      return "Please enter valid phone number";
                    } else if (value.length < 11) {
                      return "Please enter valid phone number";
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              //password and confirm password field
              CustomTextField(
                txtController: pwdController,
                hintText: AppStaticData.password,
                prefixIcon: Icons.lock,
                title: "Password",
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
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please enter password";
                  } else if (value.length < 8) {
                    return "Password must be 8 characters long";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CustomTextField(
                txtController: cpwdController,
                hintText: AppStaticData.cpassword,
                prefixIcon: Icons.lock,
                title: "Confirm Password",
                obscureText: loginController.obscureText.value,
                suffixWidget: InkWell(
                  onTap: () {
                    loginController.changePasswordVisibility(false);
                  },
                  child: Icon(
                    loginController.isPasswordVisible.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.secondaryBlackColor,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || value == null) {
                    return "Please enter confirm password";
                  } else if (value.length < 8) {
                    return "Password must be 8 characters long";
                  } else if (value != pwdController.text) {
                    return "Password and confirm password must be same";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              PrimaryBtn(
                  title: AppStaticData.signUp,
                  onPressed: () {
                    print(
                        "all values: ${fnameController.text} ${lnameController.text} ${emailController.text} ${phoneController.text}");
                    ;
                    if (_formKey.currentState!.validate()) {
                      if (loginController.isAgreeTerms.value) {
                        Get.to(() => VerificationScreen(
                              isEmail: true,
                              sendcodeForLogin: true,
                            ));
                      } else {
                        customToast(
                            msg: "Please agree to terms and conditions",
                            isError: true);
                      }
                    }
                  }),
              SizedBox(
                height: Get.height * 0.02,
              ),
              CheckboxListTile(
                value: loginController.isAgreeTerms.value,
                onChanged: (value) {
                  loginController.changeAgreeTerms();
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
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.google)),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.apple)),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(FontAwesomeIcons.facebook)),
                ],
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
        ),
      ),
    );
  }
}
