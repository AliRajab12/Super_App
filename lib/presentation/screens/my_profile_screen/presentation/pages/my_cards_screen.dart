import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../core/theme/app_images.dart';

@RoutePage()
class MyCardScreen extends StatelessWidget {
  const MyCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My cards',
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImages.card2),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 14),
                child: Image.asset(AppImages.card3),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: InkWell(
                  onTap: () {
                    locator<MainRouter>().navigate(const AddCardScreenRoute());
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    decoration: BoxDecoration(
                        color: SomiColors.greyWhite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(SvgImages.addIcon),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Add new card',
                            style: TextStyle(
                                color: SomiColors.greySecondary,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
