import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_state.dart';

class HomeBannerCard extends StatelessWidget {
  const HomeBannerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        bloc: locator(),
        builder: (context, state) {
          if (state.orgAnnouncloading) {
            return Shimmer.fromColors(
              baseColor: AppColors.primary.withOpacity(0.03),
              highlightColor: AppColors.background,
              child: Container(
                color: Colors.grey,
                width: MediaQuery.sizeOf(context).width,
                height: 150,
              ),
            );
          } else {
            return SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 165,
                child: Image.asset(
                  state.orgAnnouncement?.imageUrl ?? 'images/banner.png',
                  fit: BoxFit.fill,
                ));
          }
        });
  }
}
