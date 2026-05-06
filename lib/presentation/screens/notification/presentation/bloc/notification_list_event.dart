import 'package:equatable/equatable.dart';

abstract class NotificationListEvent extends Equatable {
  const NotificationListEvent();
}

class FetchNotificationList extends NotificationListEvent {
  const FetchNotificationList();
  @override
  List<Object?> get props => [];
}
