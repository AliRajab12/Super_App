import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_settings_state.freezed.dart';

@freezed
class ProfileSettingsState with _$ProfileSettingsState {
  const ProfileSettingsState._();

  const factory ProfileSettingsState({
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String bio,
    @Default(null) String? picturePath,
    @Default('') String editedFirstName,
    @Default('') String editedLastName,
    @Default('') String editedBio,
    @Default(null) Uint8List? editedPictureData,
    @Default(false) bool canEditProfile,
    @Default(false) bool canEditPicture,
    @Default(false) bool isSavingPicture,
    @Default(false) bool isSavingProfile,
    @Default(null) Object? pictureSaveError,
    @Default(null) Object? profileSaveError,
    @Default(null) Object? resetOnboardingError,
  }) = _ProfileSettingsState;

  bool get hasProfileChanges =>
      editedFirstName != firstName ||
      editedLastName != lastName ||
      editedBio != bio;
}
