import 'package:flutter/material.dart';
import 'package:somi/core/theme/svg_images.dart';

import 'facility_item_widget.dart';

class FacilityWidget extends StatelessWidget {
  const FacilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 16, top: 20),
          child: Text(
            'Facilities',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            FacilityItemWidget(
              image: SvgImages.locationIcon,
              title: 'Door-to-Door',
            ),
            FacilityItemWidget(
              image: SvgImages.cancellationIcon,
              title: 'Free Cancellation',
            ),
            FacilityItemWidget(
              image: SvgImages.insuranceIcon,
              title: 'Basic Insurance',
            ),
            FacilityItemWidget(
              image: SvgImages.kmIcon,
              title: '200 km / day',
            ),
            FacilityItemWidget(
              image: SvgImages.supportIcon,
              title: 'Support',
            ),
            FacilityItemWidget(
              image: SvgImages.residenceIcon,
              title: 'Roadside assistance',
            ),
          ],
        )
      ],
    );
  }
}
