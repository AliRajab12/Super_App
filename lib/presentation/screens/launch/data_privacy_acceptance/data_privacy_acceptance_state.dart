import 'package:freezed_annotation/freezed_annotation.dart';

part 'data_privacy_acceptance_state.freezed.dart';

@freezed
class DataPrivacyAcceptanceState with _$DataPrivacyAcceptanceState {
  const factory DataPrivacyAcceptanceState({
    @Default(false) bool hasReachedBottom,
    @Default(false) bool saving,
    Object? error,
  }) = _DataPrivacyAcceptanceState;
}
