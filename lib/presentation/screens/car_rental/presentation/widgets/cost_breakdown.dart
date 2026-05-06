import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/promo_code_widget.dart';

class CoastBreakDown extends StatelessWidget {
  const CoastBreakDown({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Coast breakdown',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Rental period',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'AED 80/day',
                  style: TextStyle(
                      fontSize: 11,
                      color: SomiColors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Text(
              '80 AED',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: SomiColors.blue),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Door -to-door delivery',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            Text(
              '80 AED',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: SomiColors.blue),
            )
          ],
        ),
        SizedBox(
          height: 16,
        ),
        PromoCodeWidget(),
        SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  'Incl.VAT',
                  style: TextStyle(
                      fontSize: 11,
                      color: SomiColors.grey,
                      fontWeight: FontWeight.w400),
                )
              ],
            ),
            Text(
              '160 AED',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: SomiColors.blue),
            )
          ],
        ),
      ],
    );
  }
}
