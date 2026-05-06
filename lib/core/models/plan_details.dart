import 'package:somi/core/models/sections.dart';
import 'package:somi/core/models/target.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'plan_details.freezed.dart';

part 'plan_details.g.dart';

@freezed
class PlanDetails with _$PlanDetails {
  const factory PlanDetails({
    @JsonKey(name: 'Target') Target? target,
    @JsonKey(name: 'Sections') List<Sections>? sections,
  }) = _PlanDetails;

  factory PlanDetails.fromJson(Map<String, dynamic> json) =>
      _$PlanDetailsFromJson(json);
}
