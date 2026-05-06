import 'package:freezed_annotation/freezed_annotation.dart';

part 'high_level_counts.freezed.dart';
part 'high_level_counts.g.dart';

@freezed
class HighLevelCounts with _$HighLevelCounts {
  const HighLevelCounts._();

  const factory HighLevelCounts({
    @JsonKey(name: 'NotificationCount') @Default(0) int notificationCount,
    @JsonKey(name: 'RequiredLearningItemCount')
    @Default(0)
    int requiredLearningItemCount,
    @JsonKey(name: 'RecommendedLearningTotal')
    @Default(0)
    int recommendedLearningTotal,
    @JsonKey(name: 'RecommendedLearningDueSoon')
    @Default(0)
    int recommendedLearningDueSoon,
    @JsonKey(name: 'RecommendedLearningOverdue')
    @Default(0)
    int recommendedLearningOverdue,
  }) = _HighLevelCounts;

  factory HighLevelCounts.fromJson(Map<String, dynamic> json) =>
      _$HighLevelCountsFromJson(json);

  bool get hasRecommended =>
      recommendedLearningTotal +
          recommendedLearningDueSoon +
          recommendedLearningOverdue >
      0;
}
