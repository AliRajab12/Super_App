import 'dart:typed_data';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:encrypt/encrypt.dart';

import '../service_locator.dart';
import '../services/security_provider.dart';

class NetworkCacheCipher extends CacheCipher {
  static final iv = IV.fromLength(16);

  static Future<List<int>> encryptBytes(List<int> bytes) async {
    final storageEncryptionKey =
        await locator<SecurityProvider>().getStorageEncryptionKey();

    final key = Key(storageEncryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));
    return encrypter.encryptBytes(bytes, iv: iv).bytes;
  }

  static Future<List<int>> decryptBytes(List<int> bytes) async {
    final storageEncryptionKey =
        await locator<SecurityProvider>().getStorageEncryptionKey();

    final key = Key(storageEncryptionKey);
    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    return encrypter
        .decryptBytes(Encrypted(Uint8List.fromList(bytes)), iv: iv)
        .toList();
  }

  NetworkCacheCipher() : super(decrypt: decryptBytes, encrypt: encryptBytes);
}
