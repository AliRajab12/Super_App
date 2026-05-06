import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const ForgotPasswordState._();

  const factory ForgotPasswordState({
    @Default('') String username,
    @Default(false) bool loading,
    @Default(false) bool submitted,
    @Default(false) bool showError,
    @Default('') String errorText,
  }) = _ForgotPasswordState;

  bool get disableContinue => loading || username.isEmpty;
}
