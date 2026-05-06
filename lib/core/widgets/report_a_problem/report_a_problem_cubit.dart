import 'package:somi/core/models/input.dart';
import 'package:somi/core/services/resource_service.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportAProblemCubit extends Cubit<ReportAProblemState> {
  final Input? input;
  final String? source;

  final ResourceService resourceService;

  ReportAProblemCubit(this.input, this.source, this.resourceService)
      : super(const ReportAProblemState());

  bool get canSubmit => !state.submitting && !state.description.isBlank;

  void updateDescription(String description) =>
      emit(state.copyWith(description: description.trim()));

  Future<void> submit() async {
    try {
      emit(state.copyWith(submitting: true));
      await resourceService.reportAProblem(
        emailBody: state.description,
        source: source == null ? 'Mobile' : 'Mobile: $source',
        itemType: input?.inputType ?? '',
        itemInfo: input?.inputId ?? 0,
        title: input?.title ?? '',
      );
      emit(state.copyWith(success: true));
    } catch (e) {
      emit(state.copyWith(submitting: false, error: e));
    }
  }
}
