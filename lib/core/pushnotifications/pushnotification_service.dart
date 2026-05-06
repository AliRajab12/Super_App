import 'dart:convert';

import 'package:somi/core/main_router.dart';
import 'package:somi/core/pushnotifications/notification_prefs.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// HandleBackgroundMessage should be a top level function as per firebase.
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  /*if (kDebugMode) {
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');
    print('Payload: ${message.data}');
  }*/
}

class PushNotificationService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final MainRouter _router;

  PushNotificationService(this._router);

  /// Custom notification channel for local notifications with app in foreground.
  final _androidChannel = const AndroidNotificationChannel(
    'high importance channel',
    'High importance notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  //Handle notification messages from background.
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    routeIncomingNotifications(message);
  }

  //Background notifications initialization
  Future<void> initBackgroundNotifications() async {
    //Mainly required for iOS foreground push notification.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    //App is opened from a notification in terminated state.
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    //App is opened from a notification in background state.
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    //Local notifications
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotifications.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              _androidChannel.id,
              _androidChannel.name,
              channelDescription: _androidChannel.description,
              icon: '@drawable/ic_launcher',
            ),
          ),
          payload: jsonEncode(message.toMap()));
    });
  }

  // Local notifications initialization
  Future<void> initLocalNotifications() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) async {
        final message =
            RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
        handleMessage(message);
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  //Used to access permissions from different points in the app.
  Future<bool> requestNotificationPermissions() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    /*if (kDebugMode) {
      print('Permission value returned: ${settings.authorizationStatus}');
    }*/

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    }
    return false;
  }

  // On iOS below will show the permission dialog.
  // From android 13 devices. Permission dialog will be shown
  Future<void> registerPushNotifications() async {
    NotificationSettings settings =
        await _firebaseMessaging.requestPermission();
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      _firebaseMessaging.getToken().then((token) {
        //Enable below to test if token is registered from physical device
        /*if (kDebugMode) {
          print('Device Token: ' '$token');
        }*/
        locator<AuthDataRepo>().storeNotificationToken(token ?? '');
        locator<NotificationPrefs>().setNotification(true);
      });

      initBackgroundNotifications();
      initLocalNotifications();
    }
  }

  //Deep link push notification to different apps in the screen
  //More cases will be added when courses, plans and pathways are complete.
  void routeIncomingNotifications(RemoteMessage? message) {
    var contentUrl = message?.data['contentUrl'] ?? '';
    final deepLink = Uri.parse(contentUrl);
    final deepLinkPath = deepLink.pathSegments[0];

    if (deepLinkPath.isNotEmpty) {
      switch (deepLinkPath) {
        case 'pathway':
          navigateToPathway();
        case 'plan':
          navigateToPlan();
        default:
          navigateToMain();
      }
    }
  }

//This needs to navigate to Pathway page when it is implemented.
//At present going to Notification list screen for testing deep links through push notification.
  void navigateToPathway() async {
    _router.replaceAll([const NotificationListScreenRoute()]);
  }

//This needs to navigate to Pathway page when it is implemented
//At present going to Profile screen for testing deep links through push notification.
  void navigateToPlan() async {
    _router.replaceAll([const ProfileMenuScreenRoute()]);
  }

  void navigateToMain() async {
    _router.replaceAll([const DashboardScreenRoute()]);
  }
}
