import 'package:freezed_annotation/freezed_annotation.dart';

part 'degreed_notification.freezed.dart';
part 'degreed_notification.g.dart';

@freezed
class DegreedNotification with _$DegreedNotification {
  const factory DegreedNotification({
    @JsonKey(name: 'NotificationId') int? notificationId,
    @JsonKey(name: 'NotificationText') String? notificationText,
    @JsonKey(name: 'NotificationType') String? notificationType,
    @JsonKey(name: 'CreatedDate') String? createdDate,
    @JsonKey(name: 'ReadFlag') bool? readFlag,
    @JsonKey(name: 'Formatted Date') String? formattedDate,
    @JsonKey(name: 'Parameters') NotificationParameters? parameters,
  }) = _DegreedNotification;

  factory DegreedNotification.fromJson(Map<String, dynamic> json) =>
      _$DegreedNotificationFromJson(json);
}

@freezed
class NotificationParameters with _$NotificationParameters {
  const factory NotificationParameters({
    @JsonKey(name: 'PersonCount') int? personCount,
    @JsonKey(name: 'SourceUrl') String? sourceUrl,
    @JsonKey(name: 'CommentId') int? commentId,
    @JsonKey(name: 'Comment') String? comment,
    @JsonKey(name: 'InputUrl') String? inputUrl,
    @JsonKey(name: 'InputId') int? inputId,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'InputType') String? inputType,
    @JsonKey(name: 'ParentCommentText') String? parentCommentText,
    @JsonKey(name: 'DueDate') String? dueDate,
    @JsonKey(name: 'GroupName') String? groupName,
    @JsonKey(name: 'GroupId') int? groupId,
    @JsonKey(name: 'AlreadyCompleted') bool? alreadyCompleted,
    @JsonKey(name: 'Person') NotificationPerson? person,
    @JsonKey(name: 'TargetId') int? targetId,
    @JsonKey(name: 'TargetTitle') String? targetTitle,
    @JsonKey(name: 'TargetType') String? targetType,
    @JsonKey(name: 'TargetAuthor') String? targetAuthor,
    @JsonKey(name: 'ConnectionName') String? connectionName,
    @JsonKey(name: 'ConnectionPicture') String? connectionPicture,
    @JsonKey(name: 'ProviderCode') String? providerCode,
    @JsonKey(name: 'VanityUrl') String? vanityUrl,
    @JsonKey(name: 'PrivacyId') int? privacyId,
    @JsonKey(name: 'OpportunityId') int? opportunityId,
    @JsonKey(name: 'OpportunityTitle') String? opportunityTitle,
  }) = _NotificationParameters;

  factory NotificationParameters.fromJson(Map<String, dynamic> json) =>
      _$NotificationParametersFromJson(json);
}

@freezed
class NotificationPerson with _$NotificationPerson {
  const factory NotificationPerson({
    @JsonKey(name: 'UserFullName') String? fullName,
    @JsonKey(name: 'UserProfileUrl') String? profileUrl,
    @JsonKey(name: 'UserPictureUrl') String? pictureUrl,
    @JsonKey(name: 'UserProfileId') String? userProfileId,
    @JsonKey(name: 'UserProfileKey') int? userProfileKey,
  }) = _NotificationPerson;

  factory NotificationPerson.fromJson(Map<String, dynamic> json) =>
      _$NotificationPersonFromJson(json);
}
