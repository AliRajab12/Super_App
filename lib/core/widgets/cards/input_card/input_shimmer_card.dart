import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:flutter/material.dart';

class InputShimmerCard extends StatelessWidget {
  const InputShimmerCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DGCard(
      contentBuilder: (context, child) => DGShimmer(child: child),
      header: Align(
        alignment: Alignment.topLeft,
        child: ShimmerBlock(height: 24, width: 200),
      ),
      thumbnail: AspectRatio(
        aspectRatio: 16 / 9,
        child: ShimmerBlock(),
      ),
      title: Row(
        children: [
          Flexible(flex: 3, child: ShimmerBlock(height: 24)),
          const Spacer(flex: 1),
        ],
      ),
      buttons: [
        const ShimmerButton.short(),
        if (DGCardConfig.of(context).format.isLarge) const ShimmerButton.long(),
      ],
    );
  }
}
