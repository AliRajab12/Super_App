import 'package:somi/core/models/rating.dart';
import 'package:somi/core/models/tag.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:somi/core/widgets/dg_badge.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:somi/core/widgets/skill_rating_dial.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum SkillCardMode {
  focus,
  addRemove,
}

class SkillCard extends StatelessWidget {
  final Tag skill;
  final bool isSaving;
  final int ratingScale;
  final bool isSelfRatingAllowed;
  final void Function()? onTap;
  final void Function()? onToggleFocus;
  final void Function()? onAddOrRemove;
  final SkillCardMode mode;

  const SkillCard({
    Key? key,
    required this.skill,
    required this.isSaving,
    this.onToggleFocus,
    this.onAddOrRemove,
    this.onTap,
    required this.ratingScale,
    this.isSelfRatingAllowed = false,
    this.mode = SkillCardMode.focus,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? statusText = getStatusText(context, skill.rating);

    return DGCard(
      onTap: onTap,
      body: Expanded(
        child: Column(
          children: [
            const SizedBox(height: 48),
            SkillRatingDial(
              onPressed: () => onAddOrRemove?.call(),
              rating: skill.firstRatingLevel,
              maxRating: ratingScale,
              isSmall: true,
              usePlusIcon: mode == SkillCardMode.focus,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(skill.title ?? '',
                  style: Theme.of(context).textTheme.titleSmall),
            ),
            if (statusText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: DGBadge.light(child: Text(statusText)),
              ),
          ],
        ),
      ),
      buttons: [
        switch (mode) {
          SkillCardMode.focus => DGCardButton(
              onPressed: isSaving ? null : () => onToggleFocus?.call(),
              icon: Icons.star,
              colorTheme: skill.isFocused == true
                  ? DGColorScheme.yellow
                  : DGColorScheme.light,
            ),
          SkillCardMode.addRemove => DGCardButton(
              onPressed: () => onAddOrRemove?.call(),
              icon: skill.isFollowing == true ? Icons.check : null,
              colorTheme: skill.isFollowing == true
                  ? DGColorScheme.dark
                  : DGColorScheme.light,
              text: skill.isFollowing == true
                  ? AppLocalizations.of(context)!.added
                  : AppLocalizations.of(context)!.add,
            ),
        },
      ],
      menuItems: isSaving || mode == SkillCardMode.addRemove
          ? []
          : [
              if (skill.selfRating != null)
                DGCardMenuItem(AppLocalizations.of(context)!.clearRating, () {},
                    isDestructive: true),
              DGCardMenuItem(AppLocalizations.of(context)!.remove,
                  () => onAddOrRemove?.call()),
              DGCardMenuItem(AppLocalizations.of(context)!.share, () {}),
              DGCardMenuItem(AppLocalizations.of(context)!.addToTarget, () {}),
            ],
    );
  }

  String? getStatusText(BuildContext context, Rating? rating) {
    return switch (rating?.type?.toLowerCase()) {
      null => null,
      'evaluation' => AppLocalizations.of(context)!.skillReview,
      'bloc' => AppLocalizations.of(context)!.skillRatingStatusManager,
      'credential' =>
        rating?.dateCompleted == null || rating!.dateCompleted!.isEmpty
            ? AppLocalizations.of(context)!.skillRatingStatusInProgress
            : AppLocalizations.of(context)!.skillRatingStatusCertified,
      _ => AppLocalizations.of(context)!.skillRatingStatusSelf,
    };
  }
}

class SkillShimmerCard extends StatelessWidget {
  const SkillShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DGCard(
      contentBuilder: (context, child) => DGShimmer(child: child),
      body: Expanded(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const SkillRatingDial(
              onPressed: null,
              rating: null,
              hideIcon: true,
              maxRating: 8,
              isSmall: true,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ShimmerBlock(
                height: 4,
                width: 100,
              ),
            ),
          ],
        ),
      ),
      buttons: const [
        ShimmerButton.icon(),
      ],
    );
  }
}
