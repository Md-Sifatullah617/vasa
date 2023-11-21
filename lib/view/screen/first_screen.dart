import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vasa/controller/signaling.dart';
import 'package:vasa/utils/custom_widgets/home_icon.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  SignalingController _signaling = SignalingController();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roodId;
  TextEditingController roomtxtController = TextEditingController();

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    _signaling.onAddRemoteStream = (stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {});
    };
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

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
              icon: FontAwesomeIcons.userGroup,
            ),
            SizedBox(
              width: 10.w,
            ),
            HomeIcons(
              onTap: () {},
              title: "Schedule",
              icon: FontAwesomeIcons.calendarDays,
            ),
            SizedBox(
              width: 10.w,
            ),
            HomeIcons(
              onTap: () {},
              title: "Share Screen",
              icon: FontAwesomeIcons.shareNodes,
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
