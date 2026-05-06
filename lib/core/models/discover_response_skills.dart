import 'package:somi/core/models/discover_response_suggestions.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_response_skills.freezed.dart';
part 'discover_response_skills.g.dart';

@freezed
class DiscoverResponseSkills with _$DiscoverResponseSkills {
  const factory DiscoverResponseSkills({
    @JsonKey(name: 'Items')
    @Default([])
    List<DiscoverResponseSuggestions> discoverItems,
  }) = _DiscoverResponseSkills;

  factory DiscoverResponseSkills.fromJson(Map<String, dynamic> json) =>
      _$DiscoverResponseSkillsFromJson(json);
}
