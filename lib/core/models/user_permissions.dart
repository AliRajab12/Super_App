// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_permissions.freezed.dart';
part 'user_permissions.g.dart';

@freezed
class UserPermissions with _$UserPermissions {
  factory UserPermissions({
    @Default(false) bool Comment,
    @Default(false) bool Recommend,
    @Default(false) bool Assign,
    @Default(false) bool ShareSocial,
    @Default(false) bool HasTargets,
    @Default(false) bool AuthorTargets,
    @Default(false) bool AuthorPathways,
    @Default(false) bool HasPathways,
    @Default(false) bool IsRestricted,
    @Default(false) bool IsManaged,
    @Default(false) bool IsProfilePictureBlocked,
    @Default(false) bool CanUploadVideo,
    @Default(false) bool CanViewKnowledgeCenter,
    @Default(false) bool ManagerRatingEnabled,
    @Default(false) bool PeerRatingEnabled,
    @Default(false) bool ReduceTracking,
    @Default(false) bool BiometricAuthEnabled,
    @Default(false) bool CanManageGroups,
    @Default(false) bool IsParticipatingInUserSurveys,
    @Default(false) bool ShouldShowOnboardingTour,
    @Default(false) bool ShouldShowDataPrivacyAcceptance,
  }) = _UserPermissions;

  factory UserPermissions.fromJson(Map<String, dynamic> json) =>
      _$UserPermissionsFromJson(json);
}
