import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class LabResultCard extends StatelessWidget {
  const LabResultCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: CustomContainer(
        height: 66.h,
        width: 254.w,
        elevationType: ElevationType.lowElevation,
        color: OnlineClinicColorStyle.white,
        padding: EdgeInsets.only(top: 8.h, bottom: 8.h, left: 16.w, right: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.w),
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Center(
              child: CustomImage(
                imageWidth: 50.w,
                imageHeight: 50.h,
                imageSvgPath: 'images/svg/box.svg',
              ),
            ),
            Gap(8.w),
            CustomText(
              text: 'CT Scan - Abdomen',
              textColor: OnlineClinicColorStyle.dark,
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
