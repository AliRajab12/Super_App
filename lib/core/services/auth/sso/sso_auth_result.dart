import 'package:freezed_annotation/freezed_annotation.dart';

part 'sso_auth_result.freezed.dart';

@freezed
class SsoAuthResult with _$SsoAuthResult {
  const factory SsoAuthResult.success(String authCode) = SsoAuthSuccess;

  const factory SsoAuthResult.canceled() = SsoAuthCanceled;

  const factory SsoAuthResult.error() = SsoAuthError;
}
