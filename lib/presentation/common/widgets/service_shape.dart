import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(29.5106, 0.646837);
    path_0.cubicTo(35.2744, 2.17602, 37.4215, 9.05545, 42.1811, 12.6481);
    path_0.cubicTo(46.7986, 16.1334, 54.2529, 16.0226, 56.7772, 21.2281);
    path_0.cubicTo(59.3339, 26.5004, 56.3778, 32.6563, 54.5896, 38.2362);
    path_0.cubicTo(52.7938, 43.8398, 50.9063, 49.5625, 46.4611, 53.418);
    path_0.cubicTo(41.7685, 57.4882, 35.719, 60.1964, 29.5106, 59.9888);
    path_0.cubicTo(23.4048, 59.7847, 17.8203, 56.4903, 13.3638, 52.3116);
    path_0.cubicTo(9.28416, 48.4863, 7.97895, 42.9449, 5.82804, 37.7825);
    path_0.cubicTo(3.44144, 32.0544, -0.783724, 26.6784, 0.126303, 20.54);
    path_0.cubicTo(1.09899, 13.979, 5.29659, 8.03796, 10.789, 4.31958);
    path_0.cubicTo(16.1873, 0.664956, 23.2095, -1.02485, 29.5106, 0.646837);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = const Color(0xff00CDBC).withOpacity(0.5);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
