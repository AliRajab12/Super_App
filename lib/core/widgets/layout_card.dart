import 'package:somi/core/utils/size_utils.dart';
import 'package:flutter/material.dart';

class LayoutCard extends StatelessWidget {
  final Widget child;

  final EdgeInsets? padding;

  const LayoutCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 16.h, vertical: 32.v),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(32.h),
        border: Border.all(
          color: Theme.of(context).colorScheme.surfaceTint,
          width: 1,
        ),
      ),
      child: child,
    );
  }
}
