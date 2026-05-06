import 'dart:collection';
import 'dart:developer' as developer;
import 'dart:io';

import 'package:somi/core/init.dart';
import 'package:somi/core/models/analytics_event.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AnalyticsService {
  Future<void> upload(AnalyticsData data) async {
    await locator<NetworkProvider>()
        .auth()
        .post(data.type.uploadUrl, data: data.getPayload());
  }
}

/// Denotes the type of analytics data being represented as well as the [uploadUrl] for that type
enum AnalyticsType {
  track('/api/mobile/user/track'),
  screen('/api/mobile/user/screen'),
  identify('/api/mobile/user/identify');

  final String uploadUrl;

  const AnalyticsType(this.uploadUrl);
}

/// Holds the information required to construct the network payload for a single analytics event
class AnalyticsData {
  final AnalyticsType type;
  final Map<String, dynamic> context;
  final int? userId;
  final Map<String, dynamic>? other;
  final String timestamp = DateTime.now().toUtc().toIso8601String();

  AnalyticsData({
    this.type = AnalyticsType.track,
    required this.context,
    this.userId,
    this.other,
  });

  /// Returns a map of the analytics data structured for API consumption
  Map<String, dynamic> getPayload() => {
        'context': context,
        if (userId != null) 'userId': userId,
        if (other != null) ...other!,
        'sentAt': timestamp,
        'Platform': 'mobile',
      };
}

/// Responsible for queuing and uploading analytics data
class Analytics {
  late AnalyticsContext _context;
  late AnalyticsService _service;
  late UserRepo _userRepo;

  bool _sending = false;

  Queue<AnalyticsData> dataQueue = Queue();

  Future<void> init({
    AnalyticsContext? context,
    AnalyticsService? service,
    UserRepo? userRepo,
  }) async {
    _service = service ?? locator<AnalyticsService>();
    _userRepo = userRepo ?? locator<UserRepo>();
    _context = context ?? await AnalyticsContext.platform();
  }

  /// Tracks analytics data for the provided [event]
  ///
  /// Providing a [timeout] will cause this call to wait for the event to be uploaded, up to the specified [Duration].
  Future<void> track(AnalyticsEvent event, {Duration? timeout}) async {
    final properties = event.props ?? {};
    properties['Platform'] = 'mobile';
    AnalyticsData data = AnalyticsData(
      context: await _context.toMap(),
      userId: _userRepo.user?.userProfileKey,
      other: {
        'eventName': event.name,
        'properties': properties,
      },
    );
    await _addAndProcess(data, timeout);
  }

  /// Allows the backend to correlate the current user with the device. This should be called after the user logs in.
  ///
  /// Providing a [timeout] will cause this call to wait for the event to be uploaded, up to the specified [Duration].
  Future<void> identify({Duration? timeout}) async {
    AnalyticsData data = AnalyticsData(
      type: AnalyticsType.identify,
      context: await _context.toMap(),
      userId: _userRepo.user?.userProfileKey,
    );
    await _addAndProcess(data, timeout);
  }

  /// Tracks a screen view event for the specified [screenName]
  ///
  /// Providing a [timeout] will cause this call to wait for the event to be uploaded, up to the specified [Duration].
  Future<void> screen(String screenName, {Duration? timeout}) async {
    AnalyticsData data = AnalyticsData(
      type: AnalyticsType.screen,
      context: await _context.toMap(),
      userId: _userRepo.user?.userProfileKey,
      other: {'name': screenName},
    );
    await _addAndProcess(data, timeout);
  }

  Future<void> _addAndProcess(AnalyticsData data, Duration? timeout) async {
    // Skip if ReduceTracking is enabled and we're in an upper environment; don't skip in lower environments (for testing)
    if (_userRepo.userPermissions?.ReduceTracking == true &&
        (Env.isProd || Env.isBeta)) return;
    dataQueue.add(data);
    _processQueue();

    // Await timeout if provided
    if (timeout != null) {
      final end = DateTime.now().add(timeout);
      while (DateTime.now().isBefore(end)) {
        if (dataQueue.contains(data)) {
          await Future.delayed(const Duration(milliseconds: 50));
        } else {
          break;
        }
      }
    }
  }

