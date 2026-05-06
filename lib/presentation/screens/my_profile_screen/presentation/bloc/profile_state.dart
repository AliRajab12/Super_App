import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default('Iris watson') String? name,
    @Default('+97123232323') String? phone,
    @Default('iris@gmail.com') String? email,
    @Default(false) bool? edit,
    @Default(null) Object? error,
  }) = _ProfileState;
}
