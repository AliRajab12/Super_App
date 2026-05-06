import 'package:somi/content_sheet/comments/comment_section_cubit.dart';

import 'package:somi/content_sheet/bookmark/bookmark_cubit.dart';
import 'package:somi/content_sheet/markcomplete/markcomplete_cubit.dart';

import 'package:somi/core/init.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/pushnotifications/notification_prefs.dart';
import 'package:somi/core/pushnotifications/pushnotification_service.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/repos/org_skill_rating_repo.dart';
import 'package:somi/core/repos/user_prefs.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/analytics_service.dart';
import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/core/services/auth/sso/sso_authenticator.dart';
import 'package:somi/core/services/content_access_token_service.dart';
import 'package:somi/core/services/crash_utils.dart';
import 'package:somi/core/services/group_service.dart';
import 'package:somi/core/services/opportunity_service.dart';
import 'package:somi/core/services/resource_service.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/core/services/user_visa_services.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:somi/core/utils/content_launcher.dart';
import 'package:somi/core/utils/device_utils.dart';
import 'package:somi/core/utils/url_launcher.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_cubit.dart';
import 'package:somi/presentation/common/bloc/payment_bloc.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_cubit.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:somi/presentation/screens/launch/data_privacy_acceptance/data_privacy_acceptance_cubit.dart';
import 'package:somi/presentation/screens/launch/launch_cubit.dart';
import 'package:somi/presentation/screens/learn/discover/discover_cubit.dart';
import 'package:somi/presentation/screens/learn/new/discover_cubit_new.dart';
import 'package:somi/presentation/screens/login/forgot_password/forgot_password_cubit.dart';
import 'package:somi/presentation/screens/login/login_cubit.dart';
import 'package:somi/presentation/screens/login/reset_password/reset_password_cubit.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/bloc/documents_bloc.dart';
import 'package:somi/presentation/screens/notification/presentation/bloc/notification_list_bloc.dart';
import 'package:somi/presentation/screens/notification/presentation/bloc/notification_list_event.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_event.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_cubit.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:platform/platform.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import '../presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import '../presentation/screens/my_profile_screen/presentation/bloc/profile_bloc.dart';
import 'services/payment_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  /// ---- Services ----

  locator.registerLazySingleton<PushNotificationService>(
      () => PushNotificationService(locator<MainRouter>()));

  locator.registerLazySingleton<NotificationPrefs>(() => NotificationPrefs());

  locator.registerLazySingleton<Analytics>(() => Analytics());

  locator.registerLazySingleton<AnalyticsService>(() => AnalyticsService());

  locator.registerSingleton<AuthService>(AuthService());

  locator.registerSingleton<CrashUtils>(CrashUtils());

  locator.registerSingleton<NetworkProvider>(NetworkProvider());

  locator.registerLazySingleton<OpportunityService>(
      () => OpportunityService(locator<NetworkProvider>()));

  locator.registerLazySingleton<ResourceService>(
      () => ResourceService(locator<NetworkProvider>()));

  locator.registerSingleton<SecurityProvider>(SecurityProvider());

  locator.registerSingleton<SsoAuthenticator>(
    SsoAuthenticator(const LocalPlatform(), Env, ExternalSsoAuthenticator()),
  );

  locator
      .registerSingleton<UserService>(UserService(locator<NetworkProvider>()));

  locator.registerSingleton<UserVisaService>(
      UserVisaService(locator<NetworkProvider>()));
  locator.registerSingleton<PaymentService>(
      PaymentService(locator<NetworkProvider>()));
  locator.registerSingleton<GroupService>(
      GroupService(locator<NetworkProvider>()));

  locator.registerSingleton<ContentAccessTokenService>(
      ContentAccessTokenService(locator<NetworkProvider>()));

  /// ---- Repos ----

  locator.registerSingleton<AuthDataRepo>(AuthDataRepo());

  locator.registerLazySingleton<OrgSkillRatingRepo>(
      () => OrgSkillRatingRepo(locator<UserService>()));

  locator.registerSingleton<UserRepo>(UserRepo());

  /// ---- BLoCs/Cubits ----

  locator.registerFactory<BookMarkCubit>(
    () => BookMarkCubit(
      locator<UserService>(),
    ),
  );

  locator.registerFactory<MarkCompleteCubit>(
    () => MarkCompleteCubit(
      locator<UserService>(),
    ),
  );
  // locator.registerFactory<CarDetailsCubit>(
  //   () => CarDetailsCubit(),
  // );
  locator.registerLazySingleton<CarBloc>(
    () => CarBloc(),
  );
  locator.registerFactory<ProfileBloc>(
    () => ProfileBloc(),
  );
  locator.registerFactory<DataPrivacyAcceptanceCubit>(
    () => DataPrivacyAcceptanceCubit(
      locator<UserService>(),
      locator<UserRepo>(),
      locator<MainRouter>(),
    ),
  );

  locator.registerFactory<DiscoverCubit>(
    () => DiscoverCubit(locator<UserService>()),
  );

  locator.registerFactory<DiscoverCubitNew>(
    () => DiscoverCubitNew(
      locator<UserService>(),
      locator<MainRouter>(),
    ),
  );

  locator.registerFactory<ForgotPasswordCubit>(
      () => ForgotPasswordCubit(locator<AuthService>()));

  locator.registerFactory<LaunchCubit>(
    () => LaunchCubit(
      locator<AuthDataRepo>(),
      locator<MainRouter>(),
      locator<UserRepo>(),
      // locator<GlobalKey<SuperAppThemeState>>().currentState!,
      locator<UserService>(),
      locator<NotificationPrefs>(),
      locator<PushNotificationService>(),
    ),
  );

  locator.registerFactory<LoginCubit>(
    () => LoginCubit(
      //locator<AppLocalizations>(),
      locator<AuthService>(),
      locator<AuthDataRepo>(),
      locator<MainRouter>(),
      locator<SsoAuthenticator>(),
    ),
  );

  // locator.registerFactory<NotificationPreferencesCubit>(
  //   () => NotificationPreferencesCubit(
  //     locator<UserService>(),
  //     locator<Analytics>(),
  //   ),
  // );

  // locator.registerFactory<OnboardingCubit>(
  //   () => OnboardingCubit(
  //     locator<UserService>(),
  //     locator<MainRouter>(),
  //     locator<UserRepo>(),
  //   ),
  // );

  // locator.registerFactory<OnboardingSkillSearchCubit>(
  //   () => OnboardingSkillSearchCubit(
  //     locator<UserService>(),
  //     locator<MainRouter>(),
  //   ),
  // );

  locator.registerFactory<ProfileMenuCubit>(
    () => ProfileMenuCubit(
      locator<PackageInfo>(),
      locator<MainRouter>(),
      locator<UserService>(),
      locator<UserRepo>(),
    ),
  );

  locator.registerFactory<ProfileSettingsCubit>(
    () => ProfileSettingsCubit.initWith(
      locator<UserRepo>(),
      locator<UserService>(),
      locator<CacheManager>(),
      locator<ImagePicker>(),
      locator<MainRouter>(),
    ),
  );

  locator.registerFactory<ResetPasswordCubit>(
    () => ResetPasswordCubit(
      locator<AuthService>(),
      locator<AuthDataRepo>(),
      locator<MainRouter>(),
    ),
  );

  locator.registerFactoryParam<ReportAProblemCubit, Input?, String?>(
    (input, source) => ReportAProblemCubit(
      input,
      source,
      locator<ResourceService>(),
    ),
  );

  locator.registerFactory<CommentsCubit>(
    () => CommentsCubit(
      locator<UserService>(),
      locator<UserRepo>(),
    ),
  );

  locator.registerFactory<DashboardSearchCubit>(
    () => DashboardSearchCubit(
      locator<UserService>(),
    ),
  );
  locator.registerLazySingleton<HomeScreenBloc>(
      () => HomeScreenBloc(locator<MainRouter>(), locator<UserService>()));

  locator.registerLazySingleton<VisaAppBloc>(
      () => VisaAppBloc(userVisaService: locator<UserVisaService>()));
  locator.registerLazySingleton<PaymentBloc>(
    () => PaymentBloc(
      paymentService: locator<PaymentService>(),
    ),
  );
  locator.registerLazySingleton<SavedAddressesBloc>(() =>
      SavedAddressesBloc(userService: locator<UserService>())
        ..add(const FetchSavedAddresses()));
  locator.registerLazySingleton<NotificationListBloc>(() =>
      NotificationListBloc(userService: locator<UserService>())
        ..add(const FetchNotificationList()));
  locator.registerLazySingleton<DocumentsBloc>(
      () => DocumentsBloc(userService: locator<UserService>()));

  /// ---- Other ----

  locator.registerLazySingleton<CacheManager>(() => DefaultCacheManager());

  locator.registerLazySingleton<DeviceUtils>(() => DeviceUtils());

  locator.registerFactory<ImagePicker>(() => ImagePicker());

  locator.registerSingleton(MainRouter());

  locator.registerSingleton<GlobalKey<SuperAppThemeState>>(
      GlobalKey<SuperAppThemeState>());

  // locator.registerFactory<AppLocalizations>(
  //     () => AppLocalizations.delegate.current);

  locator.registerSingleton<UserPrefs>(UserPrefs());

  locator.registerSingleton<UrlLauncher>(UrlLauncher());

  locator.registerSingleton<ContentLauncher>(ContentLauncher(
      locator<AuthDataRepo>(),
      locator<UrlLauncher>(),
      locator<ContentAccessTokenService>()));

  locator.registerSingletonAsync<PackageInfo>(
      () async => PackageInfo.fromPlatform());
}
