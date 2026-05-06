import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  const factory Group({
    @JsonKey(name: 'GroupId') @Default(0) int groupId,
    @JsonKey(name: 'Name') @Default('') String name,
    @JsonKey(name: 'Description') @Default('') String description,
    @JsonKey(name: 'MemberCount') @Default(0) int memberCount,
    @JsonKey(name: 'PrivacyLevel') @Default(0) int privacyLevel,
    @JsonKey(name: 'IsMember') @Default(false) bool isMember,
    @JsonKey(name: 'IsPendingMember') @Default(false) bool isPendingMember,
    @JsonKey(name: 'Members') @Default(null) List<User>? members,
  }) = _Group;

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);
}
