import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/crash_utils.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/url_launcher.dart';
import 'package:somi/core/widgets/degreed_snack_bar.dart';
import 'package:somi/core/widgets/markdown/degreed_markdown.dart';
import 'package:somi/core/widgets/phoenix.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CrashScreen extends StatefulWidget {
  final FlutterErrorDetails error;

  const CrashScreen(this.error, {Key? key}) : super(key: key);

  static const supportUrl =
      'https://degreed.zendesk.com/hc/en-us/requests/new?ticket_form_id=360001430940';

  @override
  State<CrashScreen> createState() => _CrashScreenState();
}

class _CrashScreenState extends State<CrashScreen> {
  bool isReportCollected = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white.withAlpha(0),
            shadowColor: Colors.transparent,
          ),
          extendBodyBehindAppBar: true,
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 36, right: 36, bottom: 8, top: 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: buildContent(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildContent(BuildContext context) {
    return [
      const Spacer(),
      Text(
        AppLocalizations.of(context)!.oops,
        style: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          fontFamily: 'Antonia',
        ),
      ),
      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.only(left: 32, bottom: 36),
        child: Image.asset(
          'images/illustrations/mug-hot-drink.png',
          width: 128,
          height: 200,
        ),
      ),
      Text(
        AppLocalizations.of(context)!.crashScreenTitle,
        style: Theme.of(context).textTheme.labelLarge,
      ),
      const SizedBox(height: 8),
      Text(
        AppLocalizations.of(context)!.crashScreenMessage,
        style: Theme.of(context).textTheme.bodySmall,
        textAlign: TextAlign.center,
      ),
      TextButton(
        onPressed: () => showReportInfoSheet(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.info, size: 16),
            const SizedBox(width: 6),
            Text(
              AppLocalizations.of(context)!.crashScreenInfoLabel,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
      const SizedBox(height: 32),
      Wrap(
        alignment: WrapAlignment.center,
        spacing: 12,
        runSpacing: 12,
        children: [
          OutlinedButton(
            onPressed: () => locator<UrlLauncher>().launch(
              CrashScreen.supportUrl,
              mode: LaunchMode.externalApplication,
            ),
            child: Text(AppLocalizations.of(context)!.contactSupport),
          ),
          if (!isReportCollected)
            PrimaryButton.large(
              onPressed: () => collectReport(context),
              child: Text(AppLocalizations.of(context)!.sendReport),
            ),
        ],
      ),
      const Spacer(),
      TextButton(
        onPressed: () => Phoenix.rebirth(context),
        child: Text(
          AppLocalizations.of(context)!.restartApp,
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ];
  }

  void showReportInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DegreedMarkdown(
          data: getStringText(),
          shrinkWrapAllowScroll: true,
          styleSheet: MarkdownStyleSheet(
            p: Theme.of(context).textTheme.bodySmall,
            strong: const TextStyle(color: AppColors.grayDark),
            h3Padding: EdgeInsets.zero,
          ),
        );
      },
    );
  }

  void collectReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(DegreedSnackBar.success(
        message: AppLocalizations.of(context)!.crashReportCollected));
    locator<CrashUtils>().collectFlutterError(widget.error);
    setState(() {
      isReportCollected = true;
    });
  }

  getStringText() {
    return '${'''### **Information Collected for Error Reporting**

                                 When you opt to send an error report, we gather data to assist in diagnosing and rectifying potential issues in the application. Please be assured, your privacy is paramount to us, and no personal or identifiable information will be collected or sent. Below is a summary of the data collected:

                                 - **Application Details**: Insights about the app's state at the time of the error. This may include which screen you were on, the actions leading up to the error, and other non-sensitive operational insights.
                                 - **Device Information**: General specifications of your device, such as its brand, model, operating system version, and configuration. This data aids in identifying if particular issues are associated with specific device types.
                                 - **Error Information**: Comprehensive technical data about the error, like the stack trace. This offers a clear understanding of the specific issue within the app's code.
                                 - **Network Information**: Essential details regarding your network connection, aiming to identify if issues might be associated with connectivity.
                                 - **Memory Usage**: Data about memory utilization at the time of the error, to determine if the error might be related to resource constraints.
                                 - **Performance Metrics**: Metrics related to the app's performance, including aspects like speed and responsiveness, to discern if the error was a result of a performance issue.

                                 Your feedback greatly assists in enhancing the application experience for all users. Should you have any privacy or data-related concerns, please don't hesitate to contact our support team.
                                 '''}';
  }
}
