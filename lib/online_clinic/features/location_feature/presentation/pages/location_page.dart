import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/location_feature/presentation/widgets/google_map.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_bloc.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapBloc>(
      create: (context) => MapBloc(),
      child: Builder(builder: (context) {
        return Column(
          children: [
            Gap(16.h),
            const TitleWidget(
              title: 'Patient Location',
              subtitle: ' ',
              action: SizedBox.shrink(),
            ),
            Gap(16.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.r),
                  ),
                  child: const GoogleMapWidget(),
                ),
              ),
            ),
            Gap(16.h),
          ],
        );
      }),
    );
  }
}
