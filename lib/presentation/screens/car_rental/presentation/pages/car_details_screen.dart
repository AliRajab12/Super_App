import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_rounded_button.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../somidashboard/data/car.dart';
import '../widgets/details_date_widget.dart';
import '../widgets/facility_widget.dart';
import '../widgets/slider_images_car.dart';
import '../widgets/specifications_widget.dart';

@RoutePage()
class CarDetailsScreen extends StatelessWidget {
  final Car? car;
  const CarDetailsScreen({super.key, this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SomiColors.background,
      appBar: CustomAppBar(
        title: 'Car Details',
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DetailsDateWidget(),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mercedes Benz C250',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          '2019',
                          style: TextStyle(
                              fontSize: 14, color: SomiColors.greyLight),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(top: 4),
                    child: Container(
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: SomiColors.blue),
                      child: Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 4, horizontal: 8),
                        child: Row(
                          children: [
                            SvgPicture.asset(SvgImages.starIcon),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              '4.8',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SliderCarImages(),
            const Padding(
              padding: EdgeInsetsDirectional.only(start: 16, top: 20),
              child: Row(
                children: [
                  Text(
                    '230 AED/',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: SomiColors.blue),
                  ),
                  Text(
                    'day',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: SomiColors.blue),
                  ),
                ],
              ),
            ),
            const SpecificationWidget(),
            const FacilityWidget(),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsetsDirectional.only(start: 16, end: 16, bottom: 4),
        child: CustomRoundedButton(
          text: 'Book Now',
          pressed: () {
            locator<MainRouter>().navigate(CarBookScreenRoute());
          },
        ),
      ),
    );
  }
}
