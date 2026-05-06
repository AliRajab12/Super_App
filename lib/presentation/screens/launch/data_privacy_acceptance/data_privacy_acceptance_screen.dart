import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/adaptive_alert_dialog.dart';
import 'package:somi/core/widgets/degreed_snack_bar.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/core/widgets/text_button.dart';
import 'package:somi/presentation/screens/launch/data_privacy_acceptance/data_privacy_acceptance_cubit.dart';
import 'package:somi/presentation/screens/launch/data_privacy_acceptance/data_privacy_acceptance_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DataPrivacyAcceptanceScreen extends StatefulWidget {
  const DataPrivacyAcceptanceScreen(this.message, {super.key});

  final String message;

  @override
  State<DataPrivacyAcceptanceScreen> createState() =>
      _DataPrivacyAcceptanceScreenState();
}

class _DataPrivacyAcceptanceScreenState
    extends State<DataPrivacyAcceptanceScreen> {
  DataPrivacyAcceptanceCubit cubit = locator<DataPrivacyAcceptanceCubit>();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(checkScrollPosition);
    checkScrollPosition();
    super.initState();
  }

  void checkScrollPosition() {
    if (scrollController.hasClients) {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 16) {
        scrollController.removeListener(checkScrollPosition);
        cubit.setHasReachedBottom();
      }
    } else {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => checkScrollPosition());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DataPrivacyAcceptanceCubit, DataPrivacyAcceptanceState>(
      bloc: cubit,
      listenWhen: (previous, current) => previous.error != current.error,
      listener: (context, state) {
        final snackbar = DegreedSnackBar.error(
            message: AppLocalizations.of(context)!.checkInternetConnection);
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      },
      builder: (context, state) {
        return buildFromState(context, state);
      },
    );
  }

  WillPopScope buildFromState(
      BuildContext context, DataPrivacyAcceptanceState state) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dataPrivacyPolicy),
          automaticallyImplyLeading: false,
          actions: [
            TxtButton.large(
              text: AppLocalizations.of(context)!.cancel,
              onPressed: () => showCancelConfirmation(context),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: AppColors.background,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: PrimaryButton.large(
            expand: true,
            text: AppLocalizations.of(context)!.acceptAndContinue,
            onPressed: state.hasReachedBottom ? cubit.accept : null,
            isLoading: state.saving,
          ),
        ),
        body: Scrollbar(
          child: SingleChildScrollView(
            controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.dpaHeader,
                      style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 8),
                  Html(
                    data: widget.message,
                    style: {'body': Style(margin: Margins.zero)},
                    shrinkWrap: true,
                    onLinkTap: (url, _, __) {
                      if (url != null)
                        launchUrl(Uri.parse(url),
                            mode: LaunchMode.externalApplication);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showCancelConfirmation(BuildContext context) {
    showDegreedAdaptiveDialog(
      context,
      (context) => AdaptiveAlertDialog(
        title: Text(AppLocalizations.of(context)!.areYouSure),
        content: Text(AppLocalizations.of(context)!.youWillBeLoggedOut),
        actions: [
          DialogAction(label: AppLocalizations.of(context)!.cancel),
          DialogAction(
            label: AppLocalizations.of(context)!.yesLogOut,
            isDefaultAction: true,
            onPressed: cubit.decline,
          ),
        ],
      ),
    );
  }
}
