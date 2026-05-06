import 'package:flutter/material.dart';

class QuickNav {
  static Future<T?> push<T extends Object>(
      BuildContext context, Widget widget) {
    return Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
  }
}
