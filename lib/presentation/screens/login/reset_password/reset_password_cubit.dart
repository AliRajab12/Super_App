import 'dart:convert';

import 'package:somi/core/main_router.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/presentation/screens/login/reset_password/reset_password_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit(
    this._authService,
    this._authDataRepo,
    this._router,
  )   : _resetLink = _router.currentPath,
        super(const ResetPasswordState());

  final AuthService _authService;
  final AuthDataRepo _authDataRepo;
  final MainRouter _router;

  final String _resetLink;

  @override
  Future<void> close() {
    emit(state.copyWith(password: ''));
    return super.close();
  }

  static String parseEmail(String resetLink) {
    Uri uri = Uri.parse(resetLink);
    if (uri.pathSegments.length < 3) return '';
    return utf8.decode(base64Decode(uri.pathSegments[1]));
  }

  static String parseCode(String resetLink) {
    Uri uri = Uri.parse(resetLink);
    if (uri.pathSegments.length < 3) return '';
    return uri.pathSegments.sublist(2).join('/');
  }

  void resetPassword() async {
    emit(state.copyWith(
        isResetting: true, showError: false, errorMessage: null));
    String email = parseEmail(_resetLink);
    String code = parseCode(_resetLink);

    try {
      await _authService.resetPassword(email, state.password, code);
      var response = await _authService.performLogin(email, state.password);
      await _authDataRepo.storeLoginTokens(response);
      _router.replaceAll([const LaunchScreenRoute()]);
    } on DioException catch (e) {
      final message = e.response?.data?['Message'];
      emit(state.copyWith(showError: true, errorMessage: message));
    } catch (e) {
      emit(state.copyWith(showError: true));
    }
    emit(state.copyWith(isResetting: false));
  }

  void updatePassword(String newPassword) async {
    if (newPassword != state.password) {
      emit(state.copyWith(
          password: newPassword, showError: false, errorMessage: null));
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(showPassword: !state.showPassword));
  }
}
