import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final ButtonSize size;
  final Color? textColor;
  final Color? borderColor;

  const SecondaryButton({
    Key? key,
    this.icon,
    required this.text,
    required this.onPressed,
    this.size = ButtonSize.small,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          width: 1,
          color: onPressed == null
              ? SomiColors.ebonySolid18
              : (borderColor ?? SomiColors.blueLight),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        elevation: 0,
        foregroundColor: textColor,
        textStyle: size.largeText
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.labelMedium,
        minimumSize: Size(48, size.height),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) Icon(icon!, size: 10),
          if (icon != null) const SizedBox(width: 5),
          Flexible(child: Text(text, maxLines: 1)),
        ],
      ),
    );
  }
}
