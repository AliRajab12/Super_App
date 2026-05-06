import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class DGCardButton extends StatelessWidget {
  final IconData? icon;
  final String? text;
  final DGColorScheme colorTheme;
  final VoidCallback? onPressed;
  final double? iconSize;
  final EdgeInsets? margin;

  const DGCardButton({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.light,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  const DGCardButton.dark({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.dark,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  const DGCardButton.green({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.green,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  const DGCardButton.blue({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.blue,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  const DGCardButton.yellow({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.yellow,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  const DGCardButton.red({
    Key? key,
    this.icon,
    this.text,
    required this.onPressed,
    this.iconSize,
    this.colorTheme = DGColorScheme.red,
    this.margin,
  })  : assert(icon != null || text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? const EdgeInsets.only(right: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: colorTheme.onPrimary,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: colorTheme.primary,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          elevation: 0,
          textStyle: Theme.of(context).textTheme.labelMedium,
          minimumSize: const Size(48, 32),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon!, size: iconSize ?? (text == null ? 18 : 14)),
            if (icon != null && text != null) const SizedBox(width: 5),
            if (text != null) Text(text!),
          ],
        ),
      ),
    );
  }
}

class DGColorScheme {
  final Color primary;
  final Color onPrimary;

  const DGColorScheme({required this.primary, required this.onPrimary});

  static const light = DGColorScheme(
    primary: AppColors.background,
    onPrimary: AppColors.grayDark,
  );

  static const dark = DGColorScheme(
    primary: AppColors.grayDark,
    onPrimary: Colors.white,
  );

  static const appPrimary = DGColorScheme(
    primary: AppColors.primary,
    onPrimary: Colors.white,
  );

  static const blue = DGColorScheme(
    primary: SomiColors.blueLight,
    onPrimary: SomiColors.blueDark,
  );

  static const green = DGColorScheme(
    primary: SomiColors.greenLight,
    onPrimary: SomiColors.greenDark,
  );

  static const yellow = DGColorScheme(
    primary: SomiColors.yellowLight,
    onPrimary: SomiColors.yellow,
  );

  static const red = DGColorScheme(
    primary: SomiColors.redLight,
    onPrimary: SomiColors.red,
  );
}
