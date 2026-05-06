import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/services/user_service.dart';
import 'saved_addresses_event.dart';
import 'saved_addresses_state.dart';

class SavedAddressesBloc
    extends Bloc<SavedAddressesEvent, SavedAddressesState> {
  final UserService userService;
  SavedAddressesBloc({required this.userService})
      : super(const SavedAddressesState()) {
    on<FetchSavedAddresses>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      await Future.delayed(const Duration(seconds: 3));
      try {
        final savedAddresses = await userService.getUserSavedAddresses();
        // results
        emit(state.copyWith(savedAddresses: savedAddresses));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    on<SaveUserAddressFromMap>((event, emit) async {
      emit(state.copyWith(userAddress: event.address, addAddressStep: 1));
    });
    on<SaveUserAddress>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      await Future.delayed(const Duration(seconds: 3));
      try {
        final result =
            await userService.saveUserAddress(address: event.address);
        // results
        // emit(state.copyWith(savedAddresses: savedAddresses));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    on<NavigateToChooseLocationFromMapStep>((event, emit) async {
      emit(state.copyWith(addAddressStep: 0));
    });
    on<ResetState>((event, emit) async {
      emit(SavedAddressesState.initial());
    });
  }
}
