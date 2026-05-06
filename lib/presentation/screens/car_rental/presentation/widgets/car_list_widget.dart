import 'package:flutter/material.dart';
import 'package:somi/core/theme/app_images.dart';

import '../../../../../core/models/car_model.dart';
import '../bloc/car_state.dart';
import 'car_card.dart';

class CarListWidget extends StatelessWidget {
  final CarState? state;
  const CarListWidget({super.key, this.state});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        CarCard(
            item: CarModel(
                image: AppImages.somiCar1, name: 'Mercedes-Benz C250')),
        CarCard(
            item: CarModel(
                image: AppImages.somiCar2, name: 'Mercedes-Benz C250')),
        CarCard(
            item: CarModel(
          image: AppImages.somiCar3,
          name: 'Mercedes-Benz C250',
        )),
        CarCard(
            item: CarModel(
                image: AppImages.somiCar4, name: 'Mercedes-Benz C250')),
        CarCard(
            item: CarModel(
                image: AppImages.somiCar5, name: 'Mercedes-Benz C250')),
      ],
    );
  }
}
