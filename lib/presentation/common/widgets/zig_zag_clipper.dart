import 'package:flutter/material.dart';

class ZigZagClipper extends CustomClipper<Path> {
  // Target distance from peak to peak within the zigzag pattern. Actual distance
  // may be slightly different in order to ensure all edges end at a peak or trough.
  static const int _targetZigZagWidth = 10;

  final bool invert;

  ZigZagClipper({this.invert = false});

  @override
  Path getClip(Size size) {
    int zigZagCount = size.width ~/ _targetZigZagWidth ~/ 2 * 4;
    var zigZagWidth = size.width / zigZagCount;
    var zigZagHeight = zigZagWidth * 0.8;

    var path = Path();
    if (invert) path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Top zigzag
    path.lineTo(0, size.height - zigZagHeight);
    for (int i = 0; i <= zigZagCount + 1; i++) {
      if (i % 2 == 1) {
        path.lineTo(zigZagWidth * i, size.height);
      } else {
        path.lineTo(zigZagWidth * i, size.height - zigZagHeight);
      }
    }

    // Bottom zigzag
    for (int i = zigZagCount + 1; i >= 0; i--) {
      if (i % 2 == 0) {
        path.lineTo(zigZagWidth * i, 0);
      } else {
        path.lineTo(zigZagWidth * i, zigZagHeight);
      }
    }
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}
