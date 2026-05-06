import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'statistics.freezed.dart';
part 'statistics.g.dart';

@freezed
class Statistics with _$Statistics {
  const factory Statistics({
    @JsonKey(name: 'InputType') String? inputType,
    @JsonKey(name: 'InputId') int? inputId,
    @JsonKey(name: 'TopUserProfileKey') int? topUserProfileKey,
    @JsonKey(name: 'TopRecommenderProfileKey') int? topRecommenderProfileKey,
    @JsonKey(name: 'UserCount') int? userCount,
    @JsonKey(name: 'TopUser') User? topUser,
  }) = _Statistics;

  factory Statistics.fromJson(Map<String, dynamic> json) =>
      _$StatisticsFromJson(json);
}
