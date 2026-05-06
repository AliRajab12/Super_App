import 'package:auto_route/auto_route.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class LogoutScreen extends StatelessWidget {
  const LogoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 24),
              MirrorAnimationBuilder<double>(
                builder: (BuildContext context, double value, Widget? child) {
                  return Transform.scale(
                    scale: value,
                    child: _logo(context),
                  );
                },
                curve: Curves.easeInSine,
                duration: const Duration(milliseconds: 600),
                tween: Tween<double>(begin: 1, end: 0.9),
              ),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)!.loggingOut,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _logo(BuildContext context) {
  return HeroMode(
    enabled: SuperAppTheme.of(context)?.brandLogoUrl == null,
    child: Hero(
      tag: 'orgLogo',
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(AppImages.appLogo, width: 64, height: 64),
      ),
    ),
  );
}
