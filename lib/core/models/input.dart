import 'package:somi/core/models/group_activity.dart';
import 'package:somi/core/models/pathway.dart';
import 'package:somi/core/models/rating.dart';
import 'package:somi/core/models/resource.dart';
import 'package:somi/core/models/statistics.dart';
import 'package:somi/core/models/suggestion_detail.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'input.freezed.dart';
part 'input.g.dart';

@freezed
class Input with _$Input {
  const Input._();

  const factory Input({
    @JsonKey(name: 'InputId') @Default(null) int? inputId,
    @JsonKey(name: 'InputType') @Default(null) String? inputType,
    @JsonKey(name: 'Source') @Default(null) String? source,
    @JsonKey(name: 'Url') @Default(null) String? url,
    @JsonKey(name: 'Title') @Default(null) String? title,
    @JsonKey(name: 'ImageUrl') @Default(null) String? imageUrl,
    @JsonKey(name: 'Author') @Default(null) String? author,
    @JsonKey(name: 'Hostname') @Default(null) String? hostname,
    @JsonKey(name: 'Summary') @Default(null) String? summary,
    @JsonKey(name: 'Tags') @Default(null) String? skill,
    @JsonKey(name: 'ProviderId') @Default(null) int? providerId,
    @JsonKey(name: 'ProviderName') @Default(null) String? providerName,
    @JsonKey(name: 'ProviderUrl') @Default(null) String? providerUrl,
    @JsonKey(name: 'ProviderImage') @Default(null) String? providerImage,
    @JsonKey(name: 'DurationUnits') @Default(null) double? durationUnits,
    @JsonKey(name: 'DurationUnitType') @Default(null) String? durationUnitType,
    @JsonKey(name: 'DurationDisplay') @Default(null) String? durationDisplay,
    @JsonKey(name: 'CommentCount') @Default(null) int? commentCount,
    @JsonKey(name: 'InternalUrl') @Default(null) String? internalUrl,
    @JsonKey(name: 'UserInputId') @Default(null) int? userInputId,
    @JsonKey(name: 'UserSuggestionId') @Default(null) int? userSuggestionId,
    @JsonKey(name: 'QueueItemId') @Default(null) int? queueItemId,
    @JsonKey(name: 'Position') @Default(null) String? position,
    @JsonKey(name: 'DateCompleted') @Default(null) String? dateCompleted,
    @JsonKey(name: 'IsCompleted') @Default(null) bool? isCompleted,
    @JsonKey(name: 'IsQueued') @Default(null) bool? isQueued,
    @JsonKey(name: 'IsEnrolled') @Default(null) bool? isEnrolled,
    @JsonKey(name: 'IsFollowing') @Default(null) bool? isFollowing,
    @JsonKey(name: 'IsOverdue') @Default(null) bool? isOverdue,
    @JsonKey(name: 'IsDueSoon') @Default(null) bool? isDueSoon,
    @JsonKey(name: 'IsDueLater') @Default(null) bool? isDueLater,
    @JsonKey(name: 'RecommendationType')
    @Default(null)
    String? recommendationType,
    @JsonKey(name: 'SuggestionDetailsCollection')
    @Default(null)
    SuggestionDetail? suggestionDetail,
    @JsonKey(name: 'Rating') @Default(null) Rating? rating,
    @JsonKey(name: 'Ratings') @Default(null) List<Rating>? ratings,
    @JsonKey(name: 'DateCreated') @Default(null) String? dateCreated,
    @JsonKey(name: 'StartDate') @Default(null) String? startDate,
    @JsonKey(name: 'EndDate') @Default(null) String? endDate,
    @JsonKey(name: 'OrganizationId') @Default(null) int? organizationId,
    @JsonKey(name: 'DateRange') @Default(null) String? dateRange,
    @JsonKey(name: 'CreatorUserProfileId')
    @Default(null)
    String? creatorUserProfileId,
    @JsonKey(name: 'GroupName') @Default(null) String? groupName,
    @JsonKey(name: 'DateDue') @Default(null) String? dateDue,
    @JsonKey(name: 'Reference') @Default(null) Resource? reference,
    @JsonKey(name: 'ReferenceType') @Default(null) String? referenceType,
    @JsonKey(name: 'Statistics') @Default(null) Statistics? statistics,
    @JsonKey(name: 'Comment') @Default(null) String? comment,
    @JsonKey(name: 'ReasonForDisplay') @Default(null) String? reasonForDisplay,
    @JsonKey(name: 'RequiredDueDate') @Default(null) DateTime? requiredDueDate,
    @JsonKey(name: 'PercentComplete') @Default(null) double? percentComplete,
  }) = _Input;

