import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/large_app_bar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/appointment/vertical_appointment_card_widget.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/disable_calendaer/disable_calendar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/content_home_large_appbar.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/domain/entities/appointment_schedule_entity.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/presentation/widgets/acction_title_date_picker.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/presentation/widgets/offline_page_doctor.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/widgets/user_comment.dart';
@RoutePage()
class DoctorHomePage extends StatefulWidget {
   DoctorHomePage({super.key});
  static const route = '/doctorHomePage';

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
  List<AppointmentEntity> urgentAppointmentList = [
     AppointmentEntity(
      avatar: 'images/onine_clinic_png/person.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      time: '10:05',
         appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),
  ];

  List<AppointmentEntity> todayAppointmentList = [
     AppointmentEntity(
      avatar: 'images/onine_clinic_png/person2.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      today: true,
      time: '10:05',
         appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person2.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: false,
      today: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.regular
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person2.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: false,
      today: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent
    ),    AppointmentEntity(
      avatar: 'images/onine_clinic_png/person2.png',
      title: 'Lucas Martin',
      subtitle: 'Cardiomyopathy',
      hasFieldWorker: true,
      today: true,
      time: '10:05',
        appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.regular
    ),
  ];

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
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      backColor:  isOnline ? null : Color(0xff303030).withOpacity(0.1),

        child: Stack(
          // color: isOnline ? null : Color(0xff303030).withOpacity(0.35),
          children: [

            Column(
              children: [

                _appBar(),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Gap(
                          32.h
                        ),
                        TitleWidget(
                          title: 'Urgent Appointments',
                          subtitle: 'Track your urgent appointments',
                          onTapSeeAll: (){
                            locator<MainRouter>().push( DoctorAppointmentListPageRoute(
                                tabIndex: 0,
                                priorityTabIndex: 0
                            )  );
                          },
                        ),
                        Gap(
                          24.h
                        ),
                        Container(
                          // height: 245.h,
                          constraints: BoxConstraints(
                            minHeight: 245.h,
                            maxHeight: 278.h
                          ),

                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: urgentAppointmentList.length,
                              padding: EdgeInsets.only(bottom: 20.h),
                              shrinkWrap: true,
                              itemBuilder: (context , index){
                            return  VerticalAppointmentCardWidget(
                              appointmentEntity: urgentAppointmentList[index],
                              onTapMakeCall: (){
                                CallClass().joinMeeting(
                                  context: context,
                                  roomName: Constants.callRoomName,
                                );
                              },
                            );
                          }),
                        ),

                        TitleWidget(
                          title: 'Today’s Appointments',
                          subtitle: 'Track your patient appointments',

                          onTapSeeAll: (){
                            locator<MainRouter>().push( DoctorAppointmentListPageRoute(
                                tabIndex: 0,
                                priorityTabIndex: 1
                            )  );
                          },
                        ),

                        Gap(
                          24.h
                        ),

                        Container(
                          constraints: BoxConstraints(
                              minHeight: 245.h,
                              maxHeight: 278.h
                          ),

                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: todayAppointmentList.length,
                              padding: EdgeInsets.only(bottom: 20.h),
                              shrinkWrap: true,
                              itemBuilder: (context , index){
                                return  VerticalAppointmentCardWidget(
                                  appointmentEntity: todayAppointmentList[index],
                                  onTapMakeCall: (){
                                    CallClass().joinMeeting(
                                      context: context,
                                      roomName: Constants.callRoomName,
                                    );
                                  },
                                );
                              }),
                        ),


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
                    )
                  ),
                ),
              ],
            ),
            Container(
              color: isOnline ? null : Color(0xff303030).withOpacity(0.35),
            ),
            // if(!isOnline)
            _appBar()
          ],
        )
    );
  }

  Widget _appBar(){
    return     LargeAppBar(content:ContentHomeLargeAppBar(
      title: 'Welcome Dr. William',
      subtitle: 'Have a nice day and great work!',
      hintSearch: 'Search your patient name or ID ',
      date: 'March 13, 2024',
      showActionAppbar: false,
      showOnlineButton: true,
      showSearch: false,
      changeStatus: (isOnlineDoctor){
        isOnline = isOnlineDoctor;
        setState(() {

        });
      },
    ), );
  }


}
