import 'package:auto_route/auto_route.dart';
import 'package:lottie/lottie.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:somi/core/widgets/dg_network_image.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/presentation/screens/launch/launch_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {
  final cubit = locator<LaunchCubit>();

  @override
  void initState() {
    super.initState();
    cubit.initialize();
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LaunchCubit, LaunchState>(
      bloc: cubit,
      builder: (BuildContext context, LaunchState state) {
        return AnimatedContainer(
          key: const Key('background'),
          duration: const Duration(milliseconds: 300),
          color: state == LaunchState.loading ? Colors.white : Colors.white,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocBuilder<LaunchCubit, LaunchState>(
              bloc: cubit,
              builder: (BuildContext context, LaunchState state) =>
                  _body(context, state),
            ),
          ),
        );
      },
    );
  }

  Widget _body(BuildContext context, LaunchState state) {
    switch (state) {
      case LaunchState.commError:
        return _error(
            context, AppLocalizations.of(context)!.communicationError);
      case LaunchState.unknownError:
        return _error(
            context, AppLocalizations.of(context)!.connectionProblemsString);
      default:
        return _loading(context);
    }
  }

  Widget _loading(BuildContext context) {
    return Center(
      child: MirrorAnimationBuilder<double>(
        builder: (BuildContext context, double value, Widget? child) {
          return Transform.scale(
            scale: value,
            child: Hero(
                tag: 'orgLogo',
                child:
                    Lottie.asset('images/lottie/SuperApp1.json', repeat: false)),
            //_logo(context))
          );
        },
        curve: Curves.easeInSine,
        duration: const Duration(milliseconds: 600),
        tween: Tween<double>(begin: 1, end: 0.9),
      ),
    );
  }

  Widget _logo(BuildContext context) {
    final url = SuperAppTheme.of(context)?.brandLogoUrl;
    return DGNetworkImage(
      height: 128,
      imageUrl: url,
      fadeOutDuration: const Duration(milliseconds: 300),
      errorWidget: (_, __, ___) => _defaultLogo(),
      placeholder: (_, __) => _defaultLogo(),
    );
  }

  Widget _defaultLogo() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Image.asset(AppImages.appLogo, width: 128, height: 128),
    );
  }

  Widget _error(BuildContext context, String message) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 480),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _defaultLogo(),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(),
            ),
            const SizedBox(height: 48),
            PrimaryButton.large(
              text: AppLocalizations.of(context)!.tryAgain,
              onPressed: () {
                setState(() {
                  cubit.initialize();
                });
              },
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () => cubit.logOut(),
              style: TextButton.styleFrom(
                  textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              )),
              child: Text(AppLocalizations.of(context)!.signOut),
            )
          ],
        ),
      ),
    );
  }
}
