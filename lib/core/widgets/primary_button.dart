import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final TextStyle? buttonTextStyle;
  final VoidCallback? onPressed;
  final Icon? icon;
  final ButtonSize size;
  final Widget? child;
  final bool isLoading;
  final bool expand;
  final Color? color;
  final Color? fColor;
  final bool border;
  const PrimaryButton.large({
    super.key,
    this.icon,
    this.text,
    this.buttonTextStyle,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    this.expand = false,
    this.color,
    this.fColor,
    this.border = false,
  })  : size = ButtonSize.large,
        super();

  const PrimaryButton.small({
    super.key,
    this.icon,
    this.text,
    this.buttonTextStyle,
    this.child,
    required this.onPressed,
    this.isLoading = false,
    this.expand = false,
    this.color,
    this.fColor,
    this.border = false,
  })  : size = ButtonSize.small,
        super();

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: isLoading ? null : onPressed,
      style: FilledButton.styleFrom(
        textStyle:
            size.largeText ? null : Theme.of(context).textTheme.labelMedium,
        minimumSize: Size(48, size.height),
      ).copyWith(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return AppColors.primary;
          return color ?? AppColors.primary;
        }),
        side: border
            ? MaterialStateProperty.resolveWith(
                (states) => const BorderSide(color: Colors.black))
            : null,
        foregroundColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) return Colors.white;
          return fColor;
        }),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Visibility(
            visible: !isLoading,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            maintainSemantics: false,
            child: Row(
              mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: buildChildren(context),
            ),
          ),
          if (isLoading)
            SizedBox(
              width: size == ButtonSize.large ? 20 : 12,
              height: size == ButtonSize.large ? 20 : 12,
              child: const CircularProgressIndicator(
                  color: Colors.white, strokeWidth: 2),
            ),
        ],
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context) {
    return [
      if (icon != null) icon!,
      if (icon != null) SizedBox(width: size.largeText ? 9 : 5),
      if (text != null)
        Flexible(
            child: Text(
          text!,
          maxLines: 1,
          style: buttonTextStyle,
        )),
      if (child != null) child!,
    ];
  }
}

enum ButtonSize {
  large(height: 48, largeText: true, expand: true),
  small(height: 28, largeText: false, expand: false);

  final double height;
  final bool largeText;
  final bool expand;

  const ButtonSize(
      {required this.height, required this.largeText, required this.expand});
}
