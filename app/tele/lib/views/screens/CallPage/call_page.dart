import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tele/views/screens/components/config.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class CallPage extends StatelessWidget {
  final String callId;
  final String callType;

  const CallPage({super.key, required this.callId, required this.callType});

  @override
  Widget build(BuildContext context) {
    final uid = Random().nextInt(1000).toString();

    final callConfig = callType == '0'
        ? ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall()
        : ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall();
    // Enable Picture-in-Picture mode when the app goes to background
    callConfig.pip = ZegoCallPIPConfig(
      enableWhenBackground: true,
    );
    
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: Config.appId,
          appSign: Config.appSign,
          callID: callId,
          userID: uid,
          userName: uid,
          config: callConfig,
        ),
      ),
    );
  }
}
