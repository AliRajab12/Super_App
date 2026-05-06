import 'package:freezed_annotation/freezed_annotation.dart';

part 'pathway_details.freezed.dart';
part 'pathway_details.g.dart';

@freezed
class PathwayDetails with _$PathwayDetails {
  const factory PathwayDetails({
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'Summary') String? summary,
    @JsonKey(name: 'Completed') bool? completed,
    @JsonKey(name: 'Queued') bool? queued,
    @JsonKey(name: 'Details') PathwayDetailsItem? details,
  }) = _PathwayDetails;

  factory PathwayDetails.fromJson(Map<String, dynamic> json) =>
      _$PathwayDetailsFromJson(json);
}

@freezed
class PathwayDetailsItem with _$PathwayDetailsItem {
  const factory PathwayDetailsItem({
    @JsonKey(name: 'Image') String? image,
    @JsonKey(name: 'Groups') List<dynamic>? groups,
    @JsonKey(name: 'TagNames') List<dynamic>? tagNames,
    @JsonKey(name: 'Levels') List<PathwayDetailsLevels?>? levels,
    @JsonKey(name: 'ResourceId') int? resourceId,
    @JsonKey(name: 'ResourceType') String? resourceType,
    @JsonKey(name: 'PublicUrl') String? publicUrl,
    @JsonKey(name: 'Type') String? type,
    @JsonKey(name: 'OrganizationId') int? organizationId,
    @JsonKey(name: 'PrivacyLevel') int? privacyLevel,
    @JsonKey(name: 'IsImageUrlFallbackImage') bool? isImageUrlFallbackImage,
    @JsonKey(name: 'AuthorProfileKeys') List<int?>? authorProfileKeys,
    @JsonKey(name: 'Authors') List<PathwayDetailsAuthors?>? authors,
    @JsonKey(name: 'ShareAuthorPermission') bool? shareAuthorPermission,
    @JsonKey(name: 'IsEndorsed') bool? isEndorsed,
    @JsonKey(name: 'IsEnrolled') bool? isEnrolled,
    @JsonKey(name: 'IsNative') bool? isNative,
    @JsonKey(name: 'IsQueued') bool? isQueued,
    @JsonKey(name: 'GroupIds') List<dynamic>? groupIds,
    @JsonKey(name: 'DurationDisplayDisabled') bool? durationDisplayDisabled,
    @JsonKey(name: 'CompletedSteps') int? completedSteps,
    @JsonKey(name: 'OptionalSteps') int? optionalSteps,
    @JsonKey(name: 'TotalSteps') int? totalSteps,
    @JsonKey(name: 'TotalLevelsWithItems') int? totalLevelsWithItems,
    @JsonKey(name: 'Progress') double? progress,
    @JsonKey(name: 'Version') String? version,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Number') int? number,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'DurationUnits') double? durationUnits,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'Complete') bool? complete,
    @JsonKey(name: 'IsRequired') bool? isRequired,
  }) = _PathwayDetailsItem;

  factory PathwayDetailsItem.fromJson(Map<String, dynamic> json) =>
      _$PathwayDetailsItemFromJson(json);
}

@freezed
class PathwayDetailsLevels with _$PathwayDetailsLevels {
  const factory PathwayDetailsLevels({
    @JsonKey(name: 'Lessons') List<PathwayDetailsLevelsLessons?>? lessons,
    @JsonKey(name: 'TotalLessonsWithItems') int? totalLessonsWithItems,
    @JsonKey(name: 'TotalLessons') int? totalLessons,
    @JsonKey(name: 'CompletedSteps') int? completedSteps,
    @JsonKey(name: 'OptionalSteps') int? optionalSteps,
    @JsonKey(name: 'TotalSteps') int? totalSteps,
    @JsonKey(name: 'Progress') double? progress,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Node') String? node,
    @JsonKey(name: 'Number') int? number,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'DurationUnits') double? durationUnits,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'DurationHours') int? durationHours,
    @JsonKey(name: 'DurationMinutes') int? durationMinutes,
    @JsonKey(name: 'Complete') bool? complete,
    @JsonKey(name: 'IsRequired') bool? isRequired,
    @JsonKey(name: 'PathId') int? pathId,
  }) = _PathwayDetailsLevels;

  factory PathwayDetailsLevels.fromJson(Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsFromJson(json);
}

