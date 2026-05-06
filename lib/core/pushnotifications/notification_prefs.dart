import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationPrefs {
  static const _boxName = 'notificationPrefsBox';

  static const _keyNotificationSet = 'notificationTokenSet';
  static const _keyTokenAdded = 'notificationTokenAdded';

  late Box _box;

  Future<void> init() async {
    var key = await locator<SecurityProvider>().getStorageEncryptionKey();
    _box = await Hive.openBox(_boxName, encryptionCipher: HiveAesCipher(key));
  }

  bool get isNotificationSet =>
      _box.get(_keyNotificationSet, defaultValue: false);

  Future<void> setNotification(bool notificationSet) async {
    await _box.put(_keyNotificationSet, notificationSet);
  }

  bool get isNotificationTokenAdded =>
      _box.get(_keyTokenAdded, defaultValue: false);

  Future<void> setNotificationTokenAdded(bool notificationAdded) async {
    await _box.put(_keyTokenAdded, notificationAdded);
  }

  Future<void> clear() async {
    _box.clear();
  }
}
