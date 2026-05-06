import 'package:somi/core/models/mention.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';
part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'ParentId') int? parentId,
    @JsonKey(name: 'Comment') String? comment,
    @JsonKey(name: 'ShowReadMore') bool? showReadMore,
    @JsonKey(name: 'UserProfileKey') int? userProfileKey,
    @JsonKey(name: 'ProfileImage') String? profileImage,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'UserUrl') String? userUrl,
    @JsonKey(name: 'DateAdded') String? dateAdded,
    @JsonKey(name: 'IsInappropriate') bool? isInappropriate,
    @JsonKey(name: 'IsOwner') bool? isOwner,
    @JsonKey(name: 'FavoritedByUser') bool? favoritedByUser,
    @JsonKey(name: 'FavoritedCount') int? favoritedCount,
    @JsonKey(name: 'HasShowMoreReplies') bool? hasShowMoreReplies,
    @JsonKey(name: 'RemainingReplies') int? remainingReplies,
    @JsonKey(name: 'ReplyLimit') int? replyLimit,
    @JsonKey(name: 'Edited') bool? edited,
    @JsonKey(name: 'Replies') List<Comment>? replies,
    @JsonKey(name: 'Mentions') List<Mention>? mentions,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
