import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class TxtButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool small;
  final Widget? trailing;
  final Color? textColor;

  const TxtButton.large({
    Key? key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.small = false,
    this.trailing,
    this.textColor,
  }) : super(key: key);

  const TxtButton.small({
    Key? key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.small = true,
    this.trailing,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor ?? AppColors.grayDark,
        padding: EdgeInsets.symmetric(horizontal: small ? 8 : 12),
        elevation: 0,
        textStyle: small
            ? Theme.of(context).textTheme.labelMedium
            : Theme.of(context).textTheme.bodyMedium,
        minimumSize: Size(48, small ? 28 : 36),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon!, size: 10),
          if (icon != null) const SizedBox(width: 5),
          Text(text),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
