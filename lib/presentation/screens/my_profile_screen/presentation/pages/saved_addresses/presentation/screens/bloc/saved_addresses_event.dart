import 'package:equatable/equatable.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/data/models/address.dart';

abstract class SavedAddressesEvent extends Equatable {
  const SavedAddressesEvent();
}

class FetchSavedAddresses extends SavedAddressesEvent {
  const FetchSavedAddresses();
  @override
  List<Object?> get props => [];
}

class SaveUserAddressFromMap extends SavedAddressesEvent {
  final Address address;
  const SaveUserAddressFromMap({required this.address});
  @override
  List<Object?> get props => [address];
}

class SaveUserAddress extends SavedAddressesEvent {
  final Address address;
  const SaveUserAddress({required this.address});
  @override
  List<Object?> get props => [address];
}

class NavigateToChooseLocationFromMapStep extends SavedAddressesEvent {
  const NavigateToChooseLocationFromMapStep();
  @override
  List<Object?> get props => [];
}

class ResetState extends SavedAddressesEvent {
  const ResetState();
  @override
  List<Object?> get props => [];
}
