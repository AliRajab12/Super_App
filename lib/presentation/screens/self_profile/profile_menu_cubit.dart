import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_state.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/main_router.dart';

class ProfileMenuCubit extends Cubit<ProfileMenuState> {
  final PackageInfo packageInfo;
  final UserService userService;
  final UserRepo userRepo;
  final MainRouter router;

  ProfileMenuCubit(
      this.packageInfo, this.router, this.userService, this.userRepo)
      : super(
          ProfileMenuState(
            user: userRepo.user,
            appVersion: packageInfo.version,
          ),
        );

  void init() {
    userRepo.userListenable.addListener(onUserUpdated);
  }

  void onUserUpdated() =>
      emit(state.copyWith(user: userRepo.userListenable.value));

  void navigateToProfileSettings() =>
      router.pushWidget(const ProfileSettingsScreen());

  void performSignOut() {
    emit(state.copyWith(isSigningOut: true));
    userService.performLogout(manual: true);
  }

  @override
  Future<void> close() async {
    userRepo.userListenable.removeListener(onUserUpdated);
    super.close();
  }
}
