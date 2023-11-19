import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:vasa/utils/custom_widgets/text_style.dart';

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
            fontSize: 15.sp,
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
