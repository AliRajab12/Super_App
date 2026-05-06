import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/core/theme/colors.dart';

class SuperAppTheme extends StatefulWidget {
  final Widget Function(BuildContext context, ThemeData themeData) builder;

  const SuperAppTheme({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  SuperAppThemeState createState() => SuperAppThemeState();

  static SuperAppThemeState? of(BuildContext context) {
    return context.findAncestorStateOfType<SuperAppThemeState>();
  }
}

class SuperAppThemeState extends State<SuperAppTheme> {
  ThemeData get defaultTheme => _buildTheme();

  Color brandColor = Colors.white;
  bool brandUseLightText = false;
  String? brandLogoUrl;

  @override
  void initState() {
    super.initState();
    refreshBrandColors(updateState: false);
  }

  void refreshBrandColors({bool updateState = true}) {
    OrgSettings? orgSettings;
    if (locator.isRegistered<UserRepo>()) {
      orgSettings = locator<UserRepo>().orgSettings;
    }

    // Brand color
    String? colorString = orgSettings?.branding?.BrandColor;
    if (colorString != null) {
      brandColor = Color(int.parse(colorString.replaceAll('#', '0xFF')));
    } else {
      brandColor = Colors.white;
    }

    // Text brightness
    brandUseLightText = orgSettings?.branding?.UseLightText ?? false;

    // Logo Url
    brandLogoUrl = orgSettings?.Logo;

    if (updateState) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: widget.builder(context, defaultTheme),
    );
  }

  ThemeData _buildTheme() {
    return ThemeData(
      fontFamily: 'Univers',
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        primaryContainer: Color(0xFFD9E2FF),
        onPrimary: Colors.white,
        onPrimaryContainer: Color(0xFF001945),
        secondary: AppColors.secondary, //Color(0xFF575E71),
        secondaryContainer: Color(0xFFDCE2F9),
        onSecondary: Colors.white,
        error: Color(0xFFBA1A1A),
        onError: Colors.white,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        background: AppColors.background, // Color(0xFFF3F7FF),
        onBackground: Colors.black,
        onSurface: Color(0xFF1B1B1F),
        onSurfaceVariant: Color(0xFF44464F),
        surface: Color(0xFFFBF8FD),
        surfaceTint: Color(0xFFEFEDF1),
        tertiary: Color(0xFF725572),
        onTertiary: Colors.white,
      ),
      navigationBarTheme: NavigationBarThemeData(
        iconTheme: MaterialStateProperty.resolveWith<IconThemeData>(
          // Return black icon regardless of state
          (Set<MaterialState> states) =>
              const IconThemeData(color: Colors.black),
        ),
      ),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
      cardTheme: const CardTheme(
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFF3F7FF)),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return Colors.grey;
            }
            return Colors.black;
          }),
          visualDensity: VisualDensity.compact,
        ),
      ),
      // fontFamily: 'Poppins',
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
  }
}
