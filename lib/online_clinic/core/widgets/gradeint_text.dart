import 'package:flutter/material.dart';

import 'custom_text.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    super.key,
    this.addSeparator,
    required this.text,
    required this.gradient,
    this.specialPrice,
    this.dollarSign,
    this.textFontWight,
    this.textStyle,
  });

  final String text;

  final TextStyle? textStyle;
  final TextFontWight? textFontWight;
  final bool? dollarSign;
  final bool? specialPrice;
  final Gradient gradient;
  final bool? addSeparator;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        blendMode: BlendMode.srcIn,
        shaderCallback: (bounds) => gradient.createShader(
              Rect.fromLTWH(0, 0, bounds.width, bounds.height),
            ),
        child: CustomText(
          text: text,
          textStyle: textStyle,
          textFontWight: textFontWight,
          dollarSign: dollarSign,
          specialPrice: specialPrice,
          addSeparator: addSeparator,
        ));
  }
}
