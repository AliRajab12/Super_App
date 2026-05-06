import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_response_skill_explore.freezed.dart';
part 'discover_response_skill_explore.g.dart';

@freezed
class DiscoverResponseSkillExplore with _$DiscoverResponseSkillExplore {
  const factory DiscoverResponseSkillExplore({
    @JsonKey(name: 'Items') List<DiscoverResponseSkillExploreItems?>? items,
  }) = _DiscoverResponseSkillExplore;

  factory DiscoverResponseSkillExplore.fromJson(Map<String, dynamic> json) =>
      _$DiscoverResponseSkillExploreFromJson(json);
}

@freezed
class DiscoverResponseSkillExploreItems
    with _$DiscoverResponseSkillExploreItems {
  const factory DiscoverResponseSkillExploreItems({
    @JsonKey(name: 'Context') DiscoverResponseSkillExploreItemsContext? context,
    @JsonKey(name: 'Suggestions')
    List<DiscoverResponseSkillExploreItemsSuggestions?>? suggestions,
  }) = _DiscoverResponseSkillExploreItems;

  factory DiscoverResponseSkillExploreItems.fromJson(
          Map<String, dynamic> json) =>
      _$DiscoverResponseSkillExploreItemsFromJson(json);
}

@freezed
class DiscoverResponseSkillExploreItemsContext
    with _$DiscoverResponseSkillExploreItemsContext {
  const factory DiscoverResponseSkillExploreItemsContext({
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Label') String? label,
  }) = _DiscoverResponseSkillExploreItemsContext;

  factory DiscoverResponseSkillExploreItemsContext.fromJson(
          Map<String, dynamic> json) =>
      _$DiscoverResponseSkillExploreItemsContextFromJson(json);
}

@freezed
class DiscoverResponseSkillExploreItemsSuggestions
    with _$DiscoverResponseSkillExploreItemsSuggestions {
  const factory DiscoverResponseSkillExploreItemsSuggestions({
    @JsonKey(name: 'UserSuggestionId') int? userSuggestionId,
    @JsonKey(name: 'SuggestionDetails') String? suggestionDetails,
    @JsonKey(name: 'ContentSource') String? contentSource,
    @JsonKey(name: 'SortOrder') int? sortOrder,
    @JsonKey(name: 'TotalSuggestions') int? totalSuggestions,
    @JsonKey(name: 'ReferenceType') String? referenceType,
    @JsonKey(name: 'ReferenceId') int? referenceId,
    @JsonKey(name: 'Reference')
    DiscoverResponseSkillExploreItemsSuggestionsReference? reference,
  }) = _DiscoverResponseSkillExploreItemsSuggestions;

  factory DiscoverResponseSkillExploreItemsSuggestions.fromJson(
          Map<String, dynamic> json) =>
      _$DiscoverResponseSkillExploreItemsSuggestionsFromJson(json);
}

@freezed
class DiscoverResponseSkillExploreItemsSuggestionsReference
    with _$DiscoverResponseSkillExploreItemsSuggestionsReference {
  const factory DiscoverResponseSkillExploreItemsSuggestionsReference({
    @JsonKey(name: 'IsActive') bool? isActive,
    @JsonKey(name: 'UserCount') int? userCount,
    @JsonKey(name: 'OrganizationId') int? organizationId,
    @JsonKey(name: 'DateCreated') String? dateCreated,
    @JsonKey(name: 'EnrollDate') String? enrollDate,
    @JsonKey(name: 'PercentComplete') double? percentComplete,
    @JsonKey(name: 'IsEnrolled') bool? isEnrolled,
    @JsonKey(name: 'IsNative') bool? isNative,
    @JsonKey(name: 'IsFeatured') bool? isFeatured,
    @JsonKey(name: 'HeaderImageDisabled') bool? headerImageDisabled,
    @JsonKey(name: 'DurationDisplayDisabled') bool? durationDisplayDisabled,
    @JsonKey(name: 'OrganizationCode') String? organizationCode,
    @JsonKey(name: 'ShareAuthorPermission') bool? shareAuthorPermission,
    @JsonKey(name: 'PathwayId') int? pathwayId,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'Code') String? code,
    @JsonKey(name: 'TypeName') String? typeName,
    @JsonKey(name: 'PrivacyLevel') int? privacyLevel,
    @JsonKey(name: 'ProviderId') int? providerId,
    @JsonKey(name: 'ProviderName') String? providerName,
    @JsonKey(name: 'ProviderImage') String? providerImage,
    @JsonKey(name: 'ProviderUrl') String? providerUrl,
    @JsonKey(name: 'IsEndorsed') bool? isEndorsed,
    @JsonKey(name: 'InternalUrl') String? internalUrl,
    @JsonKey(name: 'PublicUrl') String? publicUrl,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'ResourceId') int? resourceId,
    @JsonKey(name: 'ResourceType') String? resourceType,
    @JsonKey(name: 'Tags') List<dynamic>? tags,
    @JsonKey(name: 'GroupIds') List<dynamic>? groupIds,
    @JsonKey(name: 'AuthorKeys') List<dynamic>? authorKeys,
    @JsonKey(name: 'OrganizationType') String? organizationType,
    @JsonKey(name: 'OrganizationName') String? organizationName,
    @JsonKey(name: 'OrganizationUrl') String? organizationUrl,
  }) = _DiscoverResponseSkillExploreItemsSuggestionsReference;

  factory DiscoverResponseSkillExploreItemsSuggestionsReference.fromJson(
          Map<String, dynamic> json) =>
      _$DiscoverResponseSkillExploreItemsSuggestionsReferenceFromJson(json);
}
