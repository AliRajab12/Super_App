import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/animated_indexed_stack.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/presentation/screens/login/forgot_password/forgot_password_cubit.dart';
import 'package:somi/presentation/screens/login/forgot_password/forgot_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key, this.username}) : super(key: key);

  final String? username;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final cubit = locator<ForgotPasswordCubit>();
  final _usernameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.username != null) {
      cubit.updateUsername(widget.username!);
      _usernameTextController.text = widget.username!;
    }
    _usernameTextController.addListener(() {
      cubit.updateUsername(_usernameTextController.text);
    });
  }

  @override
  void dispose() {
    _usernameTextController.dispose();
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
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
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
                      if (!state.submitted) _emailTextField(context, state),
                      _continueButton(context, state),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _header(BuildContext context, ForgotPasswordState state) {
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
          AppLocalizations.of(context)!.forgetYourPassword,
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
                    state.loading
                        ? AppLocalizations.of(context)!.resetRequest
                        : state.submitted
                            ? AppLocalizations.of(context)!
                                .forgotPasswordEmailSent
                            : AppLocalizations.of(context)!
                                .enterEmailPasswordReset,
                    key: const Key('instructions'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  Text(
                    state.showError
                        ? AppLocalizations.of(context)!.communicationError
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

  Widget _emailTextField(BuildContext context, ForgotPasswordState state) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Container(
        constraints: const BoxConstraints(minHeight: 70),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: TextField(
              key: const Key('username field'),
              enabled: !state.loading,
              keyboardType: TextInputType.emailAddress,
              controller: _usernameTextController,
              textInputAction: TextInputAction.go,
              onSubmitted: state.disableContinue
                  ? null
                  : (text) => _handleContinuePressed(),
              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.white,
                labelText: AppLocalizations.of(context)!.userNameHint,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _continueButton(BuildContext context, ForgotPasswordState state) {
    return PrimaryButton.large(
      key: const Key('continue button'),
      text: state.loading
          ? null
          : state.submitted
              ? AppLocalizations.of(context)!.login
              : AppLocalizations.of(context)!.continueButtonPhone,
      onPressed: state.disableContinue ? null : _handleContinuePressed,
      child: state.loading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(color: Colors.white),
            )
          : null,
    );
  }

  Future<void> _handleContinuePressed() async {
    if (cubit.state.submitted) {
      Navigator.of(context).pop();
    } else {
      cubit.submit();
    }
  }
}
