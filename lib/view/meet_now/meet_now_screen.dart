import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/signaling.dart';

class MeetNowScreen extends StatefulWidget {
  const MeetNowScreen({super.key});

  @override
  State<MeetNowScreen> createState() => _MeetNowScreenState();
}

class _MeetNowScreenState extends State<MeetNowScreen> {
  SignalingController _signaling = SignalingController();
  RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roodId;
  TextEditingController roomtxtController = TextEditingController();

  @override
  void initState() {
    // _localRenderer.initialize();
    // _remoteRenderer.initialize();
    // _signaling.onAddRemoteStream = (stream) {
    //   _remoteRenderer.srcObject = stream;
    //   setState(() {});
    // };

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
    var arguments = Get.arguments;
    return Scaffold(
        body: Column(children: [
      Expanded(
        child: RTCVideoView(
          arguments["localRenderer"],
          mirror: true,
        ),
      ),
      Expanded(
        child: RTCVideoView(
          arguments["remoteRenderer"],
        ),
      ),
    ]));
  }
}
