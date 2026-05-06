import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';

import '../../../core/main_router.dart';
import '../../../core/service_locator.dart';
import 'custom_rounded_button.dart';

void showPaymentDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          height: 350,
          decoration: BoxDecoration(
              color: SomiColors.background,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 2,
                    offset: const Offset(2, 4),
                    spreadRadius: 2)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Spacer(),
              const Spacer(),
              const Text(
                'Ticket Payment Successful',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const Text(
                'Your payment has been processed!',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
              const SizedBox(
                height: 12,
              ),
              CustomRoundedButton(
                text: 'Back to home',
                width: MediaQuery.of(context).size.width / 2,
                pressed: () {
                  locator<MainRouter>().popUntilRouteWithPath('/home');
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      );
    },
  );
}
