import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomText extends StatelessWidget {
  final String text;

  final TextStyle? textStyle;
  final TextFontWight? textFontWight;
  final bool? dollarSign;
  final bool? specialPrice;
  final bool? isShadow;

  final Color? textColor;
  final bool? addSeparator;
  final double? letterSpace;
  final bool? multiLine;

  const CustomText({
    super.key,
    this.addSeparator,
    this.multiLine,
    this.letterSpace,
    required this.text,
    this.isShadow,
    required this.textStyle,
    this.textFontWight = TextFontWight.regular,
    this.dollarSign,
    this.specialPrice,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      (addSeparator ?? false)
          ? (dollarSign ?? false)
          ? "\$${NumberFormat.decimalPattern().format(text.contains(RegExp(r"\d+\.\d+", caseSensitive: false)) ? double.parse(text) : int.parse(text))}"
          : NumberFormat.decimalPattern().format(
          text.contains(RegExp(r"\d+\.\d+", caseSensitive: false))
              ? double.parse(text)
              : int.parse(text))
          : (dollarSign ?? false)
          ? "\$$text"
          : text,
      overflow:
      (multiLine ?? false) ? TextOverflow.fade : TextOverflow.ellipsis,
      // textScaleFactor: 1.0,
      style: textStyle?.copyWith(
        letterSpacing: letterSpace ?? 0,
        decoration: (specialPrice ?? false) ? TextDecoration.lineThrough : null,
        color: textColor ?? textStyle?.color,
        fontWeight: textFontWight == TextFontWight.regular
            ? FontWeight.w400
            : textFontWight == TextFontWight.medium
            ? FontWeight.w500
            : textFontWight == TextFontWight.semiBold
            ? FontWeight.w600
            : textFontWight == TextFontWight.bold
            ? FontWeight.w700
            : FontWeight.w400,
        shadows: (isShadow ?? false)
            ? <Shadow>[
          Shadow(
            offset: const Offset(0, 1),
            blurRadius: 1,
            color: Colors.black.withOpacity(0.25),
          ),
        ]
            : null,
      ),
    );
  }
}

enum TextFontWight { regular, medium, semiBold, bold }
