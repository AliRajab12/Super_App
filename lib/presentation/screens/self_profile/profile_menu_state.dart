import 'package:somi/core/models/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_menu_state.freezed.dart';

@freezed
class ProfileMenuState with _$ProfileMenuState {
  const factory ProfileMenuState({
    @Default(null) User? user,
    @Default(null) String? appVersion,
    @Default(false) bool isSigningOut,
  }) = _ProfileMenuState;
}
