import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/constants.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor, forgroundColor;
  final Widget child;
  final double width, height, borderRadius;
  final VoidCallback? onPressed;

  const CustomButton(
      {Key? key,
      this.width = 300,
      this.height = 60,
      this.backgroundColor = AppColors.primary,
      this.forgroundColor = Colors.white,
      required this.child,
      this.borderRadius = 10,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          boxShadow: [kBoxShadow],
          borderRadius: BorderRadius.circular(borderRadius)),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: forgroundColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius)),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