  bool get isPlan => inputType == 'Target';

  bool get isPathway => inputType == 'Pathway';

  bool get canAddToPlan {
    const types = [
      'Article',
      'Video',
      'Book',
      'Course',
      'Episode',
      'Pathway',
      'Event',
      'Assessment',
      'Tag'
    ];
    return types.contains(inputType);
  }

  bool get canAddToPathway {
    const types = [
      'Article',
      'Video',
      'Book',
      'Course',
      'Episode',
      'Pathway',
      'Event',
      'Assessment',
      'Tag'
    ];
    return types.contains(inputType);
  }

  bool get canAction {
    const types = [
      'Article',
      'Video',
      'Book',
      'Course',
      'Episode',
      'Pathway',
      'Task',
      'Assessment',
      'Event',
      'Post'
    ];
    if (recommendationType == 'RequiredLearning' /*&& recommendedBy == null*/) {
      return false;
    }

    return types.contains(inputType);
  }

  bool get canComplete {
    const types = [
      'Article',
      'Video',
      'Book',
      'Course',
      'Episode',
      'Task',
      'Event',
      'Assessment',
      'Post'
    ];
    if (recommendationType == 'RequiredLearning' /*&& recommendedBy == null*/) {
      return false;
    }

    if (requiredDueDate != null) {
      return false;
    }

    if (types.contains(inputType)) {
      return true;
    }
    return false;
  }

  bool get canNavigate {
    const types = [
      'Article',
      'Video',
      'Book',
      'Course',
      'Episode',
      'Pathway',
      'Task',
      'Target',
      'Event',
      'Assessment',
      'Post',
    ];
    return types.contains(inputType);
  }

  bool get canTakeaway =>
      canAction &&
      inputType != 'Pathway' &&
      inputType != 'Task' &&
      inputType != 'Post';

  factory Input.fromJson(Map<String, dynamic> json) => _$InputFromJson(json);

  factory Input.fromPathway(Pathway pathway) {
    return Input(
      inputType: 'Pathway',
      inputId: pathway.id,
      title: pathway.title,
      imageUrl: pathway.imageUrl,
      isQueued: pathway.isQueued,
      isEnrolled: pathway.isEnrolled,
      percentComplete: pathway.percentComplete ?? pathway.progress,
      summary: pathway.description,
    );
  }

  factory Input.fromGroupActivity(GroupActivity activityItem) {
    Input input = Input.fromResource(activityItem.reference);
    input = input.copyWith(
      inputId: input.inputId ?? activityItem.activityId,
      inputType:
          input.inputType ?? '${activityItem.type}${activityItem.action}',
      comment: activityItem.details.comment,
      reasonForDisplay: activityItem.reasonForDisplay,
    );
    return input;
  }

  factory Input.fromResource(Resource? resource) {
    if (resource == null) return const Input();

    return Input(
      inputType: resource.resourceType,
      inputId: resource.resourceId,
      title: resource.title,
      summary: (resource.summary ?? resource.description)
          ?.replaceAll(RegExp(r'\s+'), ' '),
      url: resource.url,
      internalUrl: resource.internalUrl,
      imageUrl: resource.imageUrl,
      isCompleted: resource.isCompleted,
      isQueued: resource.isQueued,
      isEnrolled: resource.isEnrolled,
      isFollowing: resource.isFollowing,
      durationDisplay: resource.durationDisplay,
      queueItemId: resource.queueItemId,
      rating: resource.rating,
      ratings: resource.ratings,
      reference: resource,
    );
  }
}
