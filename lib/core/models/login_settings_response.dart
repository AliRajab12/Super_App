// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_settings_response.freezed.dart';
part 'login_settings_response.g.dart';

@freezed
class LoginSettingsResponse with _$LoginSettingsResponse {
  factory LoginSettingsResponse({
    String? Id,
    String? Name,
    String? Protected,
    bool? Primary,
    bool? SsoOnly,
    bool? AllowPasswordReset,
    bool? RestrictMobile,
  }) = _LoginSettingsResponse;

  factory LoginSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginSettingsResponseFromJson(json);
}
