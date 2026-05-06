import 'package:flutter/material.dart';

/// An appbar with no contents and no size, useful for mimicking the behavior of SafeArea in
/// an AppBar-less Scaffold without needing to wrap the entire body in SafeArea.
class NoAppBar extends PreferredSize {
  // ignore: use_key_in_widget_constructors
  NoAppBar() : super(preferredSize: const Size(0, 0), child: Container());
}
