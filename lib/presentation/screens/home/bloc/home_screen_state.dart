import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/models/doctor.dart';
import 'package:somi/core/models/offer.dart';
import 'package:somi/core/models/org_announcement.dart';
import 'package:somi/presentation/screens/somidashboard/data/car.dart';
part 'home_screen_state.freezed.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  const HomeScreenState._();
  const factory HomeScreenState({
    @Default(false) bool orgAnnouncloading,
    @Default(false) bool topSellerloading,
    @Default(false) bool availableDrloading,
    @Default(false) bool topOffersloading,
    @Default(null) Object? error,
    @JsonKey(name: 'OrgAnnouncement')
    @Default(null)
    OrgAnnouncement? orgAnnouncement,
    @Default([]) List<Car> topCarSeller,
    @Default([]) List<Doctor> availableDoctors,
    @Default([]) List<Offer> topOffers,
  }) = _HomeScreenState;

  factory HomeScreenState.initial() => const HomeScreenState();

  factory HomeScreenState.completed() => const HomeScreenState(
        orgAnnouncloading: false,
        topSellerloading: false,
        availableDrloading: false,
        topOffersloading: false,
      );

  factory HomeScreenState.error(Object error) => HomeScreenState(error: error);
}
