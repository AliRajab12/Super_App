import 'package:flutter/material.dart';

void navigateTo(BuildContext context, Widget widget) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));

void pop(BuildContext context) => Navigator.pop(context);

void popTo(BuildContext context, Widget widget) {
  Navigator.pop(context);
  Navigator.of(context, rootNavigator: true).pop();
  Navigator.of(context)
      .maybePop((route) => MaterialPageRoute(builder: (_) => widget));
}
