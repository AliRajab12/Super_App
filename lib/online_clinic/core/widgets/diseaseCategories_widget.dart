import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/user_home_feature/domain/entity/diseaseCategoryEntity.dart';

class DiseaseCategoriesWidget extends StatelessWidget {
  const DiseaseCategoriesWidget({super.key, required this.diseaseCategoryEntity});

  final DiseaseCategoryEntity diseaseCategoryEntity;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 58.w,
      height: 88.h,
      borderRadius: BorderRadius.all(Radius.circular(8.r)),
      color: OnlineClinicColorStyle.white,
      elevationType: ElevationType.noElevation,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomImage(
            imagePngOrJpgPath: diseaseCategoryEntity.iconPath,
            imageWidth: 50.r,
            imageHeight: 50.r,
          ),
          Gap(4.h),
          CustomText(
              text: diseaseCategoryEntity.title,
              textStyle: Theme.of(context).textTheme.bodySmall,
            textFontWight: TextFontWight.bold,
          )



        ],
      ),
    );
  }
}
