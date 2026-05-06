import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/disable_calendaer/disable_calendar.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/domain/entities/appointment_schedule_entity.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/presentation/widgets/acction_title_date_picker.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/widgets/user_comment.dart';

class OfflinePageDoctor extends StatelessWidget {
   OfflinePageDoctor({super.key});
  final List<AppointmentScheduleEntity> appointmentScheduleList = [
    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '9:30',
      endTime: '10:00',
    ),  AppointmentScheduleEntity(dateType:
    DateType.urgent,
      startTime: '10:00',
      endTime: '10:30',
    ),  AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '10:30',
      endTime: '11:00',
    ),  AppointmentScheduleEntity(dateType:
    DateType.vacant,
      startTime: '11:00',
      endTime: '11:30',
    ),


    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '11:30',
      endTime: '12:00',
    ),

    AppointmentScheduleEntity(dateType:
    DateType.urgent,
      startTime: '12:00',
      endTime: '12:30',
    ),

    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '4:00',
      endTime: '4:30',
    ),

    AppointmentScheduleEntity(dateType:
    DateType.urgent,
      startTime: '4:30',
      endTime: '5:00',
    ),

    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '5:00',
      endTime: '5:30',
    ),


    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '5:30',
      endTime: '6:00',
    ),


    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '6:00',
      endTime: '6:30',
    ),


    AppointmentScheduleEntity(dateType:
    DateType.regular,
      startTime: '6:00',
      endTime: '7:00',
    ),


  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Gap(24.h),
        // const TitleWidget(
        //   title: 'Completed Appointments',
        //   subtitle: 'Track your patient appointments',
        //   action: SizedBox(),
        // ),


        TitleWidget(
            title: 'Schedule',
            subtitle: 'See yor today’s plan',
            action: ActionTitleDatePicker(
              onSelectDate: (DateTime selectedDate){

              },
            )

        ),

        Gap(
            24.h
        ),

        DisableCalendar(appointmentScheduleList: appointmentScheduleList,),
        Gap(
            24.h
        ),
        TitleWidget(
          title: 'Patient’s Reviews',
          subtitle: 'See what your patients’ say about you',
          onTapSeeAll: (){
            locator<MainRouter>().push( const PatientsReviewsPageRoute()  );
          },

        ),
        Gap(
            24.h
        ),
        SizedBox(
          height: 152.h,
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 16.w),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return UserComment(
                  name: 'Joseph Kim $index',
                  comment:
                  'I recently started seeing Dr. Charlotte Lewis after experiencing chest pain, a family history of heart disease.',
                  date: 'Oct 10 2023',
                  rate: index.toDouble());
            },
          ),
        ),

        Gap(
            22.h
        ),

      ],
    );
  }
}
