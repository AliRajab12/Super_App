import 'package:somi/core/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'discover_state.dart';

class DiscoverCubit extends Cubit<DiscoverState> {
  final UserService userService;

  DiscoverCubit(this.userService) : super(const DiscoverState());

  @override
  Future<void> close() {
    return super.close();
  }

  void updateCounts() {
    fetchData();
  }

  void fetchData({bool refresh = false}) async {
    if (state.loading) return;

    // Set loading to true and clear error
    emit(state.copyWith(loading: true, error: null));

    // If refreshing, clear items and caches
    if (refresh) {
      await userService.clearTodayFeedCache();
      emit(state.copyWith(
        continueLearningItems: [],
      ));
    }

    try {
      final inputs = await userService.getTodayFeed();
      /*emit(state.copyWith(
        counts: countsRepo.value,
        continueLearningItems: inputs,
      ));*/
    } catch (e) {
      emit(state.copyWith(error: e));
    }
    emit(state.copyWith(loading: false));
  }
}
