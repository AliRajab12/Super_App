import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_item.freezed.dart';
part 'user_item.g.dart';

@freezed
class UserItem with _$UserItem {
  const UserItem._();

  const factory UserItem({
    @Default(null) @JsonKey(name: 'UserProfile') User? userProfile,
    @Default(true) @JsonKey(name: 'ViewerCanFollow') bool viewersCanFollow,
    @Default(false) @JsonKey(name: 'UserFollows') bool userFollowing,
  }) = _UserItem;

  factory UserItem.fromJson(Map<String, dynamic> json) =>
      _$UserItemFromJson(json);

  User? asUser() {
    if (userProfile == null) return null;
    return userProfile!.copyWith(
      viewersCanFollow: viewersCanFollow,
      userFollows: userFollowing,
    );
  }
}
