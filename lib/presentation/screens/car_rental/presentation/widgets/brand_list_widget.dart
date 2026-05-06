import 'package:flutter/material.dart';
import 'package:somi/core/models/car_brand.dart';
import 'package:somi/core/theme/app_images.dart';

import 'brand_card.dart';

class BrandListWidget extends StatelessWidget {
  const BrandListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8),
      child: SizedBox(
        height: 100,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            BrandCard(
                item: CarBrandModel(
                    image: AppImages.toyotaBrand, name: 'Toyota')),
            BrandCard(
                item: CarBrandModel(image: AppImages.fordBrand, name: 'Ford')),
            BrandCard(
                item:
                    CarBrandModel(image: AppImages.teslaBrand, name: 'Tesla')),
          ],
        ),
      ),
    );
  }
}
