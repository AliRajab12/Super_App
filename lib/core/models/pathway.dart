import 'package:freezed_annotation/freezed_annotation.dart';

part 'pathway.freezed.dart';
part 'pathway.g.dart';

@freezed
class Pathway with _$Pathway {
  const factory Pathway({
    @JsonKey(name: 'Id') @Default(0) int id,
    @JsonKey(name: 'Title') @Default('') String title,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'IsEnrolled') @Default(false) bool isEnrolled,
    @JsonKey(name: 'IsQueued') @Default(false) bool isQueued,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'AuthorProfileKeys')
    @Default([])
    List<int> authorProfileKeys,
    @JsonKey(name: 'PercentComplete') @Default(null) double? percentComplete,
    @JsonKey(name: 'Progress') @Default(null) double? progress,
    @JsonKey(name: 'QueueItemId') @Default(null) int? queueItemId,
  }) = _Pathway;

  factory Pathway.fromJson(Map<String, dynamic> json) =>
      _$PathwayFromJson(json);
}
