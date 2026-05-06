import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/colors.dart';

class DGShimmer extends StatelessWidget {
  final Widget child;
  final bool onWhite;

  const DGShimmer({
    super.key,
    required this.child,
    this.onWhite = true,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Shimmer.fromColors(
        baseColor: onWhite
            ? Theme.of(context).colorScheme.surfaceTint
            : SomiColors.ebonySolid13,
        highlightColor: onWhite ? Colors.white : AppColors.background,
        // highlightColor: Colors.white,
        child: child,
      ),
    );
  }
}

class ShimmerBlock extends Container {
  ShimmerBlock({super.key, super.width, super.height})
      : super(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        );
}

class ShimmerBadge extends Container {
  ShimmerBadge({super.key, super.width, super.height})
      : super(
          decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(1000)),
          ),
        );
}

class ShimmerCircle extends Container {
  ShimmerCircle(double radius, {super.key})
      : super(
          width: radius,
          height: radius,
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        );
}

class ShimmerButton extends StatelessWidget {
  const ShimmerButton.icon({super.key, this.placeholder = '-'});

  const ShimmerButton.short({super.key, this.placeholder = '------'});

  const ShimmerButton.medium({super.key, this.placeholder = '----------'});

  const ShimmerButton.long({super.key, this.placeholder = '---------------'});

  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return DGCardButton(onPressed: () {}, text: placeholder);
  }
}
