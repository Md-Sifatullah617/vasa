import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final Color? btnColor;
  final Function() onPressed;
  const PrimaryBtn({
    super.key,
    required this.title,
    required this.onPressed,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor ?? AppColors.logoColor,
        minimumSize: Size(Get.width, Get.height * 0.06),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title, style: buttonTitle),
    );
  }
}
