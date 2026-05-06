// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

/// `Phoenix` is a widget that provides a mechanism to reset the state of the entire application.
///
/// Wrapping the main application with [Phoenix] allows us to trigger a full app rebuild from anywhere. This is
/// useful in cases like the Crash Screen where we allow the user to restart the app in case they are stuck
/// in a non-navigable state.
///
/// To trigger the rebirth of the app, simply call:
/// ```
/// Phoenix.rebirth(context);
/// ```
class Phoenix extends StatefulWidget {
  final Widget child;

  const Phoenix({required this.child});

  static rebirth(BuildContext context) {
    final PhoenixState state = context.findAncestorStateOfType<PhoenixState>()!;
    state.rebirth();
  }

  @override
  State<Phoenix> createState() => PhoenixState();
}

@visibleForTesting
class PhoenixState extends State<Phoenix> {
  Key key = UniqueKey();

  @visibleForTesting
  int rebirthCount = 0;

  void rebirth() {
    setState(() {
      rebirthCount++;
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
