import 'package:flutter/material.dart';

/// A decoration that draws a rounded vertical bar of the specified [color] along the left edge
class MarkdownBlockquoteDecoration extends Decoration {
  final Color color;

  const MarkdownBlockquoteDecoration(this.color);

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) =>
      _MarkdownBlockquoteDecorationPainter(color);
}

class _MarkdownBlockquoteDecorationPainter extends BoxPainter {
  final Color color;

  const _MarkdownBlockquoteDecorationPainter(this.color);

  static const double strokeWidth = 4;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    const halfStroke = strokeWidth / 2;
    Paint paint = Paint();
    paint.strokeWidth = strokeWidth;
    paint.color = color;
    paint.strokeCap = StrokeCap.round;

    canvas.drawLine(
      offset + const Offset(halfStroke, halfStroke),
      offset + Offset(halfStroke, configuration.size?.height ?? 0 - halfStroke),
      paint,
    );
  }
}
