import 'package:somi/core/models/input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_response_suggestions.freezed.dart';
part 'discover_response_suggestions.g.dart';

@freezed
class DiscoverResponseSuggestions with _$DiscoverResponseSuggestions {
  const factory DiscoverResponseSuggestions({
    @JsonKey(name: 'Suggestions') @Default([]) List<Input> discoverItems,
  }) = _DiscoverResponseSuggestions;

  factory DiscoverResponseSuggestions.fromJson(Map<String, dynamic> json) =>
      _$DiscoverResponseSuggestionsFromJson(json);
}
