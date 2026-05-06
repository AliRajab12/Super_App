import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class ItemDisease extends StatelessWidget {
  const ItemDisease({super.key, required this.title, required this.onTapClose});

  final String title;
  final Function() onTapClose;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      elevationType: ElevationType.noElevation,
      color: OnlineClinicColorStyle.white,
      borderRadius: BorderRadius.all(Radius.circular(10.r)),
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      // width: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            text: title,
            textStyle: Theme.of(context).textTheme.bodyMedium,
            textFontWight: TextFontWight.medium,
            textColor: OnlineClinicColorStyle.dark1,
          ),
          Gap(5.w),
          InkWell(
            onTap: onTapClose,
            child: CustomImage(
              imageSvgPath: 'images/svg/close_circle_gray.svg',
              imageHeight: 16.h,
              imageWidth: 16.w,
            ),
          ),
        ],
      ),
    );
  }
}
