import 'package:auto_route/auto_route.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/animated_indexed_stack.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/presentation/screens/login/reset_password/reset_password_cubit.dart';
import 'package:somi/presentation/screens/login/reset_password/reset_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final cubit = locator<ResetPasswordCubit>();
  final _passwordTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _passwordTextController.addListener(() {
      cubit.updatePassword(_passwordTextController.text);
    });
  }

  @override
  void dispose() {
    _passwordTextController.text = '';
    _passwordTextController.dispose();
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
          bloc: cubit,
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 24, vertical: isPortrait ? 64 : 16),
                      children: [
                        _header(context, state),
                        _passwordField(context, state),
                        _continueButton(context, state),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget _header(BuildContext context, ResetPasswordState state) {
    return Column(
      children: [
        Center(
          child: Hero(
            tag: 'orgLogo',
            child: Image.asset(AppImages.appLogo, width: 48),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          AppLocalizations.of(context)!.resetYourPassword,
          style: const TextStyle(
            fontFamily: 'Antonia',
            color: SomiColors.blue,
            fontSize: 32,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutCubic,
            child: Center(
              child: AnimatedIndexedStack(
                index: state.showError ? 1 : 0,
                children: [
                  Text(
                    state.isResetting
                        ? AppLocalizations.of(context)!.resettingPassword
                        : AppLocalizations.of(context)!.passwordPolicy,
                    key: const Key('instructions'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Text(
                    state.showError
                        ? state.errorMessage ??
                            AppLocalizations.of(context)!.resetPasswordError
                        : '',
                    key: const Key('error message'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, height: 1.5, color: SomiColors.red),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _passwordField(BuildContext context, ResetPasswordState state) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 12, right: 12, bottom: 12),
            child: TextField(
              key: const Key('password field'),
              enabled: !state.isResetting,
              obscureText: !state.showPassword,
              enableSuggestions: false,
              autocorrect: false,
              autofocus: true,
              textInputAction: TextInputAction.go,
              onSubmitted: state.isContinueEnabled
                  ? (text) => handleContinuePressed()
                  : null,
              keyboardType: TextInputType.visiblePassword,
              controller: _passwordTextController,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  key: const Key('obscure password toggle'),
                  icon: Icon(state.showPassword
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: () {
                    cubit.togglePasswordVisibility();
                  },
                ),
                filled: false,
                fillColor: Colors.white,
                labelText: AppLocalizations.of(context)!.password,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context, ResetPasswordState state) {
    return Column(
      children: [
        // Continue button
        const SizedBox(height: 20),
        PrimaryButton.large(
          key: const Key('continue button'),
          text: state.isResetting
              ? null
              : AppLocalizations.of(context)!.continueButtonPhone,
          onPressed: state.isContinueEnabled
              ? handleContinuePressed
              : handleContinuePressed,
          child: state.isResetting
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : null,
        ),
      ],
    );
  }

  Future<void> handleContinuePressed() async {
    cubit.resetPassword();
  }
}
