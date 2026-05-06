// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();

  const factory User({
    @JsonKey(name: 'UserProfileId') String? userProfileId,
    @JsonKey(name: 'UserProfileKey') int? userProfileKey,
    @JsonKey(name: 'MasterPoints') String? masterPoints,
    @JsonKey(name: 'FollowerCount') int? followerCount,
    @JsonKey(name: 'FollowingCount') int? followingCount,
    @JsonKey(name: 'GroupsCount') int? groupsCount,
    @JsonKey(name: 'FirstName') String? firstName,
    @JsonKey(name: 'OnboardDate') String? onboardDate,
    @JsonKey(name: 'LastName') String? lastName,
    @JsonKey(name: 'Email') String? email,
    @JsonKey(name: 'VanityUrl') String? vanityUrl,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Tags') String? tags,
    @JsonKey(name: 'PrivacyId') int? privacyId,
    @JsonKey(name: 'Picture') String? picture,
    @JsonKey(name: 'TagNames') List<String>? tagNames,
    @JsonKey(name: 'OrgId') int? orgId,
    @JsonKey(name: 'OrgName') String? orgName,
    @JsonKey(name: 'Bio') String? bio,
    @JsonKey(name: 'IsEngaged') bool? isEngaged,
    @JsonKey(name: 'UserFollows') bool? userFollows,
    @JsonKey(name: 'LocaleId') String? localeId,
    bool? viewersCanFollow,
    @JsonKey(name: 'JobRole') String? jobRole,
    @JsonKey(name: 'Location') String? location,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  bool get isInOrg => (orgId ?? 0) > 0;
}
