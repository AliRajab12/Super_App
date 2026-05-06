import 'package:flutter/material.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/colors.dart';

class CarInfoWidget extends StatelessWidget {
  const CarInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 120,
          height: 80,
          decoration: BoxDecoration(
              color: SomiColors.forestLight.withOpacity(0.4),
              borderRadius: BorderRadius.circular(2)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppImages.somiCar4),
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 170,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Mercedes- Benz 250',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            const Text(
              '2019 Automatic',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: SomiColors.greySecondary),
            )
          ],
        )
      ],
    );
  }
}
