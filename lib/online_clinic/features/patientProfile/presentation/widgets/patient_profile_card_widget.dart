import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/patient_profile_appointment_entity.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/visit_status_enum.dart';

import '../../../../core/widgets/app_widgets/custom_image/custom_image.dart';
import '../../../../core/widgets/custom_container.dart';
import '../../../../core/widgets/custom_text.dart';

class PatientProfileAppointmentCardWidget extends StatelessWidget {
  const PatientProfileAppointmentCardWidget({
    required this.appointment,
    required this.makeCallTap,
    required this.checkupTap,
    super.key,
  });

  final PatientProfileAppointmentEntity appointment;
  final void Function() makeCallTap;
  final void Function() checkupTap;

  @override
  Widget build(BuildContext context) => CustomContainer(
        width: 398.w,
        height: 76.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
          Gap(16.w),
          _content(context),
        ],
      );

  Widget _image() => CustomImage(
        imagePngOrJpgPath: appointment.avatar,
        imageHeight: 60.h,
        imageWidth: 60.w,
        borderRadius: 8.r,
        //TODO: Fit needs checking
        boxFit: BoxFit.fill,
      );

  Widget _content(BuildContext context) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _visitedBy(context),
            Gap(8.h),
            _appointmentDate(context),
          ],
        ),
      );

  Widget _visitedBy(BuildContext context) {
    return Row(
      children: [
        const CustomText(
          text: 'Visited by: ',
          textColor: Color(0xFFA5A9BB),
          textFontWight: TextFontWight.regular,
          textStyle: TextStyle(fontSize: 10),
        ),
        CustomText(
          text: '${appointment.firstName} ${appointment.lastName}',
          textColor: const Color(0xFF272D36),
          textFontWight: TextFontWight.bold,
          textStyle: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _appointmentDate(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(
          imageSvgPath: 'images/svg/timer.svg',
          imageHeight: 20.h,
          imageWidth: 20.w,
          svgColor: OnlineClinicColorStyle.dark,
        ),
        Gap(2.5.w),
        _date(context),
        Gap(16.w),
        _sickness(context),
        Gap(2.w),
        const Spacer(),
        _visitStatus(context),
      ],
    );
  }

  CustomText _date(BuildContext context) {
    return CustomText(
      text: appointment.appointmentDate != null
          ? DateFormat('MMM d, hh:mm a').format(
              appointment.appointmentDate!,
            )
          : '-',
      textColor: OnlineClinicColorStyle.lightGray,
      textFontWight: TextFontWight.regular,
      textStyle: Theme.of(context).textTheme.labelLarge,
    );
  }

  CustomText _sickness(BuildContext context) {
    return CustomText(
      text: '${appointment.sickness}',
      textColor: const Color(0xFFA5A9BB),
      textFontWight: TextFontWight.regular,
      textStyle: const TextStyle(fontSize: 10),
    );
  }

  CustomText _visitStatus(BuildContext context) {
    return CustomText(
      text: appointment.visitStatus!.parseToString(),
      textColor: appointment.visitStatus!.parseToColor(),
      textFontWight: TextFontWight.bold,
      textStyle: const TextStyle(fontSize: 12),
    );
  }
}
