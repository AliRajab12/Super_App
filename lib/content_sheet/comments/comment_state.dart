import 'package:somi/core/models/comment.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment_state.freezed.dart';

@freezed
class CommentState with _$CommentState {
  const factory CommentState({
    @Default(false) bool loading,
    @Default(false) bool isEdited,
    @Default(false) bool isAdded,
    @Default(0) int nextPageNumber,
    @Default(true) bool hasMorePages,
    @Default(null) Object? error,
    @Default([]) List<Comment> items,
  }) = _CommentState;
}
