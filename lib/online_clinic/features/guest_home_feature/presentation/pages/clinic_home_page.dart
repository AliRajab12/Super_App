import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/large_app_bar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/content_home_large_appbar.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/widgets/categoryWidget.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/widgets/top_doctor_widget.dart';
import 'package:somi/online_clinic/features/user_home_feature/presentation/widget/diseaseCategoryList.dart';

@RoutePage()
class ClinicHomePage extends StatefulWidget {
  const ClinicHomePage({super.key});
  static const route = '/homeClinic';
  @override
  State<ClinicHomePage> createState() => _ClinicHomePageState();
}

class _ClinicHomePageState extends State<ClinicHomePage> {
  @override
  Widget build(BuildContext context) {
    return  CustomBody(
      // showAppAppbar: true,
     contentLargeAppBar: ContentHomeLargeAppBar(),
      child: SingleChildScrollView(
        child: SizedBox(
          height: 0.9.sh,
          child: Column(
            children: [
              Gap(32.h),
              const TitleWidget(
                title: 'Disease categories',
                subtitle: 'Choose your disease or medical condition ',
              ),
              DiseaseCategoryList(),
              CategoryWidget(),
              TopDoctorWidget(),
            ],
          ),
        ),
      )
    );
  }
}
