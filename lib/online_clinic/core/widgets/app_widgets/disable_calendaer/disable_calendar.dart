import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/domain/entities/appointment_schedule_entity.dart';

class DisableCalendar extends StatelessWidget {
  const DisableCalendar({super.key , required this.appointmentScheduleList});
  final List<AppointmentScheduleEntity> appointmentScheduleList;


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 16.w,
          runSpacing: 24.h,
          children: appointmentScheduleList.map((appointmentSchedule) => CustomContainer(
            width: 50.w,
            height: 94.h,
            borderRadius: BorderRadius.all(Radius.circular(18.r)),
            color: OnlineClinicColorStyle.lightColor3,
            elevationType: ElevationType.noElevation,

            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: CustomContainer(
                    width: 8.r,
                    height: 8.r,
                    shape: BoxShape.circle,
                    elevationType: ElevationType.noElevation,
                    color:appointmentSchedule.dateType == DateType.urgent ?
                    Colors.red : appointmentSchedule.dateType == DateType.regular ? OnlineClinicColorStyle.primary : OnlineClinicColorStyle.gray,
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(text: appointmentSchedule.startTime,
                          textStyle: Theme.of(context).textTheme.bodyMedium,
                        textColor: OnlineClinicColorStyle.gray,
                        textFontWight: TextFontWight.bold,
                      ),
                      Gap(
                        8.h
                      ),
                      CustomText(text: appointmentSchedule.endTime,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        textColor: OnlineClinicColorStyle.gray,
                        textFontWight: TextFontWight.bold,
                      )
                    ],
                  ),
                ),

              ],
            ),
          )).toList(),
        ),
        Gap(
          24.h
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomContainer(
              width: 8.r,
              height: 8.r,
              shape: BoxShape.circle,
              elevationType: ElevationType.noElevation,
              color: Colors.red
            ),
            Gap(
              4.w
            ),
            CustomText(
                text: 'Emergency',
                textStyle: Theme.of(context).textTheme.labelMedium,
              textColor: OnlineClinicColorStyle.lightGray,
            ),
            Gap(
                8.w
            ),
            CustomContainer(
              width: 8.r,
              height: 8.r,
              shape: BoxShape.circle,
              elevationType: ElevationType.noElevation,
              color: OnlineClinicColorStyle.primary
            ),
            Gap(
              4.w
            ),
            CustomText(
                text: 'Booked',
                textStyle: Theme.of(context).textTheme.labelMedium,
              textColor: OnlineClinicColorStyle.lightGray,
            ),
            Gap(
                8.w
            ),
            CustomContainer(
              width: 8.r,
              height: 8.r,
              shape: BoxShape.circle,
              elevationType: ElevationType.noElevation,
              color: OnlineClinicColorStyle.gray
            ),
            Gap(
              4.w
            ),
            CustomText(
                text: 'Vacant',
                textStyle: Theme.of(context).textTheme.labelMedium,
              textColor: OnlineClinicColorStyle.lightGray,
            ),
            Gap(16.w)
          ],
        )
      ],
    );
  }
}

enum DateType{
  urgent,
  regular,
  vacant
}
