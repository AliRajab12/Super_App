import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/models/SuperApp_service.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_event.dart';
import 'package:somi/presentation/common/widgets/service_shape.dart';

class SomiServicesWidget extends StatelessWidget {
  const SomiServicesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeCubit = locator<HomeScreenBloc>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 90 / 120,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8),
        shrinkWrap: true,
        itemCount: services.length,
        itemBuilder: (ctx, i) {
          return InkWell(
            onTap: () {
              homeCubit.add(NavigateToServiceScreen(index: i));
            },
            borderRadius: BorderRadius.circular(10),
            child: Container(
              decoration: BoxDecoration(
                color: kCardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.v,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(60, 65),
                        painter: RPSCustomPainter(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SvgPicture.asset(
                          services[i].imageUrl,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.v),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: FittedBox(
                      child: Text(
                        services[i].name,
                        style: kService,
                        textScaleFactor: 0.75,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
