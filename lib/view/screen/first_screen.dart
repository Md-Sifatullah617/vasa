import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vasa/utils/custom_widgets/home_icon.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      children: [
        //4 buttons in a row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeIcons(
              onTap: () {},
              title: "Meet Now",
              icon: FontAwesomeIcons.video,
            ),
            SizedBox(
              width: 10.w,
            ),
            HomeIcons(
              onTap: () {},
              title: "Join Meeting",
              icon: FontAwesomeIcons.userFriends,
            ),
            SizedBox(
              width: 10.w,
            ),
            HomeIcons(
              onTap: () {},
              title: "Schedule",
              icon: FontAwesomeIcons.calendarAlt,
            ),
            SizedBox(
              width: 10.w,
            ),
            HomeIcons(
              onTap: () {},
              title: "Share Screen",
              icon: FontAwesomeIcons.shareAlt,
            ),
          ],
        ),
        SizedBox(
          height: 200.h,
        ),
        Text(
          textAlign: TextAlign.center,
          "Join meetings just one click away!",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    ));
  }
}
