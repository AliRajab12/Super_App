import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef AdaptiveAlertDialogBuilder<T> = AdaptiveAlertDialog<T> Function(
    BuildContext context);

Future<T?> showDegreedAdaptiveDialog<T>(
  BuildContext context,
  AdaptiveAlertDialogBuilder builder, {
  T? defaultResult,
}) async {
  T? result = defaultResult;
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    result = await showCupertinoDialog<T>(
        context: context, builder: builder, useRootNavigator: false);
  } else {
    result = await showDialog<T>(
        context: context, builder: builder, useRootNavigator: false);
  }
  return result;
}

class AdaptiveAlertDialog<T> extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<DialogAction<T>> actions;

  const AdaptiveAlertDialog({
    Key? key,
    this.title,
    this.content,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    } else {
      return AlertDialog(
        title: title,
        content: content,
        actions: actions,
      );
    }
  }
}

class DialogAction<T> extends StatelessWidget {
  final bool isDefaultAction;
  final bool autoDismiss;
  final bool isDestructive;
  final VoidCallback? onPressed;
  final String? label;
  final Widget? child;
  final T? result;

  const DialogAction({
    Key? key,
    this.autoDismiss = true,
    this.isDefaultAction = false,
    this.isDestructive = false,
    this.result,
    this.onPressed,
    required this.label,
    this.child,
  })  : assert((child != null) ^ (label != null)),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    onTap() {
      if (autoDismiss) Navigator.pop(context, result);
      if (onPressed != null) onPressed!();
    }

    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoDialogAction(
        isDefaultAction: isDefaultAction,
        isDestructiveAction: isDestructive,
        onPressed: onTap,
        child: child ?? Text(label!),
      );
    } else {
      return TextButton(
        onPressed: onTap,
        child: child ?? Text(label!),
      );
    }
  }
}
