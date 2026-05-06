import 'package:flutter/material.dart';

class OnlineClinicColorStyle {

  static const Color backgroundColor = Color(0xffF3F7FF);
  static const Color backgroundColorDark = Color(0xffF3F7FF);

  static const Color primary = Color(0xff00CDBC);
  static const Color primaryDark1 = Color(0xff00A49A);
  static const Color primaryLight1 = Color(0xffC6FFF6);
  static const Color primaryLight2 = Color(0xff8EFFEE);
  static const Color primaryLight3 = Color(0xff4DFBE5);
  static const Color primaryLight4 = Color(0xff19E8D4);

  static const Color secondaryDark1 = Color(0xff003434);
  static const Color secondary = Color(0xff0C5552);
  static const Color secondaryLight1 = Color(0xff02837C);
  static const Color secondaryLight2 = Color(0xff086764);

  static const Color dark = Color(0xff272D36);
  static const Color dark1 = Color(0xff394553);
  static const Color dark2 = Color(0xff333C47);

  static const Color lightGray = Color(0xffA5A9BB);
  static const Color lightGray5 = Color(0xffB3B7C6);
  static const Color lightGray4 = Color(0xffC9CED8);

  static const Color lightColor3 = Color(0xffDEE1E7);
  static const Color lightColor2 = Color(0xffEDEFF2);
  static const Color lightColor1 = Color(0xffF5F6F8);

  static const Color gray = Color(0xff646F81);
  static const Color gray2 = Color(0xff8A94A6);
  static const Color gray1 = Color(0xffB3BAC6);

  static const Color white = Color(0xffFEFEFE);
  static const Color yellowRating = Color(0xffFFD600);

  static BoxShadow noneBoxShadow = BoxShadow(
    color: const Color(0xff787878).withOpacity(0.2),
    blurRadius: 8,
    spreadRadius: 2,
    offset: const Offset(0, 4),
  );
  static BoxShadow lowBoxShadow = BoxShadow(
    color: const Color(0xff121214).withOpacity(0.2),
    blurRadius: 12,
    spreadRadius: 2,
    offset: const Offset(0, 3),
  );
  static BoxShadow mediumBoxShadow = BoxShadow(
    color: const Color(0xff121214).withOpacity(0.2),
    blurRadius: 12,
    spreadRadius: 2,
    offset: const Offset(0, 5),
  );
  static BoxShadow highBoxShadow = BoxShadow(
    color: const Color(0xff121214).withOpacity(0.2),
    blurRadius: 12,
    spreadRadius: 2,
    offset: const Offset(0, 6),
  );

  static const Gradient gradient = LinearGradient(colors: [
    lightGray,
    lightColor1,
  ]);
  static const Gradient gradientDark = LinearGradient(colors: [
    dark2,
    gray,
  ]);
}
