import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:somi/presentation/common/widgets/zig_zag_clipper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({
    Key? key,
    required this.onRetry,
    this.inline = false,
    this.inlinePadding,
  }) : super(key: key);

  const NetworkErrorWidget.inline({
    Key? key,
    required this.onRetry,
    this.inline = true,
    this.inlinePadding,
  }) : super(key: key);

  final bool inline;
  final EdgeInsets? inlinePadding;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    if (inline) return buildInline(context);
    return buildFull(context);
  }

  Widget buildFull(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 48),
            child: SizedBox(
              width: 480,
              child: Column(
                children: [
                  Image.asset(
                    'images/illustrations/curious-cats.png',
                    width: 240,
                  ),
                  const SizedBox(height: 36),
                  Text(
                    AppLocalizations.of(context)!.checkInternetConnection,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.communicationError,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 32),
                  PrimaryButton.large(
                    text: AppLocalizations.of(context)!.tryAgain,
                    onPressed: onRetry,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInline(BuildContext context) {
    return Column(
      children: [
        ClipPath(
          clipper: ZigZagClipper(),
          child: Container(
            height: 7,
            color: AppColors.background,
          ),
        ),
        Padding(
          padding: inlinePadding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          // padding:  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: SizedBox(
            child: Row(
              children: [
                const Icon(
                  Icons.warning,
                  size: 16,
                  color: SomiColors.yellow,
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.checkInternetConnection,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(width: 12),
                PrimaryButton.small(
                  text: AppLocalizations.of(context)!.tryAgain,
                  onPressed: onRetry,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
