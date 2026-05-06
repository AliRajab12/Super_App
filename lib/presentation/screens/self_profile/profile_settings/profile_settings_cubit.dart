import 'dart:io';
import 'dart:typed_data';

import 'package:somi/core/main_router.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/image_cropper.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image_picker/image_picker.dart';

class ProfileSettingsCubit extends Cubit<ProfileSettingsState> {
  final UserRepo userRepo;
  final UserService userService;
  final CacheManager cacheManager;
  final ImagePicker imagePicker;
  final MainRouter router;

  ProfileSettingsCubit._(
    super.initialState,
    this.userRepo,
    this.userService,
    this.cacheManager,
    this.imagePicker,
    this.router,
  );

  factory ProfileSettingsCubit.initWith(
    UserRepo userRepo,
    UserService userService,
    CacheManager cacheManager,
    ImagePicker imagePicker,
    MainRouter router,
  ) {
    final user = userRepo.user!;
    final initState = ProfileSettingsState(
      firstName: user.firstName ?? '',
      lastName: user.lastName ?? '',
      bio: user.bio ?? '',
      editedFirstName: user.firstName ?? '',
      editedLastName: user.lastName ?? '',
      editedBio: user.bio ?? '',
      picturePath: user.picture,
      canEditProfile: userRepo.userPermissions?.IsProfilePictureBlocked != true,
      canEditPicture: userRepo.userPermissions?.IsManaged != true,
    );
    return ProfileSettingsCubit._(
      initState,
      userRepo,
      userService,
      cacheManager,
      imagePicker,
      router,
    );
  }

  void setEditedFirstName(String editedFirstName) {
    emit(state.copyWith(editedFirstName: editedFirstName));
  }

  void setEditedLastName(String editedLastName) {
    emit(state.copyWith(editedLastName: editedLastName));
  }

  void setEditedBio(String editedBio) {
    emit(state.copyWith(editedBio: editedBio));
  }

  Future<void> saveProfile() async {
    try {
      emit(state.copyWith(isSavingProfile: true));
      await userService.updateProfile(
        state.firstName == state.editedFirstName ? null : state.editedFirstName,
        state.lastName == state.editedLastName ? null : state.editedLastName,
        state.bio == state.editedBio ? null : state.editedBio,
      );
      emit(state.copyWith(
        firstName: state.editedFirstName,
        lastName: state.editedLastName,
        bio: state.editedBio,
      ));
    } catch (e) {
      emit(state.copyWith(profileSaveError: e));
    } finally {
      emit(state.copyWith(isSavingProfile: false));
    }
  }

  Future<void> updatePicture() async {
    emit(state.copyWith(isSavingPicture: true));
    final XFile? sourceImage = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      requestFullMetadata: false,
    );
    if (sourceImage == null) {
      emit(state.copyWith(isSavingPicture: false));
      return;
    }

    try {
      final Uint8List? imageBytes = await router.pushWidget(
          ImageCropper(source: File(sourceImage.path)),
          fullscreenDialog: true);
      if (imageBytes != null) {
        emit(state.copyWith(editedPictureData: imageBytes));

        await userService.updateProfilePicture(imageBytes);

        // Precache the new image
        final newPictureUrl = userRepo.user?.picture ?? '';
        await cacheManager.downloadFile(newPictureUrl);

        emit(state.copyWith(picturePath: newPictureUrl));
      }
    } catch (e) {
      emit(state.copyWith(pictureSaveError: e));
    } finally {
      emit(state.copyWith(isSavingPicture: false, editedPictureData: null));
    }
  }

  Future<void> resetOnboarding() async {
    try {
      await userService.resetOnboarding();
      userRepo.skipOnboarding = false;
      router.replaceAll([const LaunchScreenRoute()]);
    } catch (e) {
      emit(state.copyWith(resetOnboardingError: e));
    }
  }
}
