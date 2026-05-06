import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/doctor_list_widet/title_card_doctor_item.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/doctor_entity.dart';


class DoctorItem extends StatelessWidget {
  const DoctorItem(
      {super.key,
      required this.doctorEntity,
      this.onTapCard,
      this.onTapBookButton,
      this.showBookButton = false,
      this.usePadding = true});

  final DoctorEntity doctorEntity;
  final GestureTapCallback? onTapCard;
  final GestureTapCallback? onTapBookButton;
  final bool showBookButton;
  final bool usePadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCard,
      child: CustomContainer(
        width: 398.w,
        height: 112.h,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),

        // color: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.white : OnlineClinicColorStyle.white,
        color: Theme.of(context).brightness == Brightness.light
            ? OnlineClinicColorStyle.white
            : OnlineClinicColorStyle.white,
        elevationType: ElevationType.noElevation,
        margin: EdgeInsets.symmetric(
            vertical: 8.h, horizontal: usePadding ? 16.w : 0),
        padding: EdgeInsets.symmetric(vertical: 19.h, horizontal: 16.w),

        child: Row(
          children: [
            CustomImage(
              borderRadius: 8.r,
              imagePngOrJpgPath: doctorEntity.imagePath,
              imageWidth: 60.r,
              imageHeight: 60.r,
            ),
            Gap(9.w),
            TitleCardDoctorItem(
              doctorEntity: doctorEntity,
            ),
            if (showBookButton)
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: AppButton.filled(
                  label: "Book",
                  onTap: onTapBookButton,
                  backgroundColor:
                      Theme.of(context).brightness == Brightness.light
                          ? OnlineClinicColorStyle.primary
                          : OnlineClinicColorStyle.primary,
                ),
              )
            else
              CustomImage(
                imageSvgPath: 'images/svg/arrow.svg',
                svgColor: Theme.of(context).brightness == Brightness.light
                    ? OnlineClinicColorStyle.primary
                    : OnlineClinicColorStyle.primary,
              )
          ],
        ),
      ),
    );
  }
}
