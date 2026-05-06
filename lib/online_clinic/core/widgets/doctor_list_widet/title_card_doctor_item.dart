import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/doctor_entity.dart';


class TitleCardDoctorItem extends StatelessWidget {
  const TitleCardDoctorItem({super.key, required this.doctorEntity});

  final DoctorEntity doctorEntity;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CustomText(
              text: doctorEntity.name,
              textStyle: Theme.of(context).textTheme.titleSmall,
              textFontWight: TextFontWight.bold,
            ),
          ),
          Gap(8.h),
          Row(
            children: [
              CustomText(
                text: doctorEntity.specialist,
                textStyle: Theme.of(context).textTheme.labelLarge,
                textColor: OnlineClinicColorStyle.gray,
              ),
              CustomContainer(
                width: 1.w,
                height: 15.h,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                color: Theme.of(context).brightness == Brightness.light
                    ? OnlineClinicColorStyle.dark
                    : OnlineClinicColorStyle.dark,
              ),
              Expanded(
                child: CustomText(
                  text: doctorEntity.experience,
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  textColor: OnlineClinicColorStyle.gray,
                ),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              CustomImage(
                imageSvgPath: 'images/svg/star.svg',
                imageHeight: 12.r,
                imageWidth: 12.r,
              ),
              Gap(2.w),
              CustomText(
                text: doctorEntity.score,
                textStyle: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          )
        ],
      ),
    );
  }
}