  void _processQueue() async {
    if (_sending) return;
    _sending = true;
    while (dataQueue.isNotEmpty) {
      AnalyticsData next = dataQueue.first;
      await _sendData(next);
      dataQueue.remove(next);
    }
    _sending = false;
  }

  /// Attempts to upload a set of analytics data, retrying up to 10 times with exponential backoff
  Future<void> _sendData(AnalyticsData data) async {
    const maxAttempts = 10;
    int attempt = 0;
    int retryDelay = 500;
    while (true) {
      try {
        await _service.upload(data);
        break;
      } catch (e) {
        developer.log(
            'Failed to send analytics data on attempt $attempt, backing off and trying again.');
        attempt++;
        if (attempt < maxAttempts) {
          await Future.delayed(Duration(milliseconds: retryDelay));
          retryDelay *= 2;
        } else {
          // TODO: Log this to Crashlytics once Crashlytics is implemented
          developer
              .log('Failed to send analytics data after $maxAttempts attempts');
          break;
        }
      }
    }
  }
}

/// Stores context about the device, operating system, environment, etc. to be included when uploading analytics data
class AnalyticsContext {
  /// Device details
  final String deviceId;
  final String deviceManufacturer;
  final String deviceModel;
  final String deviceType; // Originally only sent by Android

  /// OS details
  final String osName;
  final String osVersion;

  AnalyticsContext({
    required this.deviceId,
    required this.deviceManufacturer,
    required this.deviceModel,
    required this.deviceType,
    required this.osName,
    required this.osVersion,
  });

  /// Provides an [AnalyticsContext] for the runtime platform
  static Future<AnalyticsContext> platform() {
    if (Platform.isIOS) {
      return iOS();
    } else if (Platform.isAndroid) {
      return android();
    } else {
      return unknown();
    }
  }

  /// Provides an [AnalyticsContext] for iOS devices
  static Future<AnalyticsContext> iOS() async {
    final device = await DeviceInfoPlugin().iosInfo;
    return AnalyticsContext(
      deviceId: device.identifierForVendor ?? '',
      deviceManufacturer: 'Apple',
      deviceModel: device.model,
      deviceType: 'iOS',
      osName: device.systemName,
      osVersion: device.systemVersion,
    );
  }

  /// Provides an [AnalyticsContext] for Android devices
  static Future<AnalyticsContext> android() async {
    final device = await DeviceInfoPlugin().androidInfo;
    return AnalyticsContext(
      // TODO: Use firebase installation ID as deviceId
      deviceId: '',
      deviceManufacturer: device.manufacturer,
      deviceModel: device.model,
      deviceType: 'android',
      osName: 'Android',
      osVersion: device.version.release,
    );
  }

  /// Provides an [AnalyticsContext] for unknown/unsupported platforms
  static Future<AnalyticsContext> unknown() async => AnalyticsContext(
        deviceId: 'unknown',
        deviceManufacturer: 'unknown',
        deviceModel: 'unknown',
        deviceType: 'unknown',
        osName: Platform.operatingSystem,
        osVersion: Platform.operatingSystemVersion,
      );

  Future<Map<String, dynamic>> toMap() async {
    final package = await PackageInfo.fromPlatform();
    final windowSize =
        WidgetsBinding.instance.platformDispatcher.views.first.physicalSize;
    return {
      'app': {
        'version': package.version,
        'build': package.buildNumber,
        'name': package.appName,
        'namespace': package.packageName,
      },
      'device': {
        'id': deviceId,
        'manufacturer': deviceManufacturer,
        'model': deviceModel,
        'type': deviceType,
      },
      'os': {
        'name': osName,
        'version': osVersion,
      },
      'screen': {
        'height': windowSize.height.round(),
        'width': windowSize.width.round(),
      },
      'locale': Platform.localeName,
      'timezone': await FlutterTimezone.getLocalTimezone(),
    };
  }
}