@freezed
class PathwayDetailsLevelsLessons with _$PathwayDetailsLevelsLessons {
  const factory PathwayDetailsLevelsLessons({
    @JsonKey(name: 'Steps') List<PathwayDetailsLevelsLessonsSteps?>? steps,
    @JsonKey(name: 'LevelNumber') int? levelNumber,
    @JsonKey(name: 'LessonItemCount') int? lessonItemCount,
    @JsonKey(name: 'CompletedSteps') int? completedSteps,
    @JsonKey(name: 'OptionalSteps') int? optionalSteps,
    @JsonKey(name: 'TotalSteps') int? totalSteps,
    @JsonKey(name: 'Progress') double? progress,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Node') String? node,
    @JsonKey(name: 'Number') int? number,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'DurationUnits') double? durationUnits,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'DurationHours') int? durationHours,
    @JsonKey(name: 'DurationMinutes') int? durationMinutes,
    @JsonKey(name: 'Complete') bool? complete,
    @JsonKey(name: 'IsRequired') bool? isRequired,
    @JsonKey(name: 'PathId') int? pathId,
  }) = _PathwayDetailsLevelsLessons;

  factory PathwayDetailsLevelsLessons.fromJson(Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsFromJson(json);
}

@freezed
class PathwayDetailsLevelsLessonsSteps with _$PathwayDetailsLevelsLessonsSteps {
  const factory PathwayDetailsLevelsLessonsSteps({
    @JsonKey(name: 'Items') List<PathwayDetailsLevelsLessonsStepsItems?>? items,
    @JsonKey(name: 'LevelNumber') int? levelNumber,
    @JsonKey(name: 'LessonNumber') int? lessonNumber,
    @JsonKey(name: 'ReferenceType') String? referenceType,
    @JsonKey(name: 'ReferenceId') int? referenceId,
    @JsonKey(name: 'IsNew') bool? isNew,
    @JsonKey(name: 'Id') int? id,
    @JsonKey(name: 'Node') String? node,
    @JsonKey(name: 'Number') int? number,
    @JsonKey(name: 'DurationUnits') double? durationUnits,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'DurationDisplay') String? durationDisplay,
    @JsonKey(name: 'DurationMinutes') int? durationMinutes,
    @JsonKey(name: 'Complete') bool? complete,
    @JsonKey(name: 'IsRequired') bool? isRequired,
    @JsonKey(name: 'PathId') int? pathId,
  }) = _PathwayDetailsLevelsLessonsSteps;

  factory PathwayDetailsLevelsLessonsSteps.fromJson(
          Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsStepsFromJson(json);
}

