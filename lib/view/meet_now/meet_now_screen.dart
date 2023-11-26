import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/signaling.dart';
import 'package:vasa/utils/colors.dart';
import 'package:vasa/utils/custom_widgets/custom_toast.dart';
import 'package:vasa/utils/custom_widgets/home_icon.dart';

class MeetNowScreen extends StatefulWidget {
  const MeetNowScreen({super.key});

  @override
  State<MeetNowScreen> createState() => _MeetNowScreenState();
}

class _MeetNowScreenState extends State<MeetNowScreen> {
  SignalingController _signaling = SignalingController();
  String? roodId;
  TextEditingController roomtxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var arguments = Get.arguments;
    return Scaffold(
        body: Stack(
      children: [
        Container(),
        Column(children: [
          Expanded(
            child: RTCVideoView(
              arguments["localRenderer"],
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: true,
            ),
          ),
          Expanded(
            child: RTCVideoView(
              arguments["remoteRenderer"],
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
            ),
          ),
        ]),
        Positioned(
          bottom: 10.h,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //incall actions here
              HomeIcons(
                bradius: 50.r,
                icon: Icons.mic_off,
                onTap: () {},
              ),
              HomeIcons(
                bradius: 50.r,
                icon: Icons.video_call,
                onTap: () {},
              ),
              HomeIcons(
                bradius: 50.r,
                color: AppColors.redColor,
                icon: Icons.call_end,
                onTap: () {
                  _signaling.hangUP(arguments["localRenderer"]);
                  Get.back();
                },
              ),
              HomeIcons(
                bradius: 50.r,
                icon: Icons.more_vert,
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          height: 100.h,
                          width: 1.sw,
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            children: [
                              Text(
                                "Room Id:",
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              GestureDetector(
                                onLongPress: () {
                                  Clipboard.setData(
                                      ClipboardData(text: arguments["roomId"]));
                                  customToast(msg: "Copied to clipboard");
                                },
                                child: Text(
                                  arguments["roomId"],
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                              // PrimaryBtn(
                              //   title: "Share Screen",
                              //   onPressed: () {},
                              // ),
                              // PrimaryBtn(
                              //   title: "Chat",
                              //   onPressed: () {},
                              // ),
                              // PrimaryBtn(
                              //   title: "Record",
                              //   onPressed: () {},
                              // ),
                              // PrimaryBtn(
                              //   title: "Settings",
                              //   onPressed: () {},
                              // ),
                            ],
                          ),
                        );
                      });
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
