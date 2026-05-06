import 'dart:convert';

import 'package:somi/core/models/login_settings_response.dart';
import 'package:somi/core/models/login_response.dart';
import 'package:somi/core/models/service_host_response.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/service_locator.dart';
import 'package:dio/dio.dart';

class AuthService {
  Future<LoginSettingsResponse> loginSettings(String email,
      [String? host]) async {
    final response =
        await locator<NetworkProvider>().noAuth(hostUrl: host).post(
              '/api/degreed/mobileloginsettings',
              data: jsonEncode({
                'email': email,
                'scope': 'mobile',
              }),
            );
    return LoginSettingsResponse.fromJson(response.data);
  }

  Future<ServiceHostResponse> getServiceHost(String domain) async {
    final response = await locator<NetworkProvider>().noAuth().get(
      '/api/degreed/servicehost',
      queryParameters: {
        'domain': domain,
      },
    );
    return ServiceHostResponse.fromJson(response.data);
  }

  Future<void> invalidateToken() async {
    await locator<NetworkProvider>().auth().delete('/api/mobile/session');
  }

  Future<LoginResponse> performLogin(String username, String password,
      [String? host]) async {
    final response =
        await locator<NetworkProvider>().basicAuth(hostUrl: host).post(
              '/oauth/token',
              data: {
                'grant_type': 'password',
                'scope': 'mobile',
                'username': username,
                'password': password,
              },
              options: Options(contentType: Headers.formUrlEncodedContentType),
            );
    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse> ssoLogin(String authCode, [String? host]) async {
    final response =
        await locator<NetworkProvider>().basicAuth(hostUrl: host).post(
              '/oauth/token',
              data: {
                'code': authCode,
                'grant_type': 'authorization_code',
                'scope': 'mobile',
              },
              options: Options(contentType: Headers.formUrlEncodedContentType),
            );
    return LoginResponse.fromJson(response.data);
  }

  Future<LoginResponse?> refreshAccessToken(String refreshToken) async {
    final response = await locator<NetworkProvider>().basicAuth().post(
          '/oauth/token',
          data: {
            'grant_type': 'refresh_token',
            'refresh_token': refreshToken,
            'scope': 'mobile',
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
    return LoginResponse.fromJson(response.data);
  }

  Future<void> forgotPassword(String email) async {
    await locator<NetworkProvider>().noAuth().post(
          '/api/mobile/account/forgotpassword',
          data: jsonEncode({'email': email}),
        );
  }

  Future<void> resetPassword(String email, String password, String code) async {
    await locator<NetworkProvider>().basicAuth().post(
          '/api/mobile/account/resetpassword',
          data: {
            'email': email,
            'password': password,
            'code': code,
          },
          options: Options(contentType: Headers.formUrlEncodedContentType),
        );
  }
}
