import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import '../../../core/globals.dart';
import '../../core/widgets/app_widgets/custom_image/custom_image.dart';
import 'components/example_actions_widget.dart';

class AgoraMainPage extends StatefulWidget {
  final String? userName;

  const AgoraMainPage({
    super.key,
    this.userName,
  });

  @override
  State<AgoraMainPage> createState() => _MyAppState();
}

class _MyAppState extends State<AgoraMainPage> {
  late final RtcEngine _engine;

  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      openCamera = true,
      muteCamera = false,
      muteMicrophone = false,
      muteAllRemoteVideo = false,
      isPermissionHandled = false;

  // Set<int> uidList = {0};
  Set<int> remoteUid = {};
  int stagingUserId = 0;
  int latestElapse = 0;
  final bool _isUseFlutterTexture = false;
  final bool _isUseAndroidSurfaceView = false;
  final ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  AgoraRtmClient? _rtmClient;
  AgoraRtmChannel? _rtmChannel;
  bool _isInChannel = false;

  bool isLocalStaging = true;
  late String userName;

  /*final StopWatchTimer _stopWatchTimer =
      StopWatchTimer(mode: StopWatchMode.countUp);*/
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    // initializeAgora().then((value) => joinChannelRTM());
    userName = widget.userName ?? 'User ${Random().nextInt(100)}';
    initializeAgora().then((value) => _joinRtmChannel());

