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


class TodaysAppointmentCardWidget extends StatelessWidget {
  const TodaysAppointmentCardWidget({
    required this.appointment,
    required this.makeCallTap,
    required this.checkupTap,
    super.key,
  });

  final AppointmentEntity appointment;
  final void Function() makeCallTap;
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
    child: Row(
      children: [
        Padding(
          padding:  EdgeInsets.all(16.r),
          child: CustomImage(
            imagePngOrJpgPath: appointment.avatar,
            imageHeight: 130.h,
            imageWidth: 100.w,
            borderRadius: 8.r,
          ),
        ),
        _content(context),
      ],
    ),
  );

  Expanded _content(BuildContext context) {
    return Expanded(
      child: Padding(
        padding:  EdgeInsets.only(top: 17.h , bottom: 17.h , right: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomText(
              text: appointment.appointmentDate != null
                  ? DateFormat('MMM dd, EEE').format(appointment.appointmentDate!)
                  : '-',
              textColor: OnlineClinicColorStyle.lightGray,
              textFontWight: TextFontWight.regular,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            Gap(8.h),
            CustomText(
              text: '${appointment.firstName} ${appointment.lastName}',
              textColor: OnlineClinicColorStyle.dark,
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
            Gap(4.h),
            CustomText(
              text: '${appointment.expertise}',
              textColor: OnlineClinicColorStyle.lightGray,
              textFontWight: TextFontWight.regular,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            // const Spacer(),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomText(
                  text: appointment.appointmentDate != null
                      ? DateFormat('hh:mm').format(appointment.appointmentDate!)
                      : '-',
                  textStyle: Theme.of(context).textTheme.bodyMedium ,
                  textFontWight: TextFontWight.bold,

                ),
                CustomText(
                  text: appointment.appointmentDate != null
                      ? '${DateFormat('a').format(appointment.appointmentDate!)}'
                      : ' - ',
                  textStyle: Theme.of(context).textTheme.labelMedium ,
                  textFontWight: TextFontWight.bold,

                ),
          
                const Expanded(child: SizedBox()),
                Row(
                  children: [
                    AppButton.filled(
                      label: 'Checkup',
                      hasElevation: false,
                      onTap: checkupTap,
                      // widthp: 159.h,
                      height: 32.h,
                      labelColor: OnlineClinicColorStyle.primary,
                      borderColor: OnlineClinicColorStyle.primary,
                      backgroundColor: Colors.transparent,
                    ),
                    Gap(8.w),
                    AppButton.filled(
                      label: null,
                      height: 40.h,
                      widthp: 40.w,
                      backgroundColor: OnlineClinicColorStyle.primary,
                      customChild: Padding(
                        padding: EdgeInsets.all(10.r),
                        child: SvgPicture.asset(
                          'images/svg/camera.svg',
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                      onTap: () => makeCallTap.call(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
