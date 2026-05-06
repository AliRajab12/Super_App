import 'package:freezed_annotation/freezed_annotation.dart';

part 'takeaway.freezed.dart';
part 'takeaway.g.dart';

@freezed
class TakeAway with _$TakeAway {
  const factory TakeAway({
    @JsonKey(name: 'ItemType') String? itemType,
    @JsonKey(name: 'referenceId') int? referenceId,
    @JsonKey(name: 'Comment') String? comment,
    @JsonKey(name: 'ParentCommentUserKey') int? parentCommentUserKey,
  }) = _TakeAway;

  factory TakeAway.fromJson(Map<String, dynamic> json) =>
      _$TakeAwayFromJson(json);
}
