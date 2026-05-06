import 'package:freezed_annotation/freezed_annotation.dart';
part 'notification.freezed.dart';
part 'notification.g.dart';

@freezed
class Notification with _$Notification {
  factory Notification({
    @Default('') String? title,
    @Default('') String? content,
  }) = _Address;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
}
