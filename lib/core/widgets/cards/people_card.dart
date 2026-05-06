import 'package:somi/core/models/user.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:somi/core/widgets/degreed_avatar.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PeopleCard extends StatelessWidget {
  final User user;

  static const smallConstraints =
      BoxConstraints.tightFor(width: 161, height: 222);

  const PeopleCard({super.key, required this.user});

  static const double avatarBorderWidth = 2;

  @override
  Widget build(BuildContext context) {
    bool isFollowing = user.userFollows == true;
    final sizeConstraints =
        DGCardConfig.of(context).format.isSmall ? smallConstraints : null;
    return DGCard(
      onTap: () {},
      sizeConstraints: sizeConstraints,
      body: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DegreedAvatar.user(
              user: user,
              size: 64,
              activeLearner: false,
            ),
            const SizedBox(height: 16),
            Text(user.name ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall),
          ],
        ),
      ),
      buttons: [
        DGCardButton(
          onPressed: () {},
          text: isFollowing
              ? AppLocalizations.of(context)!.following
              : AppLocalizations.of(context)!.follow,
          colorTheme: user.userFollows == true
              ? DGColorScheme.dark
              : DGColorScheme.light,
          icon: isFollowing ? Icons.check : null,
        ),
      ],
    );
  }
}

class PeopleShimmerCard extends StatelessWidget {
  const PeopleShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeConstraints = DGCardConfig.of(context).format.isSmall
        ? PeopleCard.smallConstraints
        : null;
    return DGCard(
      contentBuilder: (context, child) => DGShimmer(child: child),
      sizeConstraints: sizeConstraints,
      body: Flexible(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShimmerCircle(64),
            const SizedBox(height: 16),
            ShimmerBlock(width: 96, height: 14)
          ],
        ),
      ),
      buttons: const [
        ShimmerButton.short(),
      ],
    );
  }
}
