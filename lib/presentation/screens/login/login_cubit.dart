import 'package:somi/core/main_router.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/core/services/auth/sso/sso_authenticator.dart';
import 'package:somi/presentation/screens/login/login_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginState> {
//  final AppLocalizations intl;
  final AuthService _authService;
  final AuthDataRepo _authDataRepo;
  final MainRouter _router;
  final SsoAuthenticator _ssoAuthenticator;

  LoginCubit(
    //  this.intl,
    this._authService,
    this._authDataRepo,
    this._router,
    this._ssoAuthenticator,
  ) : super(const LoginState());

  String? remoteHostUrl;

  void setLogoutReason(String reason) {
    emitError(reason);
  }

  void updateUsername(String username) {
    if (username == state.username) return;
    emit(state.copyWith(
        username: username, showPasswordField: false, showError: false));
  }

  void updatePassword(String password) {
    if (password == state.password) return;
    emit(state.copyWith(password: password, showError: false));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(visiblePassword: !state.visiblePassword));
  }

  Future<void> checkEmail() async {
    emit(state.copyWith(loading: true));

    try {
      // if this is a non-email login, bypass the email checks and allow them to enter a password
      if (!state.username.contains('@')) {
        emit(state.copyWith(showPasswordField: true));
        emit(state.copyWith(loading: false));
        return;
      }

      var serviceHostResponse =
          await _authService.getServiceHost(state.username.split('@')[1]);
      remoteHostUrl = serviceHostResponse.ServiceHost;

      var response =
          await _authService.loginSettings(state.username, remoteHostUrl);

      if (response.RestrictMobile == true) {
        //    emitError(intl.orgNotAllowMobileApp);
        emit(state.copyWith(loading: false));
        return;
      }

      // SSO login
      if (response.Id != null &&
          response.Name != null &&
          response.Protected != null) {
        final ssoAuthResult = await _ssoAuthenticator.getAuthCode(
            response.Protected!, remoteHostUrl);
        bool shouldReturn = await ssoAuthResult.when(
          success: (authCode) async {
            var response = await _authService.ssoLogin(authCode, remoteHostUrl);
            await _authDataRepo.storeLoginTokens(response,
                hostUrl: remoteHostUrl);
            proceedToLaunchScreen();
            return true;
          },
          canceled: () => false,
          error: () async {
            //       emitError(intl.communicationError);
            return false;
          },
        );
        if (shouldReturn) return;
      } else {
        // Password login
        emit(state.copyWith(showPasswordField: true));
      }
    } on DioException catch (e) {
      int? statusCode = e.response?.statusCode;
      if (statusCode == 400) {
        emit(state.copyWith(showPasswordField: true));
      } else {
        //   emitError(intl.communicationError);
      }
    } catch (e) {
      // emitError(intl.communicationError);
    }
    emit(state.copyWith(loading: false));
  }

  void emitError(String? message) {
    if (message != null) {
      emit(state.copyWith(showError: true, errorText: message));
    } else {
      emit(state.copyWith(showError: false, errorText: ''));
    }
  }

  Future<void> nativeLogin() async {
    emit(state.copyWith(loading: true));
    try {
      var response = await _authService.performLogin(
          state.username, state.password, remoteHostUrl);
      await _authDataRepo.storeLoginTokens(response, hostUrl: remoteHostUrl);
      proceedToLaunchScreen();
    } on DioException catch (e) {
      final error = e.response?.data?['error'];
      switch (error) {
        case 'user_blocked_by_org':
          //  emitError(intl.userBlocked);
          break;
        case 'user_mobile_blocked':
          //emitError(intl.orgNotAllowMobileApp);
          break;
        case 'invalid_credentials':
          //emitError(intl.badUsernamePassword);
          break;
        case 'password_expired':
          // emitError(intl.passwordExpired);
          break;
        case null:
          //emitError(intl.connectionProblemsString);
          break;
        default:
          //emitError(intl.communicationError);
          break;
      }
    } catch (e) {
      //emitError(intl.communicationError);
    }
    emit(state.copyWith(loading: false));
  }

  void proceedToLaunchScreen() =>
      _router.replaceAll([const LaunchScreenRoute()]);

  void proceedToSomiHomeScreen() =>
      _router.replaceAll([const HomeScreenRoute()]);

  void proceedToSomiPhoneLogin() =>
      _router.navigate(const SomiPhoneLoginRoute());

  void proceedToSomiPhoneVerify({required String phoneNumber}) =>
      _router.navigate(SomiPhoneVerifyRoute(phoneNumber: phoneNumber));

  @override
  Future<void> close() {
    emit(state.copyWith(username: '', password: ''));
    return super.close();
  }
}
