import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:somi/presentation/screens/notification/data/models/notification.dart';
part 'notification_list_state.freezed.dart';

@freezed
class NotificationListState with _$NotificationListState {
  const factory NotificationListState({
    @Default(false) bool loading,
    @Default([]) List<Notification> notifications,
    @Default(null) Object? error,
  }) = _NotificationListState;

  factory NotificationListState.initial() => const NotificationListState();

  factory NotificationListState.loading() =>
      const NotificationListState(loading: true);
  factory NotificationListState.completed() =>
      const NotificationListState(loading: false);

  factory NotificationListState.error(Object error) =>
      NotificationListState(error: error);
}
