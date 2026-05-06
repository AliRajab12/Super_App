import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_a_problem_state.freezed.dart';

@freezed
class ReportAProblemState with _$ReportAProblemState {
  const factory ReportAProblemState({
    @Default('') String description,
    @Default(false) bool submitting,
    @Default(null) Object? error,
    @Default(false) bool success,
  }) = _ReportAProblemState;
}
