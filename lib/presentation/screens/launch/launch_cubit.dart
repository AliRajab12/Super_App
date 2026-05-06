import 'dart:io';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/pushnotifications/notification_prefs.dart';
import 'package:somi/core/pushnotifications/pushnotification_service.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:somi/presentation/screens/launch/data_privacy_acceptance/data_privacy_acceptance_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LaunchCubit extends Cubit<LaunchState> {
  final AuthDataRepo _authRepo;
  final MainRouter _router;
  final UserRepo _userRepo;
  //final SuperAppThemeState _appTheme;
  final UserService _userService;
  final NotificationPrefs _notificationPrefs;
  final PushNotificationService _pushNotificationService;

  LaunchCubit(
    this._authRepo,
    this._router,
    this._userRepo,
    // this._appTheme,
    this._userService,
    this._notificationPrefs,
    this._pushNotificationService,
  ) : super(LaunchState.loading);

  Future<void> initialize() async {
    emit(LaunchState.loading);

    //Enable during push notifications
    /*bool isNotificationSet = _notificationPrefs.isNotificationSet;
    if (!isNotificationSet) {
      registerPushNotifications();
    }*/

    // Verify the user is authenticated. If not, go to the login screen.
    if (!_authRepo.hasAuth) {
      navigateToLogin();
      return;
    }

    // Check if the user needs to accept the Data Privacy Agreement
    /*if (_userRepo.userPermissions?.ShouldShowDataPrivacyAcceptance == true) {
      String? dpaMessage =
          _userRepo.orgSettings?.DataPrivacyAcceptanceMessage ?? '';
      if (await _router.pushWidget(DataPrivacyAcceptanceScreen(dpaMessage)) !=
          true) {
        logOut();
        return;
      }
    }*/

    // Check if device token exists
    /*bool isTokenAdded = _notificationPrefs.isNotificationTokenAdded;
    if (!isTokenAdded) {
      String deviceToken = _authRepo.notificationToken;
      String platformName = Platform.isAndroid ? 'Android' : 'iOS';

      if (deviceToken.isNotEmpty) {
        try {
          await _userService.registerFirebaseTokenBackend(
              deviceToken, platformName);
          _notificationPrefs.setNotificationTokenAdded(true);
        } catch (e) {
          _notificationPrefs.setNotificationTokenAdded(false);
        }
      }
    }*/

    // Check if the user needs to complete the onboarding process
    /*if (!_userRepo.skipOnboarding && _userRepo.userPermissions?.ShouldShowOnboardingTour == true) {
      await _router.pushWidget(
        const OnboardingScreen(),
        transitionBuilder: (context, animation, secondaryAnimation, child) {
          return ClipPath(
            clipper: CenterCircleClipper(percent: animation.value),
            child: child,
          );
        },
      );

      // Wait for transition animation
      await Future.delayed(const Duration(seconds: 1));
    }*/

    // Proceed to the dashboard if everything was successful
    navigateToMain();
  }

  void navigateToMain() async {
    await Future.delayed(const Duration(milliseconds: 2800))
        .then((value) => _router.replaceAll([const HomeScreenRoute()]));
  }

  Future<void> navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 2800))
        .then((value) => _router.replace(LoginScreenRoute()));
  }

  void logOut() {
    _userService.performLogout(manual: true);
  }

  Future<void> registerPushNotifications() async {
    await _pushNotificationService.registerPushNotifications();
  }
}

enum LaunchState {
  loading,
  commError,
  unknownError,
}
