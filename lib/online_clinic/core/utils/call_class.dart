import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import '../../features/agora/agora_main_page.dart';

class CallClass {
  Future<JitsiMeetingResponse?> joinMeeting({
    required BuildContext context,
    final String? roomName,
    final String? subject,
    final String? userName,
  }) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AgoraMainPage(userName: userName),
      ),
    );
  }
}
