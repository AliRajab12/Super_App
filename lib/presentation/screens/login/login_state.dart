import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const LoginState._();

  const factory LoginState({
    @Default('') String username,
    @Default('') String password,
    @Default(false) bool loading,
    @Default(false) bool showPasswordField,
    @Default(false) bool visiblePassword,
    @Default(false) bool showError,
    @Default('') String errorText,
  }) = _LoginState;

  bool get canContinue =>
      !loading &&
      username.isNotEmpty &&
      (!showPasswordField || password.isNotEmpty);
}
