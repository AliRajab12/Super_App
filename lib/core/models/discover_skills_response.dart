class DiscoverSkillsResponse {
  List<Item> items;

  DiscoverSkillsResponse({
    required this.items,
  });
}

class Item {
  Context context;
  List<Suggestion> suggestions;

  Item({
    required this.context,
    required this.suggestions,
  });
}

class Context {
  int id;
  String label;

  Context({
    required this.id,
    required this.label,
  });
}

class Suggestion {
  int userSuggestionId;
  String suggestionDetails;
  String contentSource;
  int sortOrder;
  int totalSuggestions;
  String referenceType;
  int referenceId;
  Reference reference;

  Suggestion({
    required this.userSuggestionId,
    required this.suggestionDetails,
    required this.contentSource,
    required this.sortOrder,
    required this.totalSuggestions,
    required this.referenceType,
    required this.referenceId,
    required this.reference,
  });
}

class Reference {
  String inputType;
  int inputId;
  String title;
  String url;
  bool obsolete;
  String? tags;
  int providerId;
  String providerName;
  String providerUrl;
  String providerInternalUrl;
  String providerImages;
  String? summary;
  int? durationUnits;
  String durationUnitType;
  bool isCompleted;
  bool isVerified;
  String externalId;
  bool userHasCommented;
  String providerCode;
  bool externalCompletionOnly;
  DateTime dateCreated;
  DateTime dateModified;
  bool isViewed;
  bool isEndorsed;
  String internalUrl;
  ProviderImageInfo providerImageInfo;
  String? durationDisplay;
  int resourceId;
  String resourceType;
  bool isQueued;
  bool isCmsContent;
  List<dynamic> liveSessions;
  UserResource userResource;
  bool isRegistered;
  bool isLive;
  bool hasRelatedContent;
  bool hasBrokenUrl;
  int? organizationId;
  String? format;
  String? organizationName;
  String? cost;

  Reference({
    required this.inputType,
    required this.inputId,
    required this.title,
    required this.url,
    required this.obsolete,
    this.tags,
    required this.providerId,
    required this.providerName,
    required this.providerUrl,
    required this.providerInternalUrl,
    required this.providerImages,
    this.summary,
    this.durationUnits,
    required this.durationUnitType,
    required this.isCompleted,
    required this.isVerified,
    required this.externalId,
    required this.userHasCommented,
    required this.providerCode,
    required this.externalCompletionOnly,
    required this.dateCreated,
    required this.dateModified,
    required this.isViewed,
    required this.isEndorsed,
    required this.internalUrl,
    required this.providerImageInfo,
    this.durationDisplay,
    required this.resourceId,
    required this.resourceType,
    required this.isQueued,
    required this.isCmsContent,
    required this.liveSessions,
    required this.userResource,
    required this.isRegistered,
    required this.isLive,
    required this.hasRelatedContent,
    required this.hasBrokenUrl,
    this.organizationId,
    this.format,
    this.organizationName,
    this.cost,
  });
}

class ProviderImageInfo {
  String png;
  String? svg;
  String? favicon;

  ProviderImageInfo({
    required this.png,
    this.svg,
    this.favicon,
  });
}

class UserResource {
  int userResourceId;
  int resourceId;
  int resourceTypeId;
  Details details;
  int statusId;

  UserResource({
    required this.userResourceId,
    required this.resourceId,
    required this.resourceTypeId,
    required this.details,
    required this.statusId,
  });
}

class Details {
  Details();
}
