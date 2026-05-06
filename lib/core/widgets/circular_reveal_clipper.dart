import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/// A Clipper that clips to a centered circle whose radius is determined by the given [percent] and the
/// largest dimension of the item to be clipped.
///
/// 0.0 = fully clipped (nothing showing), 1.0 = fully revealed (nothing clipped)
class CenterCircleClipper extends CustomClipper<Path> {
  final double percent;

  const CenterCircleClipper({required this.percent});

  @override
  Path getClip(Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final maxRadius = sqrt(pow(size.width / 2, 2) + pow(size.height / 2, 2));
    final radius = lerpDouble(0, maxRadius, percent)!;
    return Path()..addOval(Rect.fromCircle(center: center, radius: radius));
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
