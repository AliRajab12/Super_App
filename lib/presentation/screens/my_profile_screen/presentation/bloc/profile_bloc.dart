import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/bloc/profile_event.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(const ProfileState()) {
    on<EditProfileEvent>((event, emit) {
      emit(state.copyWith(
        edit: event.edit,
      ));
    });
    on<UpdateProfileEvent>((event, emit) {
      emit(state.copyWith(
        edit: false,
        name: event.name,
        phone: event.phone,
        email: event.email,
      ));
    });
  }
}
