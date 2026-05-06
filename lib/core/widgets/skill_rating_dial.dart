import 'dart:math';

import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class SkillRatingDial extends StatelessWidget {
  static const double smallStrokeWidth = 3;
  static const double smallCircleSize = 48;

  static const double largeStrokeWidth = 4;
  static const double largeCircleSize = 108;

  final int? rating;
  final int maxRating;
  final bool isSmall;
  final bool hideIcon;
  final bool usePlusIcon;
  final VoidCallback? onPressed;

  const SkillRatingDial({
    Key? key,
    required this.onPressed,
    this.rating,
    required this.maxRating,
    this.isSmall = false,
    this.hideIcon = false,
    this.usePlusIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: isSmall ? smallCircleSize : largeCircleSize,
        height: isSmall ? smallCircleSize : largeCircleSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomPaint(
              painter: _DialPainter(
                rating: rating ?? 0,
                maxRating: maxRating,
                isSmall: isSmall,
              ),
            ),
            if (!hideIcon)
              Center(
                child: rating != null
                    ? Text(
                        '$rating',
                        style: isSmall
                            ? Theme.of(context).textTheme.titleSmall
                            : Theme.of(context).textTheme.headlineLarge,
                      )
                    : usePlusIcon
                        ? const Icon(
                            Icons.add,
                            color: AppColors.grayDark,
                            size: 16,
                          )
                        : Image.asset(
                            AppImages.appLogo,
                            width: 24,
                            height: 24,
                            color: AppColors.grayLight,
                          ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DialPainter extends CustomPainter {
  static const double gapAngle = pi / 180 * 8;
  static const double smallStrokeWidth = 3.0;
  static const double largeStrokeWidth = 4.0;

  final int rating;
  final int maxRating;
  final bool isSmall;

  _DialPainter({
    required this.rating,
    required this.maxRating,
    this.isSmall = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paintActive = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSmall ? smallStrokeWidth : largeStrokeWidth;

    final paintInactive = Paint()
      ..color = AppColors.background
      ..style = PaintingStyle.stroke
      ..strokeWidth = isSmall ? smallStrokeWidth : largeStrokeWidth;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);
    final sweepAngle = 2 * pi / maxRating - gapAngle; // Subtract gap angle
    final startAngle = -pi / 2 -
        sweepAngle / 2; // Subtract half sweep angle to center first segment

    for (int i = 0; i < maxRating; i++) {
      final angleOffset = sweepAngle * i + gapAngle * i; // Add gap angle
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle + angleOffset,
        sweepAngle,
        false,
        i < rating ? paintActive : paintInactive,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DialPainter oldDelegate) {
    return rating != oldDelegate.rating ||
        maxRating != oldDelegate.maxRating ||
        isSmall != oldDelegate.isSmall;
  }
}
