import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/large_app_bar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/pages/field_worker_profile_page.dart';
import 'package:somi/online_clinic/features/location_feature/presentation/widgets/google_map.dart';

@RoutePage()
class FieldWorkerProfileWithLocationPage extends StatefulWidget {
  const FieldWorkerProfileWithLocationPage({super.key});

  static const String route = '/fieldWorkerProfileWithLocationPage';

  @override
  State<FieldWorkerProfileWithLocationPage> createState() => _FieldWorkerProfileWithLocationPageState();
}

bool isOnline = false;

class _FieldWorkerProfileWithLocationPageState extends State<FieldWorkerProfileWithLocationPage> {
  @override
  Widget build(BuildContext context) {
    // Logger().d(MediaQuery.of(context).viewInsets.bottom);
    return CustomBody(
      child: Column(
        children: [
          LargeAppBar(
            content: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(
                    hasPadding: false,
                    iconBackColor: OnlineClinicColorStyle.white,
                    showActionProfile: false,
                  ),
                  CustomText(
                    text: 'March 13, 2024',
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    textColor: OnlineClinicColorStyle.white,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: 'Welcome Lucas Martin',
                        textStyle: Theme.of(context).textTheme.titleSmall,
                        textColor: OnlineClinicColorStyle.white,
                        textFontWight: TextFontWight.bold,
                      ),
                      const Spacer(),
                      CustomImage(
                        imagePngOrJpgPath: 'images/comment_profile.png',
                        imageHeight: 50.h,
                        imageWidth: 50.w,
                      )
                    ],
                  ),
                  CustomText(
                    text: 'Have a nice day and great work!',
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    textColor: OnlineClinicColorStyle.white,
                  ),
                  Gap(32.h),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isOnline = !isOnline;
                        });
                      },
                      child: CustomContainer(
                        width: 198.h,
                        height: 40.h,
                        borderRadius: BorderRadius.circular(50),
                        color: isOnline ? OnlineClinicColorStyle.primary : OnlineClinicColorStyle.lightColor3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: isOnline ? 'You are online' : 'You are offline',
                              textColor: isOnline ? OnlineClinicColorStyle.white : OnlineClinicColorStyle.gray,
                              textStyle: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Gap(16.w),
                            CustomImage(
                              imageHeight: 20,
                              imageWidth: 20,
                              imageSvgPath:
                                  isOnline ? 'images/svg/toggle_on_circle.svg' : 'images/svg/toggle_off_circle.svg',
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMapWidget(
                  onViewAppointmentsTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                      return const FieldWorkerProfilePage();
                    }));
                  },
                ),
                if (isOnline)
                  Positioned(
                    bottom: 24.h,
                    right: 64.w,
                    left: 64.w,
                    child: CustomContainer(
                      height: 40,
                      borderRadius: BorderRadius.circular(50),
                      color: OnlineClinicColorStyle.dark,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            text: 'View appointments in a list',
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                            textFontWight: TextFontWight.medium,
                            textColor: OnlineClinicColorStyle.white,
                          ),
                          const Gap(16),
                          const CustomImage(
                            imageSvgPath: 'images/svg/arrow_right.svg',
                          )
                        ],
                      ),
                    ),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
