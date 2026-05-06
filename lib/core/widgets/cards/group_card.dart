import 'dart:math' show min;

import 'package:somi/core/models/group.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/degreed_avatar.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget {
  final Group group;

  const GroupCard({super.key, required this.group});

  static const double avatarBorderWidth = 2;

  @override
  Widget build(BuildContext context) {
    // Get displayable member count, which will be limited in non-large formats
    int displayableCount = group.members?.length ?? 0;
    if (!DGCardConfig.of(context).format.isLarge) {
      displayableCount = min(displayableCount, 3);
    }

    // Get other member count
    String? otherMemberCount;
    final countDiff = group.memberCount - displayableCount;
    if (countDiff > 0) otherMemberCount = '+$countDiff';

    return DGCard(
      enforceTextPadding: true,
      title: Text(group.name),
      summary: Text(group.description),
      footer: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: buildAvatarRow(context, displayableCount, otherMemberCount),
      ),
      alwaysShowFooter: true,
      onTap: () => (),
    );
  }

  Row buildAvatarRow(
      BuildContext context, int displayableCount, String? otherMemberCount) {
    return Row(
      children: [
        for (var user in group.members?.take(displayableCount).toList() ?? [])
          buildAvatar(user),
        if (otherMemberCount != null)
          buildOtherMemberCount(context, otherMemberCount)
      ],
    );
  }

  Widget buildAvatar(user) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.75,
      child: DegreedAvatar.user(
        user: user,
        size: 36,
        border: const BorderSide(color: Colors.white, width: avatarBorderWidth),
      ),
    );
  }

  Container buildOtherMemberCount(
      BuildContext context, String otherMemberCount) {
    return Container(
      padding: const EdgeInsets.all(avatarBorderWidth),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        constraints:
            const BoxConstraints(minHeight: 36, maxHeight: 36, minWidth: 36),
        decoration: BoxDecoration(
          color: AppColors.grayDark,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Text(
            otherMemberCount,
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class GroupShimmerCard extends StatelessWidget {
  const GroupShimmerCard({super.key});

  static const memberCount = 4;

  @override
  Widget build(BuildContext context) {
    return DGCard(
      enforceTextPadding: true,
      contentBuilder: (context, child) => DGShimmer(child: child),
      title: ShimmerBlock(width: 120, height: 18),
      summary: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          ShimmerBlock(height: 10),
          const SizedBox(height: 8),
          ShimmerBlock(height: 10),
          const SizedBox(height: 8),
          ShimmerBlock(width: 160, height: 10),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: buildAvatarRow(),
      ),
      alwaysShowFooter: true,
    );
  }

  Row buildAvatarRow() {
    return Row(
      children: [
        for (int i = 0; i < memberCount; i++) buildAvatar(),
      ],
    );
  }

  Widget buildAvatar() {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.75,
      child: ShimmerCircle(36),
    );
  }
}
