import 'package:equatable/equatable.dart';

abstract class HomeScreenEvent extends Equatable {
  const HomeScreenEvent();
}

class NavigateToServiceScreen extends HomeScreenEvent {
  final int index;

  const NavigateToServiceScreen({required this.index});

  @override
  List<Object?> get props => [index];
}

class FetchOrgAnnouncment extends HomeScreenEvent {
  final bool refresh;
  const FetchOrgAnnouncment({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class FetchTopCarSellers extends HomeScreenEvent {
  final bool refresh;
  const FetchTopCarSellers({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class FetchAvailableDoctors extends HomeScreenEvent {
  final bool refresh;
  const FetchAvailableDoctors({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}

class FetchTopOffers extends HomeScreenEvent {
  final bool refresh;
  const FetchTopOffers({this.refresh = false});

  @override
  List<Object?> get props => [refresh];
}
