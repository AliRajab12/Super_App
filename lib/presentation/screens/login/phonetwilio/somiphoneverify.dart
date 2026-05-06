import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:somi/core/models/login_response.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/login/login_cubit.dart';
import 'package:somi/presentation/screens/login/phonetwilio/somiphonelogin.dart';
import 'package:somi/presentation/screens/login/phonetwilio/twilio/twilio.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SomiPhoneVerify extends StatefulWidget {
  const SomiPhoneVerify({Key? key, required this.phoneNumber})
      : super(key: key);

  final String phoneNumber;

  @override
  State<SomiPhoneVerify> createState() => _SomiPhoneVerifyState();
}

class _SomiPhoneVerifyState extends State<SomiPhoneVerify> {
  final cubit = locator<LoginCubit>();

  TextEditingController controller = TextEditingController();

  String otp = '';
  int _seconds = 25; // Initial countdown value
  late Timer _timer;
  bool isLoading = false;

  String errorMessage = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        leading: Padding(
          padding:
              const EdgeInsetsDirectional.only(start: 16, top: 16, bottom: 6),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade600)),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.grey.shade600,
                size: 16.v,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.checkPhone,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 24.fSize,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 8,
            ),
            Text.rich(TextSpan(text: 'Enter the OTP sent to ', children: [
              TextSpan(
                text: widget.phoneNumber,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              )
            ])),
            const SizedBox(
              height: 30,
            ),
            Form(
              child: PinCodeTextField(
                appContext: context,
                length: 6,
                cursorColor: Colors.black,
                enableActiveFill: true,
                controller: controller,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderWidth: 1,
                  borderRadius: BorderRadius.circular(8),
                  fieldHeight: 50,
                  fieldWidth: 50,
                  inactiveFillColor: SomiColors.background,
                  inactiveColor: Colors.black.withOpacity(0.5),
                  selectedColor: SomiColors.blue,
                  activeFillColor: SomiColors.background,
                  activeColor: SomiColors.blue,
                  selectedFillColor: SomiColors.background,
                ),
                onCompleted: (v) {
                  debugPrint('Completed');
                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    otp = value;
                  });
                },
              ),
            ),
            _seconds == 0
                ? InkWell(
                    onTap: () {
                      _seconds = 25;
                      _startTimer();
                    },
                    child: const Text.rich(
                        TextSpan(text: 'Code expired ', children: [
                      TextSpan(
                        text: 'Re-send',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: SomiColors.blue),
                      )
                    ])),
                  )
                : Text.rich(TextSpan(text: 'Code expires in ', children: [
                    TextSpan(
                      text: _formatTime(_seconds),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: SomiColors.blue),
                    )
                  ])),
            Center(
                child: Text(errorMessage,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red))),
            const SizedBox(
              height: 30,
            ),
            const Spacer(),
            InkWell(
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  String result = await TwilioVerification.instance
                      .verifyCode('+${widget.phoneNumber}', otp);
                  setState(() {
                    isLoading = false;
                  });
                  //  if (result == 'Successful') {
                  await locator<AuthDataRepo>().storeLoginTokens(
                      LoginResponse(
                          accessToken: 'tesfffassss',
                          refreshToken: 'tudfffffffff'),
                      hostUrl: '');
                  cubit.proceedToSomiHomeScreen();
                  // } else {
                  //    setState(() {
                  //      errorMessage = result;
                  //    });
                  //   }
                },
                child: appButton(isLoading ? 'Verifying...' : 'Submit'))
          ],
        ),
      ),
    );
  }

  String _formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutesStr:$secondsStr';
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          if (_seconds == 0) {
            timer.cancel();
          } else {
            _seconds--;
          }
        });
      },
    );
  }
}
