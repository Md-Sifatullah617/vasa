import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vasa/utils/colors.dart';

class HomeIcons extends StatelessWidget {
  final String? title;
  final IconData? icon;
  final Color? color;
  final Color? iconColor;
  final double? bradius;
  final VoidCallback? onTap;
  const HomeIcons({
    super.key,
    this.title,
    this.icon,
    this.onTap,
    this.color,
    this.iconColor,
    this.bradius,
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
                color: color ?? AppColors.logoColor,
                borderRadius: BorderRadius.circular(bradius ?? 10.r)),
            child: Icon(
              icon!,
              color: iconColor ?? AppColors.whiteColor,
            ),
          ),
          title == null
              ? const SizedBox()
              : Text(
                  title!,
                  style: Theme.of(context).textTheme.titleSmall,
                )
        ],
      ),
    );
  }
}
