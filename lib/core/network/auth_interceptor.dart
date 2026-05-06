// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:somi/core/models/login_response.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:dio/dio.dart';

class AuthInterceptor extends QueuedInterceptorsWrapper {
  final String _retryAttemptHeader = 'mobile_refresh_attempted';

  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Only proceed if it was an authentication error
    if (err.response?.statusCode != 401) return handler.next(err);

    // Check if we have already attempted a refresh
    if (err.requestOptions.headers[_retryAttemptHeader] != null) {
      return handler.next(err);
    }

    // Check that we have existing auth
    final authData = locator<AuthDataRepo>();
    if (!authData.hasAuth) {
      return handler.next(err);
    }

    // Attempt refresh
    await performRefresh(authData, handler, err);
  }

  Future<void> performRefresh(AuthDataRepo authData,
      ErrorInterceptorHandler handler, DioException err) async {
    // Refresh the access token
    LoginResponse? refreshResponse = await locator<AuthService>()
        .refreshAccessToken(authData.refreshToken!)
        .catchError((e) => null);

    // Store new tokens
    if (refreshResponse != null) authData.storeLoginTokens(refreshResponse);

    // Log out if refresh failed
    if (refreshResponse == null) {
      handler.reject(err);
      locator<UserService>().performLogout(
        manual: false,
        // reason: locator<AppLocalizations>().logoutReasonSessionExpired,
      );
      return;
    }

    // Retry initial request
    await retryRequest(authData, handler, err);
  }

  Future<void> retryRequest(AuthDataRepo authData,
      ErrorInterceptorHandler handler, DioException err) async {
    // Update the header and make the request again
    RequestOptions requestOptions = err.requestOptions;
    requestOptions.headers['Authorization'] = 'Bearer ${authData.accessToken}';

    // Add retry attempt header to prevent infinite recursion
    requestOptions.headers[_retryAttemptHeader] = _retryAttemptHeader;

    try {
      final response = await _dio.fetch(requestOptions);
      if (response.statusCode != 401) {
        handler.resolve(response);
      } else {
        handler.next(err);
      }
    } on DioException catch (e) {
      handler.next(e);
    } catch (e) {
      handler.next(err);
    }
  }
}
