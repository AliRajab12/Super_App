import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:somi/core/models/feautre_model.dart';
import 'package:somi/core/theme/colors.dart';

class FeatureItemWidget extends StatelessWidget {
  final FeatureModel item;
  const FeatureItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: SomiColors.forestLight1,
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: 6,
        ),
        child: Row(
          children: [
            SvgPicture.asset(item.image!),
            const SizedBox(
              width: 4,
            ),
            Text(
              item.name!,
              style: const TextStyle(color: SomiColors.grey, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
