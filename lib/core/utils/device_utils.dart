import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceUtils {
  late BaseDeviceInfo deviceInfo;

  Future<void> init() async {
    final infoPlugin = DeviceInfoPlugin();
    deviceInfo = await infoPlugin.deviceInfo;
  }

  bool get supportsAvif {
    // AVIF decode is supported on iOS 16+.
    //
    // It is also supported on Android API 31+ (Android 12), but there seem to be issues with it at the moment:
    //  https://github.com/flutter/flutter/issues/105532
    //
    // I have also directly observed rendering issues with certain AVIF images on Android 13,
    // so for now we'll only support AVIF on iOS 16+.
    return isIosVersionAtOrAbove(16.0);
  }

  bool isAndroidVersionAtOrAbove(int sdkInt) {
    if (Platform.isAndroid) {
      return (deviceInfo as AndroidDeviceInfo).version.sdkInt >= sdkInt;
    }
    return false;
  }

  bool isIosVersionAtOrAbove(double version) {
    if (Platform.isIOS) {
      double systemVersion =
          double.tryParse((deviceInfo as IosDeviceInfo).systemVersion) ?? 0;
      return systemVersion >= version;
    }
    return false;
  }
}
