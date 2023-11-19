import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vasa/utils/app_imges.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';

class AppHeading extends StatelessWidget {
  final String title;
  const AppHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.vasaIcon,
          color: Colors.black,
          scale: 10.sp,
        ),
        Text(title,
            style: titleStyle.copyWith(
              fontSize: 25.sp,
            )),
      ],
    );
  }
}
