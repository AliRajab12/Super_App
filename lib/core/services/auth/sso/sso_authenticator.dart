import 'package:somi/core/environment.dart';
import 'package:somi/core/services/auth/sso/sso_auth_result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:platform/platform.dart';

class SsoAuthenticator {
  SsoAuthenticator(this._platform, this._env, this._externalSso);

  final Platform _platform;
  final AppEnvironment _env;
  final ExternalSsoAuthenticator _externalSso;

  static Uri buildSsoUri(
      String baseUrl, String protected, String platform, String clientId) {
    final encodedEmail = Uri.encodeQueryComponent(protected);
    final redirectUri = Uri.encodeQueryComponent(
        '$baseUrl/oauth/access?type=application&platform=$platform');
    final returnUri = Uri.encodeQueryComponent(
      '/oauth/authorize?response_type=code&client_id=$clientId&scope=mobile&redirect_uri=$redirectUri',
    );
    var authURL =
        '$baseUrl/account/mobilelogin/?scope=mobile&ee=$encodedEmail&ReturnUrl=$returnUri';
    return Uri.parse(authURL);
  }

  Future<SsoAuthResult> getAuthCode(String protected, [String? host]) async {
    String platformName = _platform.isIOS ? 'iOS' : 'Android';
    final ssoUri = buildSsoUri(
        host ?? _env.somiApiUrl, protected, platformName, '_env.clientId');
    try {
      final result = await _externalSso.authenticate(ssoUri.toString());
      final authCode = Uri.parse(result).queryParameters['authorization_code'];
      return SsoAuthResult.success(authCode!);
    } on PlatformException catch (e) {
      if (e.code == 'CANCELED') return const SsoAuthResult.canceled();
      return const SsoAuthResult.error();
    } catch (e) {
      return const SsoAuthResult.error();
    }
  }
}

/// A wrapper providing instance access to the static method [FlutterWebAuth.authenticate],
/// allowing us to mock the call in tests.
class ExternalSsoAuthenticator {
  Future<String> authenticate(String url) {
    return FlutterWebAuth.authenticate(
      url: url,
      callbackUrlScheme: 'degreed',
      preferEphemeral: false,
    );
  }
}
