import 'package:flutter/material.dart';
import 'package:somi/core/theme/svg_images.dart';

import 'payment_way_card.dart';

class PaymentMethodsCard extends StatelessWidget {
  const PaymentMethodsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PaymentWayCard(
          text: 'Debit / Credit Card',
          imagePath: SvgImages.creditCardIcon,
          index: 0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),
        PaymentWayCard(
          text: 'Paypal',
          imagePath: SvgImages.paypalIcon,
          index: 1,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Divider(
            color: Colors.grey.shade300,
          ),
        ),
        PaymentWayCard(
            text: 'Apple Pay', imagePath: SvgImages.applePayIcon, index: 2),
      ],
    );
  }
}
