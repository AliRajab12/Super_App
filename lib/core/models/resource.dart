import 'package:somi/core/models/rating.dart';
import 'package:somi/core/models/resource_type.dart';
import 'package:somi/core/models/tag.dart';
import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';
part 'resource.g.dart';

@freezed
class Resource with _$Resource {
  const factory Resource({
    @JsonKey(name: 'ResourceType') @Default(null) String? resourceType,
    @JsonKey(name: 'ResourceId') @Default(null) int? resourceId,
    @JsonKey(name: 'Type') @ResourceTypeJsonConverter() ResourceType? type,

    // typical resources use these fields
    @JsonKey(name: 'Title') @Default(null) String? title,
    @JsonKey(name: 'ProviderName') @Default(null) String? providerName,
    @JsonKey(name: 'Summary') @Default(null) String? summary,
    @JsonKey(name: 'Url') @Default(null) String? url,
    @JsonKey(name: 'internalUrl') @Default(null) String? internalUrl,
    @JsonKey(name: 'ImageUrl') @Default(null) String? imageUrl,
    @JsonKey(name: 'IsCompleted') @Default(false) bool isCompleted,
    @JsonKey(name: 'IsQueued') @Default(false) bool isQueued,
    @JsonKey(name: 'IsEnrolled') @Default(false) bool isEnrolled,
    @JsonKey(name: 'IsFollowing') @Default(false) bool isFollowing,
    @JsonKey(name: 'DurationDisplay') @Default(null) String? durationDisplay,
    @JsonKey(name: 'QueueItemId') @Default(null) int? queueItemId,
    @JsonKey(name: 'Description') @Default(null) String? description,
    @JsonKey(name: 'ExternalCompletionOnly')
    @Default(false)
    bool externalCompletionOnly,
    @JsonKey(name: 'ProviderImageInfo')
    @Default({})
    Map<String, String> providerImageInfo,

    // Something
    @JsonKey(name: 'MatchingSkills') int? matchingSkills,
    @JsonKey(name: 'Skills') List<String>? skills,

    // user resources use these fields
    @JsonKey(name: 'IsViewerFollowing') @Default(false) bool isViewerFollowing,
    @JsonKey(name: 'Picture') @Default(null) String? picture,
    @JsonKey(name: 'VanityUrl') @Default(null) String? vanityUrl,
    @JsonKey(name: 'Name') @Default(null) String? name,
    @JsonKey(name: 'UserProfileId') @Default(null) String? userProfileId,
    @JsonKey(name: 'UserProfileKey') @Default(null) int? userProfileKey,

    // targets
    @JsonKey(name: 'Level') @Default(null) int? level,
    @JsonKey(name: 'Rating') @Default(null) Rating? rating,
    @JsonKey(name: 'Ratings') @Default(null) List<Rating>? ratings,

    // groups
    @JsonKey(name: 'IsMember') @Default(false) bool isMember,
    @JsonKey(name: 'IsPendingMember') @Default(false) bool isPendingMember,
    @JsonKey(name: 'Members') @Default(null) List<User>? members,
    @JsonKey(name: 'MemberCount') @Default(null) int? memberCount,
    @JsonKey(name: 'PrivacyLevel') @Default(null) int? privacyLevel,

    // link texts
    @JsonKey(name: 'LinkTextId') @Default(null) int? linkTextId,
    @JsonKey(name: 'LinkTextValue') @Default(null) String? linkTextValue,
    @JsonKey(name: 'Label') @Default(null) String? label,
    @JsonKey(name: 'Link') @Default(null) String? link,

    // free texts
    @JsonKey(name: 'FreeformTextId') @Default(null) int? freeformTextId,
    @JsonKey(name: 'FreeformTextValue')
    @Default(null)
    String? freeformTextValue,

    // opportunities
    @JsonKey(name: 'Opportunity') @Default(null) int? opportunityId,
    @JsonKey(name: 'LocationName') @Default(null) String? locationName,
    @JsonKey(name: 'Tags')
    @TagListJsonConverter()
    @Default(null)
    List<Tag>? tags,
    @JsonKey(name: 'MatchedSkills')
    @TagListJsonConverter()
    @Default(null)
    List<Tag>? matchedSkills,
    @JsonKey(name: 'ApplicationStatusAsEnum')
    @Default(null)
    int? applicationStatusAsEnum,
  }) = _Resource;

  factory Resource.fromJson(Map<String, dynamic> json) =>
      _$ResourceFromJson(json);
}
