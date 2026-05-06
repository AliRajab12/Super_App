import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../core/globals.dart';
import 'components/basic_video_configuration_widget.dart';
import 'components/example_actions_widget.dart';

class AgoraRTCPageSimple extends StatefulWidget {
  const AgoraRTCPageSimple({super.key});

  @override
  State<AgoraRTCPageSimple> createState() => _MyAppState();
}

class _MyAppState extends State<AgoraRTCPageSimple> {
  late final RtcEngine _engine;

  bool isJoined = false,
      switchCamera = true,
      switchRender = true,
      openCamera = true,
      muteCamera = false,
      muteAllRemoteVideo = false,
      isPermissionHandled = false;
  Set<int> remoteUid = {};
  bool _isUseFlutterTexture = false;
  bool _isUseAndroidSurfaceView = false;
  ChannelProfileType _channelProfileType =
      ChannelProfileType.channelProfileLiveBroadcasting;
  late final RtcEngineEventHandler _rtcEngineEventHandler;

  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;
  bool _isInChannel = false;

  @override
  void initState() {
    super.initState();
    // initializeAgora().then((value) => joinChannelRTM());
    initializeAgora().then((value) => _toggleJoinChannel());
  }

  @override
  void dispose() async {
    super.dispose();
    _engine.unregisterEventHandler(_rtcEngineEventHandler);
    await _engine.leaveChannel();
    await _engine.release();
    _channel?.leave();
    _channel?.release();
  }

  Future<void> _requestPermissionIfNeed() async {
    if (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS) {
      await [Permission.microphone, Permission.camera]
          .request()
          .then((value) => setState(() {
                isPermissionHandled = true;
              }));
    } else {
      setState(() {
        isPermissionHandled = true;
      });
    }
  }

