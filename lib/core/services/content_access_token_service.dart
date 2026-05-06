import 'dart:developer';

import 'package:somi/core/models/content_access_token.dart';
import 'package:somi/core/network/network_config.dart';

class ContentAccessTokenService {
  static const Duration _contentAccessTokenTimeoutWindowSeconds =
      Duration(seconds: 120);

  final NetworkProvider _network;

  ContentAccessTokenService(this._network);

  // Named constructor for testing
  ContentAccessTokenService.forTesting(this._network, this._contentAccessToken);

  ContentAccessToken? _contentAccessToken;

  Future<ContentAccessToken?> getContentAccessToken() async {
    Future<ContentAccessToken?> getNew() async {
      try {
        final response = await _network
            .auth(forceRefresh: true)
            .post('/api/mobile/account/contentaccesstoken');

        _contentAccessToken = ContentAccessToken.fromJson(response.data);
        return _contentAccessToken;
      } catch (e) {
        log('Unable to acquire content access token, exception: ${e.toString()}');
      }
      return null;
    }

    final currentGmt = DateTime.now();
    final currentAccessToken = _contentAccessToken;

    if (currentAccessToken != null) {
      final expiry = DateTime.parse(currentAccessToken.validUntil)
          .subtract(_contentAccessTokenTimeoutWindowSeconds);
      if (currentGmt.isBefore(expiry)) {
        return currentAccessToken;
      }
    }

    return await getNew();
  }
}
