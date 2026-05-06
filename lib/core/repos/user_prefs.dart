import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserPrefs {
  static const _boxName = 'userPrefsBox';
  static const _keySaveItemId = 'saveItemId';

  late Box _box;

  Future<void> init() async {
    var key = await locator<SecurityProvider>().getStorageEncryptionKey();
    _box = await Hive.openBox(_boxName, encryptionCipher: HiveAesCipher(key));
  }

  bool getBool(String key, {bool? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  Future<void> setBool(String key, bool value) => _box.put(key, value);

  Future<void> saveQueueID(String queueId) async {
    await _box.put(_keySaveItemId, queueId);
  }

  String? get queueId => _box.get(_keySaveItemId);

  Future<void> clear() async {
    _box.clear();
  }
}
