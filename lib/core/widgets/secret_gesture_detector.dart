import 'package:circular_buffer/circular_buffer.dart';
import 'package:collection/collection.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

/// A gesture detector designed to recognize a configurable number of taps for a configurable number of fingers,
/// e.g. a single=finger quadruple tap or a three-finger double-tap, for the purpose of obscuring access to
/// certain parts of the application such as debug menus or the style guide.
class SecretGestureDetector extends StatelessWidget {
  const SecretGestureDetector({
    Key? key,
    required this.child,
    this.requiredFingers = 2,
    this.requiredTaps = 3,
    required this.onGesture,
  }) : super(key: key);

  /// The number of fingers required to register a tap, defaults to 2
  final int requiredFingers;

  /// The number of taps required to trigger the [onGesture] callback, defaults to 3
  final int requiredTaps;

  /// The callback invoked when the required gesture has been detected
  final VoidCallback onGesture;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RawGestureDetector(
      gestures: {
        _SecretGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_SecretGestureRecognizer>(
          () => _SecretGestureRecognizer(
              requiredFingers, requiredTaps, onGesture),
          (_SecretGestureRecognizer instance) {},
        ),
      },
      behavior: HitTestBehavior.translucent,
      child: child,
    );
  }
}

class _SecretGestureRecognizer extends MultiTapGestureRecognizer {
  final VoidCallback onGesture;
  final int fingers;
  final int taps;
  final Duration tapTimeout;

  final Map<int, DateTime> _downPointers = {};
  final Map<int, DateTime> _upPointers = {};
  final List<DateTime> _tapHistory;

  _SecretGestureRecognizer(
    this.fingers,
    this.taps,
    this.onGesture,
  )   : tapTimeout = kDoubleTapTimeout * (taps - 1),
        _tapHistory = taps > 1 ? CircularBuffer(taps) : [] {
    onTapDown = _trackTapDown;
    onTapUp = _trackTapUp;
    onTapCancel = (_) => _reset();
  }

  void _trackTapDown(int pointer, TapDownDetails details) {
    _downPointers[pointer] = DateTime.now();
    if (_downPointers.length > fingers) _reset();
  }

  void _trackTapUp(int pointer, TapUpDetails details) {
    DateTime? downTime = _downPointers.remove(pointer);
    if (downTime == null) return;
    DateTime upTime = DateTime.now();
    if (upTime.difference(downTime) < kLongPressTimeout)
      _upPointers[pointer] = upTime;
    if (_upPointers.length >= fingers) {
      var upTimes = _upPointers.values.toList();
      if (upTimes.min.difference(upTimes.max).abs() < kPressTimeout) {
        _trackTap();
      }
      _upPointers.clear();
      _downPointers.clear();
    }
  }

  void _trackTap() {
    _tapHistory.add(DateTime.now());
    if (_tapHistory.length == taps) {
      if (_tapHistory.first.difference(_tapHistory.last).abs() <= tapTimeout) {
        onGesture.call();
        _reset();
      }
    }
  }

  void _reset() {
    _downPointers.clear();
    _upPointers.clear();
    _tapHistory.clear();
  }
}
