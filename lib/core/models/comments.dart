import 'package:somi/core/models/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comments.freezed.dart';
part 'comments.g.dart';

@freezed
class Comments with _$Comments {
  const factory Comments({
    @JsonKey(name: 'ObjectType') required String objectType,
    @JsonKey(name: 'ObjectId') required int objectId,
    @JsonKey(name: 'RemainingComments') required int remainingComments,
    @JsonKey(name: 'Feed') required List<Comment> feed,
    @JsonKey(name: 'HasMoreItems') bool? hasMoreItems,
  }) = _Comments;

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);
}
