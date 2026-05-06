import 'package:bloc/bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/pages/field_worker_profile_page.dart';
import 'home_screen_event.dart';
import 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final MainRouter _router;
  final UserService userService;
  HomeScreenBloc(this._router, this.userService)
      : super(const HomeScreenState()) {
    on<NavigateToServiceScreen>((event, emit) {
      switch (event.index) {
        case 0:
          _router.navigate(const CarRentalScreenRoute());
          break;
        case 1:
          _router.navigate(const TouristVisaScreenRoute());
          break;
        case 2:
          _router.navigate(const SomiPhoneLoginRoute());
          break;
        case 3:

          ///TODO change this destination online Clinic
          _router.navigate(DoctorHomePageRoute());
          break;
        case 4:
          _router.navigate(const SomiPhoneLoginRoute());
          break;
        case 5:
          _router.navigate(const SomiPhoneLoginRoute());
          break;
        case 6:
          _router.navigate(const SomiPhoneLoginRoute());
          break;
        case 7:
          _router.navigate(const SomiPhoneLoginRoute());
          break;
      }
    });
    on<FetchOrgAnnouncment>((event, emit) async {
      emit(state.copyWith(orgAnnouncloading: true, error: null));
      await Future.delayed(const Duration(seconds: 3));
      // If refreshing, clear items and caches
      // if (refresh) {
      //   await userService.clearContinueLearningCache();
      //   await userService.clearRecentlyViewedCache();
      //   await userService.clearDashboardTrendingDegreed();
      //   await userService.clearTodayFeedCache();
      //   //await countsRepo.refresh(silentFail: true);
      //   emit(
      //     state.copyWith(
      //         discoverItems: const DiscoverResponse(),
      //         recentlyViewedItems: const DiscoverResponse(),
      //         trendingItems: const DiscoverResponse(),
      //         todayFeedItems: []),
      //   );
      // }
      try {
        final results = await userService.getOrgAnnouncements();
        emit(state.copyWith(orgAnnouncement: results));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(orgAnnouncloading: false));
    });
    on<FetchTopCarSellers>((event, emit) async {
      emit(state.copyWith(topSellerloading: true, error: null));
      await Future.delayed(const Duration(seconds: 5));
      try {
        final results = await userService.getTopCarSellers();
        emit(state.copyWith(topCarSeller: results));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(topSellerloading: false));
    });
    on<FetchAvailableDoctors>((event, emit) async {
      emit(state.copyWith(availableDrloading: true, error: null));
      await Future.delayed(const Duration(seconds: 8));
      try {
        final results = await userService.getAvailableDoctors();
        emit(state.copyWith(availableDoctors: results));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(availableDrloading: false));
    });
    on<FetchTopOffers>((event, emit) async {
      emit(state.copyWith(topOffersloading: true, error: null));
      await Future.delayed(const Duration(seconds: 10));
      try {
        final results = await userService.getTopOffers();
        emit(state.copyWith(topOffers: results));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(topOffersloading: false));
    });
  }
}
