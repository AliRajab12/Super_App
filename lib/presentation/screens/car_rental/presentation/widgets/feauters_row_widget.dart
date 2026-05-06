import 'package:flutter/material.dart';
import 'package:somi/core/theme/svg_images.dart';
import '../../../../../core/models/feautre_model.dart';
import 'feauter_item_widget.dart';

class FeaturesRowWidget extends StatelessWidget {
  const FeaturesRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FeatureItemWidget(
          item: FeatureModel(name: '8 Seats', image: SvgImages.groupIcon),
        ),
        FeatureItemWidget(
          item: FeatureModel(name: '4000', image: SvgImages.clockIcon),
        ),
        FeatureItemWidget(
          item: FeatureModel(name: 'Automatic', image: SvgImages.engineIcon),
        ),
        FeatureItemWidget(
          item: FeatureModel(name: 'Electric', image: SvgImages.gazolinIcon),
        ),
      ],
    );
  }
}
