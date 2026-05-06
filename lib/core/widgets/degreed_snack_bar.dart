import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class DegreedSnackBar extends SnackBar {
  DegreedSnackBar({
    Key? key,
    required String message,
    IconData? icon,
    Color? iconColor,
    SnackBarAction? action,
  }) : super(
          key: key,
          padding: const EdgeInsets.symmetric(horizontal: 18),
          content: _constructContents(message, icon, iconColor, action),
          dismissDirection: DismissDirection.none,
          behavior: SnackBarBehavior.floating,
        );

  factory DegreedSnackBar.info({
    Key? key,
    required String message,
    SnackBarAction? action,
  }) {
    return DegreedSnackBar(
      key: key,
      message: message,
      icon: Icons.info,
      iconColor: Colors.white,
      action: action,
    );
  }

  factory DegreedSnackBar.success({
    Key? key,
    required String message,
    SnackBarAction? action,
  }) {
    return DegreedSnackBar(
      key: key,
      message: message,
      icon: Icons.check_circle,
      iconColor: SomiColors.green,
      action: action,
    );
  }

  factory DegreedSnackBar.warning({
    Key? key,
    required String message,
    SnackBarAction? action,
  }) {
    return DegreedSnackBar(
      key: key,
      message: message,
      icon: Icons.warning,
      iconColor: SomiColors.yellow,
      action: action,
    );
  }

  factory DegreedSnackBar.error({
    Key? key,
    required String message,
    SnackBarAction? action,
  }) {
    return DegreedSnackBar(
      key: key,
      message: message,
      icon: Icons.error,
      iconColor: SomiColors.red,
      action: action,
    );
  }

  static Widget _constructContents(
    String message,
    IconData? icon,
    Color? iconColor,
    SnackBarAction? action,
  ) {
    return Row(
      children: [
        if (icon != null)
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Icon(icon, color: iconColor ?? Colors.white),
          ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        if (action != null)
          PrimaryButton.small(text: action.label, onPressed: action.onPressed),
      ],
    );
  }
}
