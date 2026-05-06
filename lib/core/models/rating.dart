import 'package:somi/core/utils/json_converters.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating.freezed.dart';

part 'rating.g.dart';

@freezed
class Rating with _$Rating {
  const factory Rating({
    @JsonKey(name: 'DateCompleted') @Default(null) String? dateCompleted,
    @JsonKey(name: 'Level') @Default(null) @StringAsInt() int? level,
    @JsonKey(name: 'PrivacyId') @Default(null) int? privacyId,
    @JsonKey(name: 'RaterProfileKey') @Default(null) int? raterProfileKey,
    @JsonKey(name: 'TagId') @Default(null) int? tagId,
    @JsonKey(name: 'Type') @Default(null) String? type,
    @JsonKey(name: 'UserProfileKey') @Default(null) int? userProfileKey,
    @JsonKey(name: 'UserTagRatingId') @Default(null) int? userTagRatingId,
    @JsonKey(name: 'IsInternal') @Default(false) bool isInternal,
  }) = _Rating;

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);
}
