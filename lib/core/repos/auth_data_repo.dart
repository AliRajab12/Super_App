import 'package:somi/core/init.dart';
import 'package:somi/core/models/login_response.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthDataRepo {
  static const _boxName = 'authDataBox';
  static const _keyAccessToken = 'accessToken';
  static const _keyRefreshToken = 'refreshToken';
  static const _keyTokenExpiration = 'tokenExpiration';
  static const _keyTokenAcquired = 'tokenAcquired';
  static const _keyHostUrl = 'hostUrl';
  static const _keyBlobBaseUrl = 'blobBaseUrl';
  static const _keyNotificationToken = 'firebaseNotificationToken';

  late Box _box;

  Future<void> init() async {
    var key = await locator<SecurityProvider>().getStorageEncryptionKey();
    _box = await Hive.openBox(_boxName, encryptionCipher: HiveAesCipher(key));
  }

  bool get hasAuth => accessToken?.isNotEmpty == true;

  String? get accessToken => _box.get(_keyAccessToken);

  String? get refreshToken => _box.get(_keyRefreshToken);

  String get notificationToken =>
      _box.get(_keyNotificationToken, defaultValue: '');

  int? get tokenExpiration => _box.get(_keyTokenExpiration);

  int? get tokenAcquired => _box.get(_keyTokenAcquired);

  String get hostUrl => _box.get(_keyHostUrl, defaultValue: Env.somiApiUrl);

  String get blobBaseUrl => _box.get(_keyBlobBaseUrl, defaultValue: '');

  Future<void> storeLoginTokens(LoginResponse login, {String? hostUrl}) async {
    if (login.accessToken == null || login.refreshToken == null) return;
    await _box.put(_keyAccessToken, login.accessToken!);
    await _box.put(_keyRefreshToken, login.refreshToken!);
    await _box.put(_keyTokenExpiration, login.expiresSeconds);
    await _box.put(
        _keyTokenAcquired, DateTime.now().millisecondsSinceEpoch ~/ 1000);
    if (hostUrl != null) await _box.put(_keyHostUrl, hostUrl);
  }

  Future<void> saveBlobBaseUrl(String blobBaseUrl) async {
    await _box.put(_keyBlobBaseUrl, blobBaseUrl);
  }

  Future<void> storeNotificationToken(String deviceToken) async {
    await _box.put(_keyNotificationToken, deviceToken);
  }

  Future<void> clear() async {
    await _box.clear();
  }
}
