import 'package:somi/core/models/input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_response.freezed.dart';
part 'discover_response.g.dart';

@freezed
class DiscoverResponse with _$DiscoverResponse {
  const factory DiscoverResponse({
    @JsonKey(name: 'Items') @Default([]) List<Input> discoverItems,
  }) = _DiscoverResponse;

  factory DiscoverResponse.fromJson(Map<String, dynamic> json) =>
      _$DiscoverResponseFromJson(json);
}
