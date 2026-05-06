import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:somi/core/theme/app_images.dart';
import 'package:somi/core/theme/colors.dart';

class SliderCarImages extends StatefulWidget {
  const SliderCarImages({super.key});

  @override
  State<SliderCarImages> createState() => _SliderCarImagesState();
}

class _SliderCarImagesState extends State<SliderCarImages> {
  final controller = PageController(
    viewportFraction: 1,
    keepPage: false,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: PageView.builder(
            controller: controller,
            itemCount: 4,
            allowImplicitScrolling: true,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: Image.asset(index == 0
                    ? AppImages.somiCar1
                    : index == 1
                        ? AppImages.somiCar2
                        : index == 2
                            ? AppImages.somiCar3
                            : AppImages.somiCar4),
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: controller,
          count: 4,
          effect: const ExpandingDotsEffect(
              dotHeight: 6,
              dotWidth: 6,
              spacing: 3,
              dotColor: SomiColors.blue,
              activeDotColor: SomiColors.blue),
        ),
      ],
    );
  }
}
