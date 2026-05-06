import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/models/location.dart';
import '../../../../../core/utils/file_uploader.dart';
import 'car_event.dart';
import 'car_state.dart';

List<List<String>> Delivery_Options = [
  ['Self Pickup', 'AED 0', '0'],
  ['Door-to-Door', 'AED 80', '80']
];
List<List<String>> Driver_Options = [
  ['Without Driver', 'AED 0'],
  ['Include Driver', 'AED 80/Day']
];

class CarBloc extends Bloc<CarEvent, CarState> {
  CarBloc()
      : super(CarState(
            firstDate: DateTime.now(),
            driverOption: 0,
            deliveryOption: 0,
            car: cars.first,
            deliveryAddress: Location(),
            returnAddress: Location(),
            rangeValues: const RangeValues(2000, 6000),
            endDate: DateTime.now().add(const Duration(days: 7)))) {
    on<SetDateDurationEvent>((event, emit) {
      emit(state.copyWith(
        firstDate: event.firstDate,
        endDate: event.lastDate,
      ));
    });
    on<SetFirstTimeEvent>((event, emit) {
      emit(state.copyWith(
        firstTime: event.firstTime,
      ));
    });
    on<SetLastTimeEvent>((event, emit) {
      emit(state.copyWith(
        endTime: event.lastTime,
      ));
    });
    on<OpenUpdateEvent>((event, emit) {
      emit(state.copyWith(
        openUpdate: event.value,
      ));
    });
    on<SetRangValuesEvent>((event, emit) {
      emit(state.copyWith(
        rangeValues: event.rangeValues,
      ));
    });

    on<SetDriverOptionEvent>((event, emit) {
      emit(state.copyWith(driverOption: event.index));
    });

    on<SetDeliveryOptionEvent>((event, emit) {
      emit(state.copyWith(deliveryOption: event.index));
    });

    on<SetDeliveryAddressEvent>((event, emit) async {
      emit(state.copyWith(deliveryAddress: event.index));
    });

    on<SetReturnAddressEvent>((event, emit) async {
      emit(state.copyWith(returnAddress: event.index));
    });

    on<UploadFileEvent>((event, emit) async {
      final file = await FileUploader.pickAndUploadFile(event.context);
      switch (event.index) {
        case 0:
          emit(state.copyWith(drivingLicence: file));
          break;
        case 1:
          emit(state.copyWith(nID: file));
          break;
      }

      if (state.drivingLicence != null && state.nID != null) {
        emit(state.copyWith(documentsUploaded: true));
      }
    });

    on<RemoveFileEvent>((event, emit) async {
      switch (event.index) {
        case 0:
          emit(state.copyWith(drivingLicence: null, documentsUploaded: false));
          break;
        case 1:
          emit(state.copyWith(nID: null, documentsUploaded: false));
          break;
      }
    });
  }
}