  void _toggleJoinChannel() async {
    debugPrint('Print jc 10: ');
    if (_isInChannel) {
      debugPrint('Print jc 11: ');
      try {
        await _channel?.leave();
        debugPrint('Print jc 12: ');
        _log('Leave channel success');
        debugPrint('Print jc 13: ');
        await _channel?.release();
        // _channelMessageController.clear();

        setState(() {
          debugPrint('Print jc 14: ');
          _isInChannel = false;
        });
      } catch (errorCode) {
        debugPrint('Print jc 19: ');
        _log('Leave channel error: $errorCode');
      }
    } else {
      // String channelId = _channelNameController.text;
      debugPrint('Print jc 20: ');
      String channelId = Globals.callRoomNameAgora;
      debugPrint('Print jc 21: ');
      if (channelId.isEmpty) {
        debugPrint('Print jc 22: ');
        _log('Please input channel id to join');
        return;
      }
      debugPrint('Print jc 30: ');

      try {
        debugPrint('Print jc 31: ');
        // _channel = await _createChannel(channelId);
        _channel = await _createChannel(Globals.callRoomNameAgora).onError(
          (error, stackTrace) {
            debugPrint('Print jc 50: $error');
            debugPrint('Print jc 51: $stackTrace');
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
        debugPrint('Print jc 321: $_channel');
        debugPrint('Print jc 322: ${_channel?.channelId}');
        debugPrint('Print jc 323: ${_channel?.getId()}');
        // await Future.delayed(Duration(seconds: 2));
        await _channel?.join().then(
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
    debugPrint('Print jc 41: ');
  }

  /*void joinChannelRTM() async {
    try {
      debugPrint("Print jc 00: ");
      _channel = await _createChannel(Globals.callRoomNameAgora);
      */ /*_channel = AgoraRtmChannel(
        2,
        // Globals.callRoomNameAgora,
        Globals.appIdAgora,
      );*/ /*
      debugPrint("Print jc 10: $_channel");
      debugPrint("Print jc 11: ${_channel?.channelId}");
      debugPrint("Print jc 12: ${_channel?.getId()}");
      try {
        debugPrint("Print jc 20: ");
        await _channel?.join();
        debugPrint("Print jc 21: ");
      } catch (ex) {
        debugPrint("Print jc 29: $ex");
      }
      _log('Join channel success');

      setState(() {
        _isInChannel = true;
      });
      _getMembers();
    } catch (errorCode) {
      debugPrint("Print jc 90: $errorCode");
      if (errorCode is AgoraRtmChannelException) {
        debugPrint("Print jc 90: ${errorCode.code}");
        debugPrint("Print jc 90: ${errorCode.reason}");
      }
      _log('Join channel error: $errorCode');
    }
  }*/

  Future<AgoraRtmChannel?> _createChannel(String name) async {
    try {
      debugPrint('Print _createChannel 00: ');
      _client = await AgoraRtmClient.createInstance(Globals.appIdAgora);
      debugPrint('Print _createChannel 01: $_client');
      debugPrint('Print _createChannel 01: ${_client?.getRtmCallManager()}');
      await _client
          ?.login(
        Globals.tokenAgora3,
        '0',
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
      debugPrint('Print _createChannel 02: $_client');
      debugPrint('Print _createChannel 03: ');
      AgoraRtmChannel? channel = await _client?.createChannel(name);
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
  }

  void _getMembers() async {
    debugPrint('Print _getMembers 10: ');
    try {
      debugPrint('Print _getMembers 20: ');
      List<RtmChannelMember>? members = await _channel?.getMembers();
      debugPrint('Print _getMembers 30: ${members}');
      debugPrint('Print _getMembers 31: ${members?.length}');
      _log('Members: ${members.toString()}');
    } catch (errorCode) {
      debugPrint('Print _getMembers 90: ');
      _log('GetMembers failed: $errorCode');
    }
  }

  /*void _getMemberCount() async {
    String channelId = _channelNameController.text;
    if (channelId.isEmpty) {
      _log('Please input channel id to get');
      return;
    }

    try {
      List<RtmChannelMemberCount>? members =
      await _client?.getChannelMemberCount([channelId]);
      _log('Members: ${members.toString()}');
    } catch (errorCode) {
      _log('GetMembers failed: $errorCode');
    }
  }*/

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
        debugPrint('Print event 30: ');
        setState(() {
          remoteUid.add(rUid);
        });
      },
      onUserOffline: (
        RtcConnection connection,
        int rUid,
        UserOfflineReasonType reason,
      ) {
        debugPrint('Print event 40: ');
        setState(() {
          remoteUid.removeWhere((element) => element == rUid);
        });
      },
      onLeaveChannel: (
        RtcConnection connection,
        RtcStats stats,
      ) {
        debugPrint('Print event 50: ');
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
    debugPrint('Print init 40: ');
    _engine.registerEventHandler(_rtcEngineEventHandler);
    debugPrint('Print init 41: ');

    await _engine.enableVideo();
    debugPrint('Print init 42: ');
    _joinChannel();
    debugPrint('Print init 43: ');
    try {
      // await _engine.startPreview();
      debugPrint('Print init 46: ');
    } catch (ex) {
      debugPrint('Print init 49: $ex');
    }
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

  Future<void> _leaveChannel() async {
    await _engine.leaveChannel();
    setState(() {
      openCamera = true;
      muteCamera = false;
      muteAllRemoteVideo = false;
    });
  }

  Future<void> _switchCamera() async {
    await _engine.switchCamera();
    setState(() {
      switchCamera = !switchCamera;
    });
  }

  _openCamera() async {
    await _engine.enableLocalVideo(!openCamera);
    setState(() {
      openCamera = !openCamera;
    });
  }

  _muteLocalVideoStream() async {
    await _engine.muteLocalVideoStream(!muteCamera);
    setState(() {
      muteCamera = !muteCamera;
    });
  }

  _muteAllRemoteVideoStreams() async {
    await _engine.muteAllRemoteVideoStreams(!muteAllRemoteVideo);
    setState(() {
      muteAllRemoteVideo = !muteAllRemoteVideo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    AgoraVideoView(
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
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.of(
                            remoteUid.map(
                              (e) => SizedBox(
                                width: 120,
                                height: 120,
                                child: AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: _engine,
                                    canvas: VideoCanvas(uid: e),
                                    connection: RtcConnection(
                                      channelId: Globals.callRoomNameAgora,
                                    ),
                                    useFlutterTexture: _isUseFlutterTexture,
                                    useAndroidSurfaceView:
                                        _isUseAndroidSurfaceView,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
        actionsBuilder: (
          context,
          isLayoutHorizontal,
        ) {
          if (!isPermissionHandled) {
            return const SizedBox.shrink();
          } else {
            final channelProfileType = [
              ChannelProfileType.channelProfileLiveBroadcasting,
              ChannelProfileType.channelProfileCommunication,
            ];
            final items = channelProfileType
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e.toString().split('.')[1],
                    ),
                  ),
                )
                .toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  Globals.callRoomNameAgora,
                ),
                if (!kIsWeb &&
                    (defaultTargetPlatform == TargetPlatform.android ||
                        defaultTargetPlatform == TargetPlatform.iOS))
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Rendered by Flutter texture: '),
                          Switch(
                            value: _isUseFlutterTexture,
                            onChanged: isJoined
                                ? null
                                : (changed) {
                                    setState(() {
                                      _isUseFlutterTexture = changed;
                                    });
                                  },
                          )
                        ],
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                const Text('Channel Profile: '),
                DropdownButton<ChannelProfileType>(
                  items: items,
                  value: _channelProfileType,
                  onChanged: isJoined
                      ? null
                      : (v) {
                          setState(() {
                            _channelProfileType = v!;
                          });
                        },
                ),
                const SizedBox(
                  height: 20,
                ),
                BasicVideoConfigurationWidget(
                  rtcEngine: _engine,
                  title: 'Video Encoder Configuration',
                  setConfigButtonText: const Text(
                    'setVideoEncoderConfiguration',
                    style: TextStyle(fontSize: 10),
                  ),
                  onConfigChanged: (width, height, frameRate, bitrate) {
                    _engine.setVideoEncoderConfiguration(
                      VideoEncoderConfiguration(
                        dimensions:
                            VideoDimensions(width: width, height: height),
                        frameRate: frameRate,
                        bitrate: bitrate,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: isJoined ? _leaveChannel : _joinChannel,
                        child: Text('${isJoined ? 'Leave' : 'Join'} channel'),
                      ),
                    )
                  ],
                ),
                if (!kIsWeb &&
                    (defaultTargetPlatform == TargetPlatform.android ||
                        defaultTargetPlatform == TargetPlatform.iOS)) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _switchCamera,
                    child: Text('Camera ${switchCamera ? 'front' : 'rear'}'),
                  ),
                ],
                if (kIsWeb) ...[
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: _muteLocalVideoStream,
                    child: Text('Camera ${muteCamera ? 'muted' : 'unmute'}'),
                  ),
                  ElevatedButton(
                    onPressed: _muteAllRemoteVideoStreams,
                    child: Text(
                        'All Remote Camera ${muteAllRemoteVideo ? 'muted' : 'unmute'}'),
                  ),
                  ElevatedButton(
                    onPressed: _openCamera,
                    child: Text('Camera ${openCamera ? 'on' : 'off'}'),
                  ),
                ],
              ],
            );
          }
        },
      ),
    );
    // if (!_isInit) return Container();
  }
}
