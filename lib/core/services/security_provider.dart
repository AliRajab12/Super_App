import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class SecurityProvider {
  static const secureStorage = FlutterSecureStorage();

  static const storageKeyName = 'storageKey';

  Future<Uint8List> getStorageEncryptionKey() async {
    String? encodedKey = await secureStorage.read(key: storageKeyName);
    if (encodedKey == null) {
      final key = Hive.generateSecureKey();
      await secureStorage.write(
        key: storageKeyName,
        value: base64UrlEncode(key),
      );
      encodedKey = await secureStorage.read(key: storageKeyName);
    }
    return base64Url.decode(encodedKey!);
  }

  Future<void> clear() async {
    await secureStorage.deleteAll();
  }
}
