import 'package:somi/core/main_router.dart';
import 'package:somi/core/models/discover_response.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'discover_state_new.dart';

class DiscoverCubitNew extends Cubit<DiscoverStateNew> {
  final UserService userService;
  final MainRouter router;

  DiscoverCubitNew(this.userService, this.router)
      : super(const DiscoverStateNew()) {
    //countsRepo.addListener(updateCounts);
  }

  @override
  Future<void> close() {
    //countsRepo.removeListener(updateCounts);
    return super.close();
  }

  void updateCounts() {
    fetchData();
  }

  void fetchData({bool refresh = false, int memberTake = 10}) async {
    if (state.loading) return;

    // Set loading to true and clear error
    emit(state.copyWith(loading: true, error: null));

    // If refreshing, clear items and caches
    if (refresh) {
      await userService.clearContinueLearningCache();
      await userService.clearRecentlyViewedCache();
      await userService.clearDashboardTrendingDegreed();
      await userService.clearTodayFeedCache();
      //await countsRepo.refresh(silentFail: true);
      emit(
        state.copyWith(
            discoverItems: const DiscoverResponse(),
            recentlyViewedItems: const DiscoverResponse(),
            trendingItems: const DiscoverResponse(),
            todayFeedItems: []),
      );
    }

    try {
      final responseTodayFeed = await userService.getTodayFeed();

      final results = await Future.wait([
        userService.getContinueLearning(0, memberTake: memberTake),
        userService.getRecentlyViewed(0, memberTake: memberTake),
        userService.getDashboardTrendingDegreed(0, memberTake: memberTake),
      ]);
    } catch (e) {
      emit(state.copyWith(error: e));
    }
    emit(state.copyWith(loading: false));
  }
}
