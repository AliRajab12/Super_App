import 'package:somi/core/main_router.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/services/user_service.dart';
import 'package:somi/presentation/screens/launch/data_privacy_acceptance/data_privacy_acceptance_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DataPrivacyAcceptanceCubit extends Cubit<DataPrivacyAcceptanceState> {
  final UserService userService;
  final UserRepo userRepo;
  final MainRouter router;

  DataPrivacyAcceptanceCubit(
    this.userService,
    this.userRepo,
    this.router, {
    DataPrivacyAcceptanceState initialState =
        const DataPrivacyAcceptanceState(),
  }) : super(initialState);

  void setHasReachedBottom() {
    emit(state.copyWith(hasReachedBottom: true));
  }

  Future<void> accept() async {
    emit(state.copyWith(saving: true));
    try {
      await userService.acceptDataPrivacy();
      await userRepo.refreshInitialData();
      router.popForced(true);
    } catch (e) {
      emit(state.copyWith(saving: false, error: e));
    }
  }

  void decline() {
    router.popForced(false);
  }
}
