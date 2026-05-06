import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/svg_images.dart';

class FilterButtonWidget extends StatelessWidget {
  const FilterButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: () {
            locator<MainRouter>().navigate(const CarFilterScreenRoute());
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 90,
              decoration: BoxDecoration(
                  color: SomiColors.blue,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(2, 4))
                  ]),
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(SvgImages.filterIcon),
                    const SizedBox(
                      width: 6,
                    ),
                    const Text(
                      'Filter',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
