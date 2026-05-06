import 'package:somi/core/models/input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'markcomplete_state.freezed.dart';

@freezed
class MarkCompleteState with _$MarkCompleteState {
  const factory MarkCompleteState({
    @Default(false) bool filterByCompleted,
    @Default(false) bool loading,
    @Default(0) int nextPageNumber,
    @Default(true) bool hasMorePages,
    @Default(null) Object? error,
    @Default(null) Object? toggleError,
    @Default('DefaultComplete') String toggleComplete,
    @Default('DefaultSaved') String toggleSaved,
    @Default(false) bool toggleLoading,
    @Default(false) bool toggleSaveLoading,
    @Default([]) List<Input> items,
  }) = _MarkCompleteState;
}
