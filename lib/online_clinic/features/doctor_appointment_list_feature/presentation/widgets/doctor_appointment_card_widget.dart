import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/call_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/doctor_appointment_entity.dart';


class DoctorAppointmentCardWidget extends StatelessWidget {
  const DoctorAppointmentCardWidget({
    required this.appointment,
    required this.makeCallTap,
    required this.checkupTap,
    super.key,
  });

  final DoctorAppointmentEntity appointment;
  final void Function() makeCallTap;
  final void Function() checkupTap;

  @override
  Widget build(BuildContext context) => CustomContainer(
        width: 398.w,
        height: 113.h,
        color: OnlineClinicColorStyle.white,
        elevationType: ElevationType.noElevation,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        child: _body(context),
      );

  Widget _body(BuildContext context) => Row(
    children: [
      _image(),
      // Gap(8.w),
      _content(context),
      Gap(8.w),
      _buttons(context),
    ],
  );

  Widget _image() => Padding(
    padding:  EdgeInsets.only(left: 8.w , top: 16.h , bottom: 16.h , right: 13.5.w ),
    child: CustomImage(
          imagePngOrJpgPath: appointment.avatar,
          imageHeight: 80.h,
          imageWidth: 60.w,
          borderRadius: 8.r,
        ),
  );

  Widget _content(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _fullName(context),
            // Gap(2.h),
            _sickness(context),
            // Gap(4.h),
            _appointmentDate(context),
            // Gap(2.h),
            _hasFieldWorker(context),
          ],
        ),
      );

  Widget _buttons(final BuildContext context) => Row(
        children: [
          if(appointment.appointmentType != AppointmentTypeEnum.completed)
          const CallButton(),
          Gap(8.w),
          _checkupButton(context),
          Gap(8.w),
        ],
      );


  Widget _checkupButton(final BuildContext context) => AppButton.filled(
        label: 'Checkup',
        onTap: checkupTap,
        height: 32.h,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
        labelColor: OnlineClinicColorStyle.primary,
        borderColor: OnlineClinicColorStyle.primary,
        backgroundColor: Colors.transparent,
        hasElevation: false,
      );

  CustomText _sickness(BuildContext context) {
    return CustomText(
      text: '${appointment.sickness}',
      textColor: OnlineClinicColorStyle.lightGray,
      textFontWight: TextFontWight.regular,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  CustomText _fullName(BuildContext context) {
    return CustomText(
      text: '${appointment.firstName} ${appointment.lastName}',
      textColor: OnlineClinicColorStyle.dark,
      textFontWight: TextFontWight.bold,
      textStyle: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget _hasFieldWorker(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: 'Field Worker',
          textColor: OnlineClinicColorStyle.lightGray,
          textFontWight: TextFontWight.regular,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        Gap(4.w),
        CustomImage(
          imageSvgPath: appointment.hasFieldWorker!
              ? 'images/svg/tick-circle.svg'
              : 'images/svg/close-circle.svg',
          imageHeight: 16.h,
          imageWidth: 16.w,
        ),
      ],
    );
  }

  Widget _appointmentDate(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: appointment.appointmentDate != null
              ? DateFormat('MMMM d, yyyy, hh:mm a')
                  .format(appointment.appointmentDate!)
              : '-',
          textColor: OnlineClinicColorStyle.lightGray,
          textFontWight: TextFontWight.regular,
          textStyle: Theme.of(context).textTheme.labelLarge,
        ),
        Gap(2.w),
        CustomImage(
          imageSvgPath:
               'images/svg/timer.svg',
          svgColor: appointment.appointmentPriorityType ==
              AppointmentPriorityTypeEnum.regular ? OnlineClinicColorStyle.dark : Colors.red,
          imageHeight: 20.h,
          imageWidth: 20.w,
        ),
      ],
    );
  }
}
