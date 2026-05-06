import 'package:collection/collection.dart';
import 'package:somi/core/models/rating.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.freezed.dart';

part 'tag.g.dart';

@freezed
class Tag with _$Tag {
  const Tag._();

  const factory Tag({
    @JsonKey(name: 'TagId') @Default(0) int id,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Position') int? position,
    @JsonKey(name: 'IsFollowing') bool? isFollowing,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'RequestingUserIsFocused') bool? isFocused,
    @JsonKey(name: 'RequestingUserIsMentoring') bool? isMentoring,
    @JsonKey(name: 'InternalUrl') String? internalUrl,
    @JsonKey(name: 'ResourceId') int? resourceId,
    @JsonKey(name: 'ResourceType') String? resourceType,
    @JsonKey(name: 'Rating') Rating? rating,
    @JsonKey(name: 'Ratings') @Default([]) List<Rating> ratings,
    @JsonKey(name: 'AvailableRatingTypes')
    @Default({})
    Set<String> availableRatingTypes,
  }) = _Tag;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  int? get firstRatingLevel {
    return rating?.level ??
        ratings.firstWhereOrNull((r) => r.level != null)?.level;
  }

  Rating? get selfRating {
    if (rating?.type == 'Self') return rating;
    return ratings.firstWhereOrNull((e) => e.type == 'Self');
  }
}

class TagListJsonConverter implements JsonConverter<List<Tag>?, dynamic> {
  const TagListJsonConverter();

  @override
  List<Tag>? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) {
      return json.split(',').map((e) => Tag(name: e)).toList();
    } else if (json is List<dynamic>) {
      return List.from(json.map((value) => Tag.fromJson(value)).toList());
    }
    return null;
  }

  @override
  dynamic toJson(List<Tag>? resourceType) {
    return null;
  }
}
