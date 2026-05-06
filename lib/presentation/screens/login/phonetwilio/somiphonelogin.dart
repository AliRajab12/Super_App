import 'package:auto_route/auto_route.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/login/login_cubit.dart';
import 'package:somi/presentation/screens/login/phonetwilio/twilio/twilio.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class SomiPhoneLogin extends StatefulWidget {
  const SomiPhoneLogin({Key? key}) : super(key: key);

  @override
  State<SomiPhoneLogin> createState() => _SomiPhoneLoginState();
}

class _SomiPhoneLoginState extends State<SomiPhoneLogin> {
  final cubit = locator<LoginCubit>();

  TextEditingController controller = TextEditingController();

  String number = '';

  String errorMessage = '';

  bool isLoading = false;

  FocusNode focusNode = FocusNode();

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
              AppLocalizations.of(context)!.enterPhoneNumber,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.fSize,
                  color: SomiColors.grey),
            ),
            SizedBox(
              height: 4.v,
            ),
            Text(
              AppLocalizations.of(context)!.enterPhoneNumberDescription,
              style: TextStyle(
                  fontSize: 16.fSize, color: SomiColors.greySecondary),
            ),
            const SizedBox(
              height: 30,
            ),
            IntlPhoneField(
              initialCountryCode: 'AE',
              focusNode: focusNode,
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.enterPhoneNumberHint,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              languageCode: 'en',
              onChanged: (phone) {
                number = phone.completeNumber;
                print(number);
              },
              onCountryChanged: (country) {
                print('Country changed to: ${country.name}');
              },
            ),
            const SizedBox(
              height: 5,
            ),
            Center(
                child: Text(errorMessage,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.red))),
            const Spacer(),
            InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                String result =
                    await TwilioVerification.instance.sendCode('+$number');

                setState(() {
                  isLoading = true;
                });
                cubit.proceedToSomiPhoneVerify(phoneNumber: number);
                if (result == 'Successful') {
                  /*if (!context.mounted) return;
                      QuickNav.push(
                          context,
                          SomiPhoneVerify(
                            phoneNumber: number,
                          ));*/
                  cubit.proceedToSomiPhoneVerify(phoneNumber: number);
                } else {
                  setState(() {
                    errorMessage = result;
                  });
                }
              },
              child: appButton(
                isLoading
                    ? AppLocalizations.of(context)!.sendingCode
                    : AppLocalizations.of(context)!.sendCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget appButton(text) {
  return Container(
    height: 60.v,
    width: double.infinity,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(25.0),
      border:
          Border.all(style: BorderStyle.solid, color: Colors.grey, width: 0.5),
    ),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 20.0, fontWeight: FontWeight.w500, color: Colors.white),
    ),
  );
}
