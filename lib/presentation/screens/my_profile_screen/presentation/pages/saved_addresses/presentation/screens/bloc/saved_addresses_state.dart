import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/data/models/address.dart';
part 'saved_addresses_state.freezed.dart';

@freezed
class SavedAddressesState with _$SavedAddressesState {
  const factory SavedAddressesState({
    @Default(false) bool loading,
    @Default([]) List<Address> savedAddresses,
    @Default(null) Address? userAddress,
    @Default(0) int addAddressStep,
    @Default(null) Object? error,
  }) = _SavedAddressesState;

  factory SavedAddressesState.initial() => const SavedAddressesState();

  factory SavedAddressesState.loading() =>
      const SavedAddressesState(loading: true);
  factory SavedAddressesState.completed() =>
      const SavedAddressesState(loading: false);

  factory SavedAddressesState.error(Object error) =>
      SavedAddressesState(error: error);
}
