import 'package:freezed_annotation/freezed_annotation.dart';

part 'push_preference.freezed.dart';
part 'push_preference.g.dart';

@freezed
class PushPreference with _$PushPreference {
  const factory PushPreference({
    @JsonKey(name: 'NotificationTypeId') required int notificationTypeId,
    @JsonKey(name: 'IsEnabled') required bool isEnabled,
  }) = _PushPreference;

  factory PushPreference.fromJson(Map<String, dynamic> json) =>
      _$PushPreferenceFromJson(json);
}
