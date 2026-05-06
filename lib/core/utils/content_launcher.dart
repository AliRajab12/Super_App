import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/services/content_access_token_service.dart';
import 'package:somi/core/utils/url_launcher.dart';

class ContentLauncher {
  final AuthDataRepo _authRepo;
  final UrlLauncher _urlLauncher;
  final ContentAccessTokenService _contentAccessTokenService;

  ContentLauncher(
      this._authRepo, this._urlLauncher, this._contentAccessTokenService);

  Future<String?> _getToken() async {
    final contentAccessToken =
        await _contentAccessTokenService.getContentAccessToken();
    if (contentAccessToken != null) {
      return Uri.encodeQueryComponent(contentAccessToken.accessToken);
    }
    return null;
  }

  // Use this when launching any resources from the Degreed API
  Future<bool> launchResource(String resourceType, int resourceId) async {
    final token = await _getToken();

    if (token != null) {
      final degreedUrl = Uri.parse(
          '${_authRepo.hostUrl}/mobile/redirect/$resourceType/$resourceId?token=$token');
      await _urlLauncher.launchUri(degreedUrl);
      return true;
    }

    return false;
  }

  Future<bool> launchUrl(String url) async {
    final token = await _getToken();

    if (token != null) {
      final encodedUrl = Uri.encodeQueryComponent(url);
      final degreedUrl = Uri.parse(
          '${_authRepo.hostUrl}/mobile/redirect?token=$token&redirectUri=$encodedUrl');
      await _urlLauncher.launchUri(degreedUrl);
      return true;
    }

    return false;
  }
}
