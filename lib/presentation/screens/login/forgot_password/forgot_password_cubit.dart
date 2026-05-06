import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/presentation/screens/login/forgot_password/forgot_password_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final AuthService _authService;

  ForgotPasswordCubit(this._authService) : super(const ForgotPasswordState());

  void updateUsername(String name) {
    emit(state.copyWith(username: name, showError: false));
  }

  void submit() async {
    emit(state.copyWith(loading: true, showError: false));
    try {
      await _authService.forgotPassword(state.username);
      emit(state.copyWith(submitted: true));
    } catch (e) {
      emit(state.copyWith(showError: true));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
