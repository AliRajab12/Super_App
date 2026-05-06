import 'dart:io';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/models/location.dart';
part 'car_state.freezed.dart';

@freezed
class CarState with _$CarState {
  const factory CarState({
    @Default(false) bool loading,
    @Default('14:00') String? firstTime,
    @Default('16:00') String? endTime,
    @Default(null) Car? car,
    @Default(false) bool? openUpdate,
    @Default(null) File? drivingLicence,
    @Default(null) File? nID,
    @Default(false) bool documentsUploaded,
    @Default(0) int? deliveryOption,
    @Default(0) int? driverOption,
    @Default(null) Location? deliveryAddress,
    @Default(null) Location? returnAddress,
    DateTime? firstDate,
    DateTime? endDate,
    RangeValues? rangeValues,
    @Default(null) Object? error,
  }) = _CarState;
}
