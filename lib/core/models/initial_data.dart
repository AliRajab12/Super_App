// ignore_for_file: non_constant_identifier_names

import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/models/user_permissions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'initial_data.freezed.dart';
part 'initial_data.g.dart';

@freezed
class InitialData with _$InitialData {
  factory InitialData({
    @JsonKey(name: 'UserProfile') User? userProfile,
    @JsonKey(name: 'UserPermissions') UserPermissions? userPermissions,
    @JsonKey(name: 'OrgSettings') OrgSettings? orgSettings,
  }) = _InitialData;

  factory InitialData.fromJson(Map<String, dynamic> json) =>
      _$InitialDataFromJson(json);
}
