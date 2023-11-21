import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vasa/utils/colors.dart';

class HomeIcons extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final VoidCallback? onTap;
  const HomeIcons({
    super.key,
    this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
                color: AppColors.logoColor,
                borderRadius: BorderRadius.circular(10.r)),
            child: Icon(
              icon!,
              color: AppColors.whiteColor,
            ),
          ),
          Text(
            title!,
            style: Theme.of(context).textTheme.titleSmall,
          )
        ],
      ),
    );
  }
}
