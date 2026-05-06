import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'visa_app_state.freezed.dart';

@freezed
class VisaAppState with _$VisaAppState {
  const factory VisaAppState({
    @Default(0) int step,
    @Default(false) bool loading,
    @Default(false) bool isEligible,
    @Default(false) bool doumentsUploaded,
    @Default(null) File? passport,
    @Default(null) File? nID,
    @Default(null) File? photograph,
    @Default(null) File? previousVisa,
    @Default('') String country,
    @Default('') String duration,
    @Default('') String visaArriveDate,
    @Default('') String visaExitDate,
    @Default('') String visaType,
    @Default(null) Object? error,
  }) = _VisaAppState;

  factory VisaAppState.initial() => const VisaAppState();

  factory VisaAppState.loading() => const VisaAppState(loading: true);
  factory VisaAppState.completed() => const VisaAppState(loading: false);

  factory VisaAppState.error(Object error) => VisaAppState(error: error);
}
