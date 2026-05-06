import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class MedicalGalleyReportFileInfo extends StatelessWidget {
  const MedicalGalleyReportFileInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CustomText(
              text: 'Medical Report',
              textStyle: Theme.of(context).textTheme.bodyLarge,
              textFontWight: TextFontWight.bold,
            ),
            Gap(
              4.w,
            ),
            CustomImage(
              imageWidth: 20.w,
              imageHeight: 20.h,
              imageSvgPath: 'images/svg/arrow-right.svg',
            ),
            CustomText(
              text: 'CT Scan - Abdomen',
              textStyle: Theme.of(context).textTheme.bodyMedium,
              textFontWight: TextFontWight.bold,
            ),
          ],
        ),
      ],
    );
  }
}