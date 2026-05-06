import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource_type.freezed.dart';
part 'resource_type.g.dart';

@freezed
class ResourceType with _$ResourceType {
  const factory ResourceType({
    @JsonKey(name: 'NameWithSpaces') String? nameWithSpaces,
    @JsonKey(name: 'IsInternal') bool? isInternal,
    @JsonKey(name: 'TypeId') int? typeId,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'IsActive') bool? isActive,
  }) = _ResourceType;

  factory ResourceType.fromJson(Map<String, dynamic> json) =>
      _$ResourceTypeFromJson(json);
}

class ResourceTypeJsonConverter
    implements JsonConverter<ResourceType?, dynamic> {
  const ResourceTypeJsonConverter();

  @override
  ResourceType? fromJson(dynamic json) {
    if (json == null) return null;
    if (json is String) {
      return ResourceType(
        name: json,
        nameWithSpaces: json,
      );
    } else if (json is Map<String, dynamic>) {
      return ResourceType.fromJson(json);
    }
    return null;
  }

  @override
  dynamic toJson(ResourceType? resourceType) {
    return null;
  }
}
