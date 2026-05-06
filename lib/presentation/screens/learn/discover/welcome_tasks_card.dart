import 'package:somi/core/models/high_level_counts.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeTasksCard extends StatelessWidget {
  final HighLevelCounts counts;
  final VoidCallback onOpenTasks;

  const WelcomeTasksCard({
    Key? key,
    required this.counts,
    required this.onOpenTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DGCardConfig config = DGCardConfig.of(context);
    return Padding(
      padding: config.margin ?? config.format.margin,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                '',
                // context.intl
                //     .userWelcome(locator<UserRepo>().user?.firstName ?? ''),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat('EEE, d MMM').format(DateTime.now()),
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
              if (counts.hasRecommended)
                Text(
                  getTaskCount(context, counts.recommendedLearningTotal,
                      counts.recommendedLearningOverdue),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              if (counts.hasRecommended)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: PrimaryButton.large(
                    onPressed: onOpenTasks,
                    expand: true,
                    child: Text(AppLocalizations.of(context)!.openAssignments),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String getTaskCount(BuildContext context, int total, int overdue) {
    String totalCount =
        AppLocalizations.of(context)!.assignmentCount + total.toString();
    if (overdue == 0) return totalCount;
    return '$totalCount (${AppLocalizations.of(context)!.overdueAssignmentCount + overdue.toString()})';
  }

  Widget buildSection(
    BuildContext context, {
    Key? key,
    required String title,
    required int count,
    required VoidCallback? onTap,
    DGColorScheme? badgeColor,
  }) {
    return ListTile(
      key: key,
      onTap: onTap,
      title: Text(title, style: Theme.of(context).textTheme.labelMedium),
      contentPadding: EdgeInsets.zero,
      dense: true,
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: badgeColor == null
                ? null
                : BoxDecoration(
                    color: badgeColor.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
            padding: badgeColor == null
                ? EdgeInsets.zero
                : const EdgeInsets.only(left: 16, top: 3, right: 16, bottom: 3),
            child: Text(
              count.toString(),
              style: TextStyle(
                color: badgeColor?.onPrimary ?? SomiColors.blue,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.navigate_next, size: 18),
          ),
        ],
      ),
    );
  }
}
