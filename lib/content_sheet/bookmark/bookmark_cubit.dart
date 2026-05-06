import 'package:somi/content_sheet/bookmark/bookmark_state.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/resource.dart';
import 'package:somi/core/repos/user_prefs.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookMarkCubit extends Cubit<BookMarkState> {
  final UserService userService;

  BookMarkCubit(this.userService) : super(const BookMarkState());

  Future<void> toggleSave(
    String resourceId,
    String resourceType,
    Input receivedInput,
    bool toggledSave,
    String queueItemId,
  ) async {
    Resource? inputReference = receivedInput.reference;
    String queueItemIdResponse = '';
    final originalState = state;
    locator<UserPrefs>().saveQueueID(queueItemId);

    emit(state.copyWith(toggleSaveLoading: true, error: null));
    try {
      if (toggledSave) {
        Input input = Input(
          isCompleted: true,
          inputId: int.parse(resourceId),
          inputType: resourceType,
          reference: inputReference,
        );
        final response = await userService.markItemSaved(input);
        queueItemIdResponse = response.queueItemId.toString();
        locator<UserPrefs>().saveQueueID(queueItemIdResponse);
        emit(originalState.copyWith(toggleSaved: DegreedConstants.itemSaved));
      } else {
        queueItemIdResponse = locator<UserPrefs>().queueId.toString();
        await userService.markItemNotSaved(queueItemIdResponse);
        emit(
            originalState.copyWith(toggleSaved: DegreedConstants.itemNotSaved));
      }
    } catch (e) {
      emit(originalState.copyWith(toggleError: e));
    }
  }
}
