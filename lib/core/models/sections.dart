import 'package:freezed_annotation/freezed_annotation.dart';

part 'sections.freezed.dart';

part 'sections.g.dart';

@freezed
class Sections with _$Sections {
  const factory Sections({
    @JsonKey(name: 'ParentNode') String? parentNode,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Description') String? description,
    @JsonKey(name: 'ResourceCount') int? resourceCount,
    @JsonKey(name: 'ResourceType') String? resourceType,
    @JsonKey(name: 'ImageUrl') dynamic imageUrl,
  }) = _Sections;

  factory Sections.fromJson(Map<String, dynamic> json) =>
      _$SectionsFromJson(json);
}
