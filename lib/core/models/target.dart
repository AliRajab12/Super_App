import 'package:somi/core/models/primary_contact.dart';
import 'package:somi/core/models/sections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'target.freezed.dart';

part 'target.g.dart';

@freezed
class Target with _$Target {
  const factory Target({
    @JsonKey(name: 'TargetId') @Default(0) int targetId,
    @JsonKey(name: 'Name') @Default('') String name,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'PrivacyId') @Default(0) int privacyId,
    @JsonKey(name: 'AuthorKeysString') String? authorKeysString,
    @JsonKey(name: 'IsFollowing') bool? isFollowing,
    @JsonKey(name: 'FollowerCount') int? followerCount,
    @JsonKey(name: 'IsPrimary') bool? isPrimary,
    @JsonKey(name: 'PrimaryCount') @Default(0) int primaryCount,
    @JsonKey(name: 'TargetType') String? targetType,
    @JsonKey(name: 'Subtitle') String? subtitle,
    @JsonKey(name: 'IsFollowable') bool? isFollowable,
    @JsonKey(name: 'CanCollaborate') bool? canCollaborate,
    @JsonKey(name: 'IsEndorsed') bool? isEndorsed,
    @JsonKey(name: 'IsFeatured') bool? isFeatured,
    @JsonKey(name: 'DateModified') String? dateModified,
    @JsonKey(name: 'DateCreated') String? dateCreated,
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'TagNames') List<String>? tagNames,
    @JsonKey(name: 'Authors') List<User>? authors,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'PrimaryContact') PrimaryContact? primaryContact,
    @JsonKey(name: 'Sections') List<Sections>? sections,
  }) = _Target;

  factory Target.fromJson(Map<String, dynamic> json) => _$TargetFromJson(json);
}
