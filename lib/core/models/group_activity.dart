import 'package:somi/core/models/comments.dart';
import 'package:somi/core/models/resource.dart';
import 'package:somi/core/models/statistics.dart';
import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group_activity.freezed.dart';
part 'group_activity.g.dart';

@freezed
class GroupActivity with _$GroupActivity {
  const GroupActivity._();

  const factory GroupActivity({
    @JsonKey(name: 'ActivityId') required int activityId,
    @JsonKey(name: 'Reference') Resource? reference,
    @JsonKey(name: 'Action') required String action,
    @JsonKey(name: 'Type') required String type,
    @JsonKey(name: 'Details') required Details details,
    @JsonKey(name: 'DateCreated') required String dateCreated,
    @JsonKey(name: 'FormattedDate') required String formattedDate,
    @JsonKey(name: 'ReasonForDisplay') String? reasonForDisplay,
    @JsonKey(name: 'User') User? user,
    Comments? comments,
    Statistics? statistics,
  }) = _GroupActivity;

  factory GroupActivity.fromJson(Map<String, dynamic> json) =>
      _$GroupActivityFromJson(json);
}

@freezed
class Details with _$Details {
  const Details._();

  const factory Details({
    @JsonKey(name: 'Comment') String? comment,
    @JsonKey(name: 'GroupId') int? groupId,
    @JsonKey(name: 'Title') String? title,
  }) = _Details;

  factory Details.fromJson(Map<String, dynamic> json) =>
      _$DetailsFromJson(json);
}
