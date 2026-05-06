import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';


class CompletedAppointmentCard extends StatelessWidget {
  const CompletedAppointmentCard({
    required this.appointment,
    required this.summaryTap,
    required this.checkupTap,
    super.key,
  });

  final AppointmentEntity appointment;
  final void Function() summaryTap;
  final void Function() checkupTap;

  @override
  Widget build(BuildContext context) => CustomContainer(
        width: 398.w,
        height: 162.h,
        color: OnlineClinicColorStyle.white,
        elevationType: ElevationType.noElevation,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              CustomImage(
                imagePngOrJpgPath: appointment.avatar,
                imageHeight: 130.h,
                imageWidth: 100.w,
                borderRadius: 8.r,
              ),
              Gap(16.w),
              _content(context),
            ],
          ),
        ),
      );

  Expanded _content(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              CustomText(
                text: appointment.expertise ?? '',
                textStyle: Theme.of(context).textTheme.labelLarge,
                textFontWight: TextFontWight.regular,
                textColor: OnlineClinicColorStyle.lightGray,
              ),
              Spacer(),
              CustomText(
                text: appointment.appointmentDate != null
                    ? DateFormat('MMM dd, EEE').format(appointment.appointmentDate!)
                    : '-',
                textColor: OnlineClinicColorStyle.lightGray,
                textFontWight: TextFontWight.regular,
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              Gap(17.h)
            ],
          ),
          Gap(8.h),
          CustomText(
            text: '${appointment.firstName} ${appointment.lastName}',
            textColor: OnlineClinicColorStyle.lightGray,
            textFontWight: TextFontWight.bold,
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
          const Spacer(),
          Row(
            children: [
              AppButton.filled(
                label: 'Summary',
                onTap: checkupTap,
                // widthp: 159.h,
                height: 32.h,
                labelColor: OnlineClinicColorStyle.white,
                borderColor: OnlineClinicColorStyle.primary,
                backgroundColor: OnlineClinicColorStyle.primary,
              ),
              Gap(8.w),
              AppButton.filled(
                label: 'Checkup',
                onTap: checkupTap,
                // widthp: 159.h,
                height: 32.h,
hasElevation: false,
                labelColor: OnlineClinicColorStyle.primary,
                borderColor: OnlineClinicColorStyle.primary,
                backgroundColor: Colors.transparent,
              ),
            ],
          ),
          Gap(12.5.h)
        ],
      ),
    );
  }
}
