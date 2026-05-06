import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:flutter/material.dart';

class DGBadge extends StatelessWidget {
  final DGColorScheme colorScheme;
  final Widget child;
  final bool slim;

  const DGBadge({
    super.key,
    required this.colorScheme,
    required this.child,
    this.slim = false,
  });

  const DGBadge.light({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.light,
        super();

  const DGBadge.dark({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.dark,
        super();

  const DGBadge.blue({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.blue,
        super();

  const DGBadge.green({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.green,
        super();

  const DGBadge.yellow({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.yellow,
        super();

  const DGBadge.red({
    super.key,
    required this.child,
    this.slim = false,
  })  : colorScheme = DGColorScheme.red,
        super();

  @override
  Widget build(BuildContext context) {
    TextStyle style = slim
        ? TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: colorScheme.onPrimary,
          )
        : Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: colorScheme.onPrimary);
    return DefaultTextStyle(
      style: style,
      maxLines: 1,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.primary,
          borderRadius: BorderRadius.circular(1000),
        ),
        child: Padding(
          padding: slim
              ? const EdgeInsets.symmetric(horizontal: 6, vertical: 2)
              : const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: child,
        ),
      ),
    );
  }
}
