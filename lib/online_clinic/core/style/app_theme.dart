import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "online_clinic_color_style.dart";

class AppStyle {

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Poppins',
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      displaySmall: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      displayMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      titleLarge: TextStyle(
        fontSize: 26.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      titleMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      titleSmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      headlineLarge: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      headlineMedium: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      headlineSmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      labelMedium: TextStyle(
        fontSize: 8.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
      labelSmall: TextStyle(
        fontSize: 6.sp,
        fontWeight: FontWeight.w400,
        color: OnlineClinicColorStyle.dark,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.grey[400],
      ),
      iconTheme: IconThemeData(
        color: Colors.grey[500],
      ),
    ),

    ///############################ textField theme #########################################

    iconTheme: IconThemeData(
      color: Colors.grey[500],
    ),
    textTheme: const TextTheme(),
  );
}
