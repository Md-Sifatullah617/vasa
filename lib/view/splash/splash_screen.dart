import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasa/utils/app_imges.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/view/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Get.offAll(() => LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.logoColor,
        child: Center(
            child: BounceInDown(
          child: Image(
            image: AssetImage(
              AppImages.vasaLogo,
            ),
          ),
        )),
      ),
    );
  }
}
