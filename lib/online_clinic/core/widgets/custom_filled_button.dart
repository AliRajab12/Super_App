import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ButtonType {
  text,
  filled,
  outLine,
  elevated,
}

enum ButtonState {
  primary,
  secondary,
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onTap,
    this.label,
    this.iconSize = 18,
    this.buttonType = ButtonType.filled,
    this.buttonState = ButtonState.primary,
    this.backgroundColor,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.radius,
    super.key,
  });

  final void Function() onTap;
  final double iconSize;
  final ButtonType buttonType;
  final ButtonState buttonState;
  final String? label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final double? radius;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 50)),
        onTap: () => onTap.call(),
        child: getButtonWidget(
          context: context,
          type: buttonType,
        ),
      );

  Widget getButtonWidget({
    required BuildContext context,
    required ButtonType type,
  }) {
    switch (type) {
      case ButtonType.filled:
        return _filledButton(context);
      case ButtonType.text:
        return Text('data');
      default:
        return _filledButton(context);
    }
  }

  Widget _filledButton(final BuildContext context) => Container(
        padding: padding ??
            EdgeInsets.symmetric(
              vertical: 7.h,
              horizontal: 24.w,
            ),
        decoration: _decoration(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (prefixIcon != null)
              Icon(
                prefixIcon,
                size: iconSize,
              ),
            if (label != null)
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: prefixIcon != null ? 4 : 0,
                    right: suffixIcon != null ? 4 : 0,
                  ),
                  child: Text(
                    label!,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            if (suffixIcon != null)
              Icon(
                suffixIcon,
                size: iconSize,
              ),
          ],
        ),
      );

  Color getColor({
    required BuildContext context,
    required ButtonState state,
  }) {
    switch (state) {
      case ButtonState.primary:
        return Theme.of(context).primaryColor;
      case ButtonState.secondary:
        return Theme.of(context).secondaryHeaderColor;
      default:
        return Theme.of(context).primaryColor;
    }
  }

  BoxDecoration _decoration(BuildContext context) => BoxDecoration(
        color: getColor(context: context, state: buttonState),
        borderRadius: BorderRadius.all(Radius.circular(radius ?? 50.r)),
      );
}
