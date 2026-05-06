import 'package:freezed_annotation/freezed_annotation.dart';

part 'content_access_token.freezed.dart';
part 'content_access_token.g.dart';

@freezed
class ContentAccessToken with _$ContentAccessToken {
  const factory ContentAccessToken({
    @JsonKey(name: 'AccessToken') required String accessToken,
    @JsonKey(name: 'Created') required String created,
    @JsonKey(name: 'ValidUntil') required String validUntil,
  }) = _ContentAccessToken;

  factory ContentAccessToken.fromJson(Map<String, dynamic> json) =>
      _$ContentAccessTokenFromJson(json);
}
