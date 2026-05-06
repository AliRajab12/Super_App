import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somi/core/environment.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/pushnotifications/notification_prefs.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/repos/user_prefs.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/analytics_service.dart';
import 'package:somi/core/services/crash_utils.dart';
import 'package:somi/core/utils/device_utils.dart';
import 'package:somi/presentation/screens/launch/launch_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../presentation/screens/my_profile_screen/presentation/bloc/profile_bloc.dart';

import 'SuperApp_app.dart';

// ignore: non_constant_identifier_names
late AppEnvironment Env;

void initApp({AppEnvironment? env}) async {
  if (env != null) Env = env;

  runZonedGuarded<Future<void>>(() async {
    // Show a simple splash screen while initializing

    // runApp(const MaterialApp(debugShowCheckedModeBanner: false,home: SplashScreen()));

    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
    }
    setupLocator();

    await locator<CrashUtils>().init();
    await Hive.initFlutter();
    await locator<UserRepo>().init();
    await locator<UserPrefs>().init();
    await locator<AuthDataRepo>().init();
    await NetworkConfig.init(isNetworkLoggerEnabled: false);
    await locator<Analytics>().init();
    await locator<DeviceUtils>().init();
    await locator<NotificationPrefs>().init();
    //Enable below for push notifications
    /*bool isNotificationSet = locator<NotificationPrefs>().isNotificationSet;
    if (isNotificationSet) {
      await locator<PushNotificationService>().registerPushNotifications();
    }*/
    // runApp(const MaterialApp(
    //     debugShowCheckedModeBanner: false, home: LaunchScreen()));

    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc(),
          ),
        ],
        child: SuperApp(),
      ),
    );
  },
      (exception, stack) =>
          locator<CrashUtils>().collectDartError(exception, stack));
}
