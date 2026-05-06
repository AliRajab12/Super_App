import 'package:freezed_annotation/freezed_annotation.dart';

part 'rating_level.freezed.dart';
part 'rating_level.g.dart';

@freezed
class RatingLevel with _$RatingLevel {
  const factory RatingLevel({
    @JsonKey(name: 'Level') required int level,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Description') String? description,
  }) = _RatingLevel;

  factory RatingLevel.fromJson(Map<String, dynamic> json) =>
      _$RatingLevelFromJson(json);
}
