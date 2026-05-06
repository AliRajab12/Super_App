import 'package:flutter/material.dart';
import 'package:somi/core/models/car_model.dart';
import 'package:somi/core/theme/colors.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../common/widgets/custom_rounded_button.dart';
import 'feauters_row_widget.dart';

class CarCard extends StatelessWidget {
  final CarModel item;
  const CarCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              offset: const Offset(2, 4),
              blurRadius: 3,
              spreadRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: SomiColors.forestLight1,
                    borderRadius: BorderRadius.circular(1)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(item.image!),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                item.name!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const Text(
                '230 AED/day',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: SomiColors.blue,
                ),
              ),
              const SizedBox(height: 20),
              const FeaturesRowWidget(),
              const SizedBox(
                height: 20,
              ),
              CustomRoundedButton(
                text: 'Book Now',
                pressed: () {
                  locator<MainRouter>().navigate(CarDetailsScreenRoute());
                },
              ),
              const SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
