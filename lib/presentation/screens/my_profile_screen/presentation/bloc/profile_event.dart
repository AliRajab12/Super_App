import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {}

class EditProfileEvent extends ProfileEvent {
  final bool? edit;
  EditProfileEvent({
    this.edit,
  });
  @override
  List<Object?> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final String? name;
  final String? email;
  final String? phone;
  UpdateProfileEvent({
    this.name,
    this.phone,
    this.email,
  });
  @override
  List<Object?> get props => [];
}
