import 'package:freezed_annotation/freezed_annotation.dart';

part 'mention.freezed.dart';
part 'mention.g.dart';

@freezed
class Mention with _$Mention {
  const factory Mention({
    @JsonKey(name: 'UserProfileId') String? userProfileId,
    @JsonKey(name: 'UserProfileKey') int? userProfileKey,
    @JsonKey(name: 'FirstName') String? firstName,
    @JsonKey(name: 'Email') String? email,
    @JsonKey(name: 'VanityUrl') String? vanityUrl,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Tags') String? tags,
    @JsonKey(name: 'PrivacyId') int? privacyId,
    @JsonKey(name: 'TagNames') List<String>? tagNames,
    @JsonKey(name: 'Title') String? title,
  }) = _Mention;

  factory Mention.fromJson(Map<String, dynamic> json) =>
      _$MentionFromJson(json);
}