@freezed
class PathwayDetailsLevelsLessonsStepsItems
    with _$PathwayDetailsLevelsLessonsStepsItems {
  const factory PathwayDetailsLevelsLessonsStepsItems({
    @JsonKey(name: 'Node') String? node,
    @JsonKey(name: 'Reference')
    PathwayDetailsLevelsLessonsStepsItemsReference? reference,
    @JsonKey(name: 'ReferenceType') String? referenceType,
    @JsonKey(name: 'ReferenceId') int? referenceId,
  }) = _PathwayDetailsLevelsLessonsStepsItems;

  factory PathwayDetailsLevelsLessonsStepsItems.fromJson(
          Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsStepsItemsFromJson(json);
}

@freezed
class PathwayDetailsLevelsLessonsStepsItemsReference
    with _$PathwayDetailsLevelsLessonsStepsItemsReference {
  const factory PathwayDetailsLevelsLessonsStepsItemsReference({
    @JsonKey(name: 'InputType') String? inputType,
    @JsonKey(name: 'InputId') int? inputId,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Url') String? url,
    @JsonKey(name: 'ImageUrl') String? imageUrl,
    @JsonKey(name: 'ProviderName') String? providerName,
    @JsonKey(name: 'Summary') String? summary,
    @JsonKey(name: 'Obsolete') bool? obsolete,
    @JsonKey(name: 'OrganizationId') int? organizationId,
    @JsonKey(name: 'DurationUnitType') String? durationUnitType,
    @JsonKey(name: 'DurationMinutes') @Default(0) int? durationMinutes,
    @JsonKey(name: 'IsCompleted') bool? isCompleted,
    @JsonKey(name: 'IsVerified') bool? isVerified,
    @JsonKey(name: 'UserHasCommented') bool? userHasCommented,
    @JsonKey(name: 'ExternalCompletionOnly') bool? externalCompletionOnly,
    @JsonKey(name: 'DateCreated') String? dateCreated,
    @JsonKey(name: 'LearningMinutes') double? learningMinutes,
    @JsonKey(name: 'DurationISO') String? durationISO,
    @JsonKey(name: 'DateModified') String? dateModified,
    @JsonKey(name: 'IsViewed') bool? isViewed,
    @JsonKey(name: 'IsEndorsed') bool? isEndorsed,
    @JsonKey(name: 'InternalUrl') String? internalUrl,
    @JsonKey(name: 'ProviderImageInfo')
    PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity?
        providerImageInfo,
    @JsonKey(name: 'ResourceId') int? resourceId,
    @JsonKey(name: 'ResourceType') String? resourceType,
    @JsonKey(name: 'OrganizationName') String? organizationName,
    @JsonKey(name: 'IsQueued') bool? isQueued,
    @JsonKey(name: 'IsCmsContent') bool? isCmsContent,
    @JsonKey(name: 'HasUserDescription') bool? hasUserDescription,
    @JsonKey(name: 'PathwayStepDetails')
    PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails?
        pathwayStepDetails,
    @JsonKey(name: 'LiveSessions') List<dynamic>? liveSessions,
    @JsonKey(name: 'UserResource')
    PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource? userResource,
    @JsonKey(name: 'IsRegistered') bool? isRegistered,
    @JsonKey(name: 'IsLive') bool? isLive,
    @JsonKey(name: 'HasRelatedContent') bool? hasRelatedContent,
    @JsonKey(name: 'HasBrokenUrl') bool? hasBrokenUrl,
    @JsonKey(name: 'CreatedBy') String? createdBy,
  }) = _PathwayDetailsLevelsLessonsStepsItemsReference;

  factory PathwayDetailsLevelsLessonsStepsItemsReference.fromJson(
          Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsStepsItemsReferenceFromJson(json);
}

@freezed
class PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity
    with
        _$PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity {
  const factory PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity() =
      _PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity;

  factory PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntity.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceProviderImageInfoEntityFromJson(
          json);
}

@freezed
class PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails
    with _$PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails {
  const factory PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails({
    @JsonKey(name: 'PathwayId') int? pathwayId,
    @JsonKey(name: 'IsOptional') bool? isOptional,
  }) = _PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails;

  factory PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetails.fromJson(
          Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsStepsItemsReferencePathwayStepDetailsFromJson(
          json);
}

@freezed
class PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource
    with _$PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource {
  const factory PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource({
    @JsonKey(name: 'UserResourceId') int? userResourceId,
    @JsonKey(name: 'ResourceId') int? resourceId,
    @JsonKey(name: 'ResourceTypeId') int? resourceTypeId,
    @JsonKey(name: 'Details')
    PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity?
        details,
    @JsonKey(name: 'StatusId') int? statusId,
  }) = _PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource;

  factory PathwayDetailsLevelsLessonsStepsItemsReferenceUserResource.fromJson(
          Map<String, dynamic> json) =>
      _$PathwayDetailsLevelsLessonsStepsItemsReferenceUserResourceFromJson(
          json);
}

@freezed
class PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity
    with
        _$PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity {
  const factory PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity() =
      _PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity;

  factory PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntity.fromJson(
    Map<String, dynamic> json,
  ) =>
      _$PathwaydetailsDetailsLevelsLessonsStepsItemsReferenceUserResourceDetailsEntityFromJson(
          json);
}

@freezed
class PathwayDetailsAuthors with _$PathwayDetailsAuthors {
  const factory PathwayDetailsAuthors({
    @JsonKey(name: 'UserProfileKey') int? userProfileKey,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Email') String? email,
    @JsonKey(name: 'Picture') String? picture,
    @JsonKey(name: 'VanityUrl') String? vanityUrl,
    @JsonKey(name: 'DisplayAnonymous') bool? displayAnonymous,
  }) = _PathwayDetailsAuthors;

  factory PathwayDetailsAuthors.fromJson(Map<String, dynamic> json) =>
      _$PathwayDetailsAuthorsFromJson(json);
}
