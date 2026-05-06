import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result.freezed.dart';

part 'search_result.g.dart';

@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();

  const factory SearchResult({
    @JsonKey(name: 'ReferenceId') int? resourceId,
    @JsonKey(name: 'ReferenceType') String? resourceType,
    @JsonKey(name: 'Reference') SearchReference? reference,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
class SearchReference with _$SearchReference {
  const SearchReference._();

  const factory SearchReference({
    @JsonKey(name: 'InputType') String? inputType,
    @JsonKey(name: 'InputId') int? inputId,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Url') String? url,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'ProviderName') String? providerName,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'InternalUrl') String? internalUrl,
  }) = _SearchReference;

  factory SearchReference.fromJson(Map<String, dynamic> json) =>
      _$SearchReferenceFromJson(json);
}
