import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class ConditionCard extends StatelessWidget {
  const ConditionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      color: OnlineClinicColorStyle.white,
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      height: 104.h,
      width: 90.w,
      borderRadius: BorderRadius.circular(16.r),
      elevationType: ElevationType.lowElevation,
      child: Column(
        children: [
          Gap(15.h),
          CustomImage(
            imageWidth: 26.w,
            imageHeight: 26.h,
            imagePngOrJpgPath: 'images/svg/heart_rate.png',
          ),
          Gap(8.h),
          CustomText(
            text: 'Blood Pressure',
            textColor: OnlineClinicColorStyle.lightGray,
            textFontWight: TextFontWight.regular,
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          Gap(4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                text: '12 - 8',
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.bold,
                textColor: OnlineClinicColorStyle.dark,
              ),
              Gap(2.w),
              CustomText(
                text: 'bpm',
                textStyle: Theme.of(context).textTheme.labelMedium,
                textFontWight: TextFontWight.bold,
                textColor: OnlineClinicColorStyle.lightGray,
              ),
            ],
          )
        ],
      ),
    );
  }
}
