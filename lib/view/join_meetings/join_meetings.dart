import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:vasa/controller/signaling.dart';
import 'package:vasa/utils/custom_widgets/custom_text_field.dart';
import 'package:vasa/utils/custom_widgets/primary_button.dart';
import 'package:vasa/utils/static_data.dart';

class JoinMettingScreen extends StatefulWidget {
  const JoinMettingScreen({super.key});

  @override
  State<JoinMettingScreen> createState() => _JoinMettingScreenState();
}

class _JoinMettingScreenState extends State<JoinMettingScreen> {
  final SignalingController _signaling = SignalingController();

  RTCVideoRenderer _localRenderer = RTCVideoRenderer();

  RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController roomCodeController = TextEditingController();
  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();
    _signaling.onAddRemoteStream = (stream) {
      _remoteRenderer.srcObject = stream;
      setState(() {
        print("remote stream added");
      });
    };
    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    roomCodeController.dispose();
    super.dispose();
  }

  joinMeeting() {
    _signaling
        .openUserMedia(_localRenderer, _remoteRenderer)
        .then((value) async {
      await _signaling.joinRoom(roomCodeController.text, _remoteRenderer);
      Get.toNamed("/meetnow", arguments: {
        "localRenderer": _localRenderer,
        "remoteRenderer": _remoteRenderer,
        "roomId": roomCodeController.text,
        "currentRoomText": roomCodeController.text,
      });
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                txtController: roomCodeController,
                hintText: AppStaticData.code,
                title: AppStaticData.enterCodetoJoinMeeting,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter room code";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 20.h,
              ),
              PrimaryBtn(
                  title: AppStaticData.join,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      joinMeeting();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
