import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/short_long_term_widget.dart';
import 'from_until_widget.dart';

class RentalDateWidget extends StatelessWidget {
  const RentalDateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(2, 4))
            ]),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topStart: Radius.circular(10)),
                        color: SomiColors.blue),
                    child: const ShortLongTermWidget(
                      selected: true,
                      isShort: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                            topEnd: Radius.circular(10)),
                        color: Colors.white),
                    child: const ShortLongTermWidget(
                      selected: false,
                      isShort: false,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 0.5,
              width: MediaQuery.of(context).size.width,
              color: SomiColors.greyLight,
            ),
            const FromUntilWidget()
          ],
        ),
      ),
    );
  }
}