    /// Can be set preset time. This case is "00:01.23".
    _stopWatchTimer.setPresetTime(mSec: 0);
    _stopWatchTimer.onStartTimer();
  }

  @override
  void dispose() async {
    super.dispose();
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
    _rtmChannel?.leave();
    _rtmChannel?.release();
    await _stopWatchTimer.dispose();
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await [Permission.microphone, Permission.camera].request().then(
            (value) => setState(
              () {
                isPermissionHandled = true;
              },
            ),
          );
    } else {
      setState(() {
        isPermissionHandled = true;
      });
    }
  }

  void _joinRtmChannel() async {
    debugPrint('Print jc 10: ');
    try {
      debugPrint('Print jc 31: ');
      // _channel = await _createChannel(channelId);
      _rtmChannel = await _createRtmChannel(Globals.callRoomNameAgora).onError(
        (error, stackTrace) {
          debugPrint('Print jc 50: $error');
          debugPrint('Print jc 51: $stackTrace');
          return null;
        },
      ).then(
        (value) {
          debugPrint('Print jc 54: $value');
          return value;
        },
      ).whenComplete(
        () {
          debugPrint('Print jc 57: ');
        },
      );
      debugPrint('Print jc 321: $_rtmChannel');
      debugPrint('Print jc 322: ${_rtmChannel?.channelId}');
      debugPrint('Print jc 323: ${_rtmChannel?.getId()}');
      // await Future.delayed(Duration(seconds: 2));
      await _rtmChannel?.join().then(
        (value) {
          debugPrint('Print jc 60: ');
        },
      ).onError(
        (error, stackTrace) {
          debugPrint('Print jc 62: $error');
          debugPrint('Print jc 63: $stackTrace');
          if (error is AgoraRtmChannelException) {
            debugPrint('Print jc 64: ${error.reason}');
            debugPrint('Print jc 64: ${error.code}');
          }
        },
      ).whenComplete(
        () {
          debugPrint('Print jc 65: ');
        },
      );
      debugPrint('Print jc 33: ');
      _log('Join channel success');

      setState(() {
        debugPrint('Print jc 34: ');
        _isInChannel = true;
      });
      _getMembers();
    } catch (errorCode) {
      debugPrint('Print jc 39: ');
      _log('Join channel error: $errorCode');
    }
    debugPrint('Print jc 40: ');
  }

  Future<AgoraRtmChannel?> _createRtmChannel(String name) async {
    try {
      debugPrint('Print _createChannel 00: ');
      _rtmClient = await AgoraRtmClient.createInstance(Globals.appIdAgora);
      debugPrint('Print _createChannel 011: $_rtmClient');
      debugPrint('Print _createChannel 012: ${_rtmClient?.getRtmCallManager()}');
      await _rtmClient
          ?.login(
        Globals.tokenAgora3,
        // "0",
        'test01',
      )
          .then(
        (value) {
          debugPrint('Print _createChannel 012: ');
        },
      ).onError(
        (error, stackTrace) {
          debugPrint('Print _createChannel 013: $error');
          debugPrint('Print _createChannel 014: $stackTrace');
          if (error is AgoraRtmClientException) {
            debugPrint('Print _createChannel 015: ${error.reason}');
            debugPrint('Print _createChannel 016: ${error.code}');
          }
        },
      ).whenComplete(
        () {
          debugPrint('Print _createChannel 017: ');
        },
      );
      debugPrint('Print _createChannel 02: $_rtmClient');
      debugPrint('Print _createChannel 03: ');
      AgoraRtmChannel? channel = await _rtmClient?.createChannel(name);
      // AgoraRtmChannel? channel = await _client?.createChannel('name');
      debugPrint('Print _createChannel 04: $channel');
      if (channel != null) {
        debugPrint('Print _createChannel 05: ');
        channel.onError = (
          error,
        ) {
          debugPrint('Print _createChannel 10: ');
          _log('Channel error: $error');
        };
        channel.onMemberCountUpdated = (
          int memberCount,
        ) {
          debugPrint('Print _createChannel 20: ');
          _log('Member count updated: $memberCount');
        };
        channel.onAttributesUpdated = (
          List<RtmChannelAttribute> attributes,
        ) {
          debugPrint('Print _createChannel 30: ');
          _log('Channel attributes updated: ${attributes.toString()}');
        };
        channel.onMessageReceived = (
          RtmMessage message,
          RtmChannelMember member,
        ) {
          debugPrint('Print _createChannel 40: ');
          _log(
              'Channel msg: ${member.userId}, msg: ${message.messageType} ${message.text}');
        };
        channel.onMemberJoined = (
          RtmChannelMember member,
        ) {
          debugPrint('Print _createChannel 50: ');
          _log('Member joined: ${member.userId}, channel: ${member.channelId}');
        };
        channel.onMemberLeft = (
          RtmChannelMember member,
        ) {
          debugPrint('Print _createChannel 60: ');
          _log('Member left: ${member.userId}, channel: ${member.channelId}');
        };
      }
      debugPrint('Print _createChannel 06: $channel');

      return channel;
    } catch (ex) {
      debugPrint('Print _createChannel 90: $ex');
    }
    return null;
  }

  void _getMembers() async {
    debugPrint('Print _getMembers 10: ');
    try {
      debugPrint('Print _getMembers 20: ');
      List<RtmChannelMember>? members = await _rtmChannel?.getMembers();
      // List<RtmChannelMemberCount>? members =
      // await _client?.getChannelMemberCount([channelId]);
      debugPrint('Print _getMembers 30: ${members}');
      debugPrint('Print _getMembers 31: ${members?.length}');
      if (members != null && members.length > 2) {
        debugPrint('Print _getMembers 40: ${members.length}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The call is already in progress'),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (errorCode) {
      debugPrint('Print _getMembers 90: ');
      _log('GetMembers failed: $errorCode');
    }
  }

  void _log(String info) {
    debugPrint(info);
    setState(() {
      // _infoStrings.insert(0, info);
    });
  }

  Future<void> initializeAgora() async {
    await _requestPermissionIfNeed();

    _engine = createAgoraRtcEngine();
    await _engine.initialize(
      RtcEngineContext(
        appId: Globals.appIdAgora,
      ),
    );
    _rtcEngineEventHandler = RtcEngineEventHandler(
      onError: (
        ErrorCodeType err,
        String msg,
      ) {
        debugPrint('Print event 10: ');
      },
      onJoinChannelSuccess: (
        RtcConnection connection,
        int elapsed,
      ) {
        debugPrint('Print event 20: ');
        setState(() {
          isJoined = true;
        });
        // _getMembers();
      },
      onUserJoined: (
        RtcConnection connection,
        int rUid,
        int elapsed,
      ) {
        debugPrint(
          'Print event 30: ${remoteUid.length} - $isLocalStaging - $rUid',
        );
        setState(() {
          debugPrint('Print event 31 ${remoteUid.length} - $isLocalStaging');
          if (remoteUid.isEmpty && isLocalStaging == true) {
            debugPrint('Print event 32: ${remoteUid.length} - $isLocalStaging');
            stagingUserId = rUid;
            isLocalStaging = false;
            debugPrint('Print event 33: ${remoteUid.length} - $isLocalStaging');
          } else {
            debugPrint('Print event 34: ${remoteUid.length} - $isLocalStaging');
            remoteUid.add(rUid);
            debugPrint('Print event 35: ${remoteUid.length} - $isLocalStaging');
          }
          debugPrint('Print event 80: ');
          _stopWatchTimer.onStopTimer();
          _stopWatchTimer.onResetTimer();
          _stopWatchTimer.setPresetTime(mSec: elapsed);
          _stopWatchTimer.onStartTimer();
          debugPrint('Print event 86: ');
        });
      },
      onUserOffline: (
        RtcConnection connection,
        int rUid,
        UserOfflineReasonType reason,
      ) {
        debugPrint('Print event 40: ${remoteUid.length}');
        setState(() {
          if (isLocalStaging) {
            remoteUid.removeWhere((element) => element == rUid);
          } else {
            if (stagingUserId == rUid) {
              if (remoteUid.isNotEmpty) {
                stagingUserId = remoteUid.first;
              } else {
                isLocalStaging = true;
              }
            } else {
              remoteUid.removeWhere((element) => element == rUid);
            }
          }
        });
      },
      onLeaveChannel: (
        RtcConnection connection,
        RtcStats stats,
      ) {
        setState(() {
          isJoined = false;
          remoteUid.clear();
        });
      },
      onRemoteVideoStateChanged: (
        RtcConnection connection,
        int remoteUid,
        RemoteVideoState state,
        RemoteVideoStateReason reason,
        int elapsed,
      ) {
        debugPrint('Print event 60: ');
      },
    );
    _engine.registerEventHandler(_rtcEngineEventHandler);
    await _engine.enableVideo();
    _joinChannel();
  }

  Future<void> _joinChannel() async {
    await _engine.joinChannel(
      token: Globals.tokenAgora,
      channelId: Globals.callRoomNameAgora,
      uid: Globals.userIdAgora,
      options: ChannelMediaOptions(
        channelProfile: _channelProfileType,
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
      ),
    );
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  _muteLocalVideoStream() async {
    await _engine.muteLocalVideoStream(!muteCamera);
    setState(() {
      muteCamera = !muteCamera;
    });
  }

  void _muteLocalAudioStream() async {
    await _engine.muteLocalAudioStream(!muteCamera);
    setState(() {
      muteMicrophone = !muteMicrophone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      body: ExampleActionsWidget(
        displayContentBuilder: (context, isLayoutHorizontal) {
          return !isPermissionHandled
              ? const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Gap(32),
                      Text('Awaiting permission management ...'),
                    ],
                  ),
                )
              : Stack(
                  children: [
                    isLocalStaging
                        ? AgoraVideoView(
                            controller: VideoViewController(
                              rtcEngine: _engine,
                              canvas: const VideoCanvas(uid: 0),
                              useFlutterTexture: _isUseFlutterTexture,
                              useAndroidSurfaceView: _isUseAndroidSurfaceView,
                            ),
                            onAgoraVideoViewCreated: (viewId) {
                              debugPrint('Print init 60: ');
                              _engine.startPreview();
                            },
                          )
                        : AgoraVideoView(
                            controller: VideoViewController.remote(
                              rtcEngine: _engine,
                              canvas: VideoCanvas(uid: stagingUserId),
                              connection: RtcConnection(
                                channelId: Globals.callRoomNameAgora,
                              ),
                              useFlutterTexture: _isUseFlutterTexture,
                              useAndroidSurfaceView: _isUseAndroidSurfaceView,
                            ),
                          ),
                    Align(
                      alignment: Alignment.topRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        padding: EdgeInsets.only(
                          right: 16.w,
                          top: 64.h,
                        ),
                        child: Row(
                          children: List.of(
                            [
                              if (!isLocalStaging)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      remoteUid.add(stagingUserId);
                                      isLocalStaging = true;
                                    });
                                  },
                                  child: Container(
                                    width: 120,
                                    height: 150,
                                    margin: EdgeInsets.only(left: 16.w),
                                    // padding: EdgeInsets.all(3),
                                    clipBehavior: Clip.hardEdge,
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Color(0xFFFDFDFD),
                                          style: BorderStyle.solid,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      shadows: const [
                                        BoxShadow(
                                          color: Color(0x33121214),
                                          blurRadius: 12,
                                          offset: Offset(0, 6),
                                          spreadRadius: 2,
                                        )
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: AgoraVideoView(
                                        controller: VideoViewController(
                                          rtcEngine: _engine,
                                          canvas: const VideoCanvas(
                                            uid: 0,
                                          ),
                                          useFlutterTexture:
                                              _isUseFlutterTexture,
                                          useAndroidSurfaceView:
                                              _isUseAndroidSurfaceView,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ...remoteUid
                                  .map(
                                    (e) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (isLocalStaging) {
                                            isLocalStaging = false;
                                            remoteUid.remove(e);
                                          } else {
                                            remoteUid.remove(e);
                                            remoteUid.add(stagingUserId);
                                          }
                                          stagingUserId = e;
                                        });
                                      },
                                      child: Container(
                                        width: 120,
                                        height: 150,
                                        margin: EdgeInsets.only(left: 16.w),
                                        // padding: EdgeInsets.all(1),
                                        clipBehavior: Clip.hardEdge,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFFDFDFD),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          shadows: const [
                                            BoxShadow(
                                              color: Color(0x33121214),
                                              blurRadius: 12,
                                              offset: Offset(0, 6),
                                              spreadRadius: 2,
                                            )
                                          ],
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: AgoraVideoView(
                                            controller:
                                                VideoViewController.remote(
                                              rtcEngine: _engine,
                                              canvas: VideoCanvas(uid: e),
                                              connection: RtcConnection(
                                                channelId:
                                                    Globals.callRoomNameAgora,
                                              ),
                                              useFlutterTexture:
                                                  _isUseFlutterTexture,
                                              useAndroidSurfaceView:
                                                  _isUseAndroidSurfaceView,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 90.w,
                          right: 90.w,
                          bottom: 38.h,
                        ),
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: const Alignment(-0.00, -1.00),
                            end: const Alignment(0, 1),
                            colors: [
                              const Color(0x00D9D9D9),
                              Colors.black.withOpacity(0.4000000059604645),
                              Colors.black.withOpacity(0.6000000238418579),
                              Colors.black.withOpacity(0.800000011920929)
                            ],
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                color: Color(0xFFFDFDFD),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFFF000F),
                                    shape: OvalBorder(),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                StreamBuilder<int>(
                                  stream: _stopWatchTimer.rawTime,
                                  initialData: _stopWatchTimer.rawTime.value,
                                  builder: (
                                    context,
                                    snap,
                                  ) {
                                    final value = snap.data!;
                                    final displayTime =
                                        StopWatchTimer.getDisplayTime(
                                      value,
                                      // hours: _isHours,
                                      hours: false,
                                      minute: true, second: true,
                                      milliSecond: false,
                                    );
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            displayTime,
                                            style: const TextStyle(
                                              color: Color(0xFFF5F6F8),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5,
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                /*Text(
                                  "10 : 35",
                                  style: TextStyle(
                                    color: Color(0xFFF5F6F8),
                                    fontSize: 14,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    height: 0.11,
                                  ),
                                ),*/
                              ],
                            ),
                            SizedBox(height: 24.h),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                GestureDetector(
                                  onTap: _muteLocalVideoStream,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEE1E7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: CustomImage(
                                      imageSvgPath: 'images/svg/video.svg',
                                      svgColor: muteCamera
                                          ? const Color(0xffb7b9bd)
                                          : const Color(0xff394553),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _switchCamera,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEE1E7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.cameraswitch_sharp,
                                      color: Color(0xff394553),
                                      size: 20,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: _muteLocalAudioStream,
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: ShapeDecoration(
                                      color: const Color(0xFFDEE1E7),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: CustomImage(
                                      imageSvgPath: 'images/svg/microphone.svg',
                                      svgColor: muteMicrophone
                                          ? const Color(0xffb7b9bd)
                                          : const Color(0xff394553),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 24.h),
                            GestureDetector(
                              // onTap: _leaveChannel,
                              onTap: Navigator.of(context).pop,
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 8,
                                ),
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFFF000F),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: const CustomImage(
                                  imageSvgPath: 'images/svg/call.svg',
                                  svgColor: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}
