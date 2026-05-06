import 'package:somi/core/models/tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'role.freezed.dart';
part 'role.g.dart';

@freezed
class Role with _$Role {
  const factory Role({
    @JsonKey(name: 'Id') int? roleId,
    @JsonKey(name: 'Title') String? title,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'Description') String? summary,
    @JsonKey(name: 'Tags') @Default([]) List<Tag> skills,
  }) = _Role;

  factory Role.fromJson(Map<String, dynamic> json) => _$RoleFromJson(json);
}
