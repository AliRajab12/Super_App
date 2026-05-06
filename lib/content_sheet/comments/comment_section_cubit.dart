import 'package:somi/content_sheet/comments/comment_state.dart';
import 'package:somi/core/models/takeaway.dart';
import 'package:somi/core/models/user.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/user_service.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CommentsCubit extends Cubit<CommentState> {
  final UserService userService;
  final UserRepo userRepo;

  CommentsCubit(this.userService, this.userRepo) : super(const CommentState());

  Future<void> addComment(
      String comment, String itemType, int referenceId) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      User user = userRepo.user!;
      TakeAway takeAway = TakeAway(
          itemType: itemType,
          referenceId: referenceId,
          comment: comment,
          parentCommentUserKey: user.userProfileKey);
      await userService.addComment(takeAway);
      emit(state.copyWith(isAdded: true));
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }

  Future<void> getComment(
      String itemType, int referenceId, String localeId) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      await userService.getComments(referenceId, itemType, localeId);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
  }
}
