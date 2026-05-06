import 'package:flutter/cupertino.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/specification_item_widget.dart';

class SpecificationWidget extends StatelessWidget {
  const SpecificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsetsDirectional.only(start: 16, top: 24),
          child: Text(
            'Specification',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8),
          child: SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SpecificationItemWidget(
                  title: '8 seats',
                  imageUrl: SvgImages.groupWhiteIcon,
                ),
                SpecificationItemWidget(
                  title: 'Include Driver',
                  imageUrl: SvgImages.vehicleIcon,
                ),
                SpecificationItemWidget(
                  title: 'Air condition',
                  imageUrl: SvgImages.airConditionIcon,
                ),
                SpecificationItemWidget(
                  title: 'Automatic',
                  imageUrl: SvgImages.whiteEngineIcon,
                ),
                SpecificationItemWidget(
                  title: '1.5 km',
                  imageUrl: SvgImages.settingIcon,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
