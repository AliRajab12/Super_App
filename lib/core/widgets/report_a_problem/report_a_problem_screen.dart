import 'package:somi/core/models/input.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/degreed_snack_bar.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_cubit.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportAProblemScreen extends StatefulWidget {
  final Input? input;
  final String? source;

  const ReportAProblemScreen({
    super.key,
    this.input,
    this.source,
  });

  @override
  State<ReportAProblemScreen> createState() => _ReportAProblemScreenState();
}

class _ReportAProblemScreenState extends State<ReportAProblemScreen> {
  late final cubit = locator<ReportAProblemCubit>(
    param1: widget.input,
    param2: widget.source,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.reportAProblem)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<ReportAProblemCubit, ReportAProblemState>(
            bloc: cubit,
            listenWhen: (previous, current) => previous.error != current.error,
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(DegreedSnackBar.error(
                  message: AppLocalizations.of(context)!.errorSendingReport));
            },
          ),
          BlocListener<ReportAProblemCubit, ReportAProblemState>(
            bloc: cubit,
            listenWhen: (previous, current) =>
                current.success && (previous.success != current.success),
            listener: (context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                  DegreedSnackBar.success(
                      message: AppLocalizations.of(context)!.reported));
              Navigator.pop(context);
            },
          ),
        ],
        child: BlocBuilder<ReportAProblemCubit, ReportAProblemState>(
          bloc: cubit,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: TextField(
                        enabled: !state.submitting,
                        decoration: InputDecoration(
                          alignLabelWithHint: true,
                          labelText: AppLocalizations.of(context)!
                              .explainTheProblemYouExperienced,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 4,
                        maxLines: 8,
                        onChanged: (text) => cubit.updateDescription(text),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: PrimaryButton.large(
                      isLoading: state.submitting,
                      onPressed: cubit.canSubmit ? () => cubit.submit() : null,
                      child: Text(AppLocalizations.of(context)!.sendReport),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
