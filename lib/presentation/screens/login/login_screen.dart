import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/core/widgets/animated_indexed_stack.dart';
import 'package:somi/core/widgets/primary_button.dart';

import 'package:somi/presentation/screens/login/login_cubit.dart';
import 'package:somi/presentation/screens/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../car_rental/presentation/pages/car_details_screen.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, this.logoutReason}) : super(key: key);

  final String? logoutReason;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final cubit = locator<LoginCubit>();

  @override
  void initState() {
    super.initState();
    if (widget.logoutReason != null) {
      cubit.setLogoutReason(widget.logoutReason!);
    }
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Center(
            child: BlocBuilder<LoginCubit, LoginState>(
              bloc: cubit,
              builder: (context, state) =>
                  buildBody(context, state, isPortrait),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, LoginState state, bool isPortrait) {
    return Container(
      constraints: BoxConstraints(maxWidth: 480.v),
      child: Column(
        children: [
          const Spacer(),
          Center(
            child: Hero(
              tag: 'orgLogo',
              child: SvgPicture.asset(
                SvgImages.whiteAppLogoIcon,
              ),
            ),
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
              color: Theme.of(context).colorScheme.background,
            ),
            child: Padding(
              padding: const EdgeInsetsDirectional.only(
                  start: 16, end: 16, bottom: 32, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24.v, bottom: 8.v),
                    child: Align(
                      alignment: Alignment.center,
                      child: Wrap(
                        alignment: WrapAlignment.end,
                        runSpacing: 8.v,
                        spacing: 8.v,
                        runAlignment: WrapAlignment.end,
                        children: [
                          _continueButtonPhone(context, state),
                          SizedBox(height: 8.v),
                          _continueButtonApple(context, state),
                          SizedBox(height: 8.v),
                          _continueButtonGoogle(context, state)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header(BuildContext context, LoginState state) {
    return Column(
      children: [
        SizedBox(height: 16.v),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CarDetailsScreen()),
            );
          },
          child: Text(
            AppLocalizations.of(context)!.welcomeSomi,
            style: const TextStyle(
              fontFamily: 'Antonia',
              color: SomiColors.blue,
              fontSize: 32,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Center(
              child: AnimatedIndexedStack(
                index: state.showError ? 1 : 0,
                children: [
                  Text(
                    AppLocalizations.of(context)!.enterPhone,
                    key: const Key('instructions'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 8.v),
      ],
    );
  }

  Widget _continueButtonPhone(BuildContext context, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton.large(
        key: const Key('continue button Phone'),
        onPressed: () => continuePressedPhone(state),
        child: state.loading
            ? SizedBox(
                width: 20.h,
                height: 20.v,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : Text(
                AppLocalizations.of(context)!.continueButtonPhone,
                style: TextStyle(fontSize: 20.fSize),
              ),
      ),
    );
  }

  Widget _continueButtonApple(BuildContext context, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton.large(
        border: true,
        color: AppColors.snowWhite,
        fColor: Colors.black,
        key: const Key('continue button Apple'),
        onPressed: () => continuePressedApple(state),
        child: state.loading
            ? SizedBox(
                width: 20.h,
                height: 20.v,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : Row(children: [
                const ImageIcon(AssetImage('images/apple.png')),
                Text(
                  AppLocalizations.of(context)!.continueButtonApple,
                  style: TextStyle(fontSize: 20.fSize),
                )
              ]),
      ),
    );
  }

  Widget _continueButtonGoogle(BuildContext context, LoginState state) {
    return SizedBox(
      width: double.infinity,
      child: PrimaryButton.large(
        key: const Key('continue button Apple'),
        color: AppColors.snowWhite,
        fColor: Colors.black,
        border: true,
        onPressed: () => continuePressedGoogle(state),
        child: state.loading
            ? SizedBox(
                width: 20.h,
                height: 20.v,
                child: const CircularProgressIndicator(color: Colors.white),
              )
            : Row(children: [
                Image.asset('images/google.png'),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  AppLocalizations.of(context)!.continueButtonGoogle,
                  style: TextStyle(fontSize: 20.fSize),
                )
              ]),
      ),
    );
  }

  void continuePressedPhone(LoginState state) {
    cubit.proceedToSomiPhoneLogin();
  }

  void continuePressedApple(LoginState state) {
    //if (!state.canContinue) return;
    if (state.showPasswordField) {
      cubit.nativeLogin();
    } else {
      cubit.checkEmail();
    }
  }

  void continuePressedGoogle(LoginState state) {
    //if (!state.canContinue) return;
    if (state.showPasswordField) {
      cubit.nativeLogin();
    } else {
      cubit.checkEmail();
    }
  }
}
