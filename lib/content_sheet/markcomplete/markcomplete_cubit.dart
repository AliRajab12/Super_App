import 'package:somi/content_sheet/markcomplete/markcomplete_state.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/resource.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MarkCompleteCubit extends Cubit<MarkCompleteState> {
  final UserService userService;

  MarkCompleteCubit(this.userService) : super(const MarkCompleteState());

  Future<void> toggleMarkComplete(String resourceId, String resourceType,
      Input input, bool toggledMarkComplete) async {
    Resource? inputReference = input.reference;
    final originalState = state;
    emit(state.copyWith(toggleLoading: true, error: null));
    try {
      if (toggledMarkComplete) {
        Input input = Input(
          isCompleted: true,
          inputId: int.parse(resourceId),
          inputType: resourceType,
          reference: inputReference,
        );
        await userService.markItemCompleted(input);
        emit(originalState.copyWith(
            toggleComplete: DegreedConstants.itemCompleted));
      } else {
        await userService.markItemNotCompleted(resourceType, resourceId);
        emit(originalState.copyWith(
            toggleComplete: DegreedConstants.itemNotCompleted));
      }
    } catch (e) {
      emit(originalState.copyWith(toggleError: e));
    }
  }

  Future<void> emitNotComplete() async {
    emit(state.copyWith(toggleComplete: DegreedConstants.itemNotCompleted));
  }
}
