import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const ResetPasswordState._();

  const factory ResetPasswordState({
    @Default('') String password,
    @Default(false) bool isResetting,
    @Default(false) bool showPassword,
    @Default(false) bool showError,
    @Default(null) String? errorMessage,
  }) = _ResetPasswordState;

  bool get isContinueEnabled => password.isNotEmpty && !isResetting;
}
