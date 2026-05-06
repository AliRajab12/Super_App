import 'dart:convert';

import 'package:somi/core/models/initial_data.dart';
import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/models/user.dart';
import 'package:somi/core/models/user_permissions.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class UserRepo {
  static const _boxName = 'userRepoBox';
  static const _initialDataKey = 'initialData';
  InitialData? _data;

  late Box _box;

  Future<void> init() async {
    var key = await locator<SecurityProvider>().getStorageEncryptionKey();
    _box = await Hive.openBox(_boxName, encryptionCipher: HiveAesCipher(key));
    String? initialDataJson = _box.get(_initialDataKey);
    if (initialDataJson != null) {
      _data = InitialData.fromJson(json.decode(initialDataJson));
      userListenable.value = _data?.userProfile;
    }
  }

  Future<InitialData> refreshInitialData() async {
    _data = await locator<UserService>().getInitialData();
    await _box.put(_initialDataKey, json.encode(_data!));
    userListenable.value = _data?.userProfile;
    return _data!;
  }

  ValueNotifier<User?> userListenable = ValueNotifier(null);

  User? get user => _data?.userProfile;

  UserPermissions? get userPermissions => _data?.userPermissions;

  OrgSettings? get orgSettings => _data?.orgSettings;

  bool get hasData => _data != null;

  static const String _skipOnboardingKey = 'skipOnboarding';

  bool get skipOnboarding => _box.get(_skipOnboardingKey, defaultValue: false);

  set skipOnboarding(bool value) => _box.put(_skipOnboardingKey, value);

  bool getBool(String key, {bool? defaultValue}) =>
      _box.get(key, defaultValue: defaultValue);

  Future<void> setBool(String key, bool value) => _box.put(key, value);

  Future<void> clear() async {
    _data = null;
    _box.clear();
  }
}
