import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:somi/core/widgets/phoenix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'utils/size_utils.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as screenUtil;

class SuperApp extends StatelessWidget {
  SuperApp({Key? key}) : super(key: key);

  final _mainRouter = locator<MainRouter>();
  final _themeKey = locator<GlobalKey<SuperAppThemeState>>();

  @override
  Widget build(BuildContext context) {
    return screenUtil.ScreenUtilInit(
      designSize: const Size(430, 930 + 33.5),
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      child: Builder(builder: (context) {
        return Sizer(builder: (BuildContext context, Orientation orientation,
            DeviceType deviceType) {
          return Phoenix(
              child: SuperAppTheme(
            key: _themeKey,
            builder: (BuildContext context, ThemeData themeData) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                title: 'SuperApp',
                theme: themeData,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  CountryLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                routerDelegate: _mainRouter.delegate(),
                routeInformationParser: _mainRouter.defaultRouteParser(),
              );
            },
          ));
        });
      }),
    );
  }
}
