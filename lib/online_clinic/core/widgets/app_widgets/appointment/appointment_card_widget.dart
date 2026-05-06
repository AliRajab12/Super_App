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

class AppointmentCardWidget extends StatelessWidget {
  const AppointmentCardWidget({
    required this.appointment,
    required this.onButtonTap,
    super.key,
  });

  final AppointmentEntity appointment;
  final void Function() onButtonTap;

  @override
  Widget build(BuildContext context) => CustomContainer(
        width: 398.w,
        height: 173.h,
        color: OnlineClinicColorStyle.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5.5.h),
                child: CustomImage(
                  imagePngOrJpgPath: appointment.avatar,
                  imageHeight: 130.h,
                  imageWidth: 80.w,
                  borderRadius: 8.r,
                ),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          CustomText(
            text: appointment.appointmentDate != null
                ? DateFormat('MMM dd, EEE').format(appointment.appointmentDate!)
                : '-',
            textColor: OnlineClinicColorStyle.lightGray,
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          CustomText(
            text: '${appointment.firstName} ${appointment.lastName}',
            textColor: OnlineClinicColorStyle.dark,
            textFontWight: TextFontWight.bold,
            textStyle: Theme.of(context).textTheme.titleSmall,
          ),
          CustomText(
            text: '${appointment.expertise}',
            textColor: OnlineClinicColorStyle.lightGray,
            textStyle: Theme.of(context).textTheme.labelMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: appointment.appointmentDate != null
                          ? DateFormat('hh:mm')
                              .format(appointment.appointmentDate!)
                          : '-',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: appointment.appointmentDate != null
                          ? ' ${DateFormat('a').format(appointment.appointmentDate!)}'
                          : ' - ',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              AppButton.filled(
                label: null,
                height: 48.h,
                widthp: 48.w,
                backgroundColor: OnlineClinicColorStyle.primary,
                customChild: Padding(
                  padding: EdgeInsets.all(14.r),
                  child: SvgPicture.asset(
                    'images/svg/camera.svg',
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                onTap: () => onButtonTap.call(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
