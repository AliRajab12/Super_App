import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/tab_bar/custom_tab_bar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/domain/entities/field_worker_appointment_entity.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/widgets/content_large_appBar_fieldworker.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/widgets/field_worker_appointment_card_widget.dart';
import 'package:somi/online_clinic/features/field_worker_appointmet_list_feature/presentation/widgets/field_worker_appointment_list.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/widgets/offline_page_filedworker.dart';

@RoutePage()
class FieldWorkerProfilePage extends StatefulWidget {
  const FieldWorkerProfilePage({super.key});

  static const route = '/fieldWorkerProfilePage';

  @override
  State<FieldWorkerProfilePage> createState() => _FieldWorkerProfilePageState();
}

class _FieldWorkerProfilePageState extends State<FieldWorkerProfilePage>  with TickerProviderStateMixin{


  TextEditingController searchController = TextEditingController();
  GlobalKey<FieldWorkerAppointmentListWithPriorityState>
      fieldWorkerAppointmentListWithPriorityStateKey = GlobalKey();
  late TabController _typeTabController;
  List<FieldWorkerAppointmentEntity> appointments = [
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
    FieldWorkerAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      doctorName: 'patient R',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.suggestion,
    ),
  ];
  List<FieldWorkerAppointmentEntity> appointmentsFilter = [];
  AppointmentPriorityTypeEnum appointmentPriorityTypeEnum = AppointmentPriorityTypeEnum.urgent;
  GlobalKey<FieldWorkerAppointmentListWithPriorityState>
  fieldWorkerAppointmentListWithPriorityState = GlobalKey();
  bool isOnline = false;

  @override
  void initState() {

    _typeTabController = TabController(length: 2, vsync: this);


    _typeTabController.addListener(() {
      if (_typeTabController.index == 0) {
        /// urgent
        appointmentPriorityTypeEnum = AppointmentPriorityTypeEnum.urgent;
        appointmentsFilter = appointments.where((element) {
          return
              element.appointmentPriorityType ==
                  AppointmentPriorityTypeEnum.urgent;
        }).toList();
      }
      else if (_typeTabController.index == 1) {
        /// regular
        appointmentPriorityTypeEnum = AppointmentPriorityTypeEnum.regular;
        appointmentsFilter = appointments.where((element) {
          return
              element.appointmentPriorityType ==
                  AppointmentPriorityTypeEnum.regular;
        }).toList();
      }
      fieldWorkerAppointmentListWithPriorityState
          .currentState?.appointmentsFilter = appointmentsFilter;
      fieldWorkerAppointmentListWithPriorityState.currentState?.setState(() {});
    });


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      contentLargeAppBar: ContentLargeAppBarFieldWorker(
        onTapOnlineButton: (bool isOnlineFieldWorker){
          isOnline = isOnlineFieldWorker;
          setState(() {

          });
        },
      ),
      child:isOnline?  Column(
        children: [
           SizedBox(
            height: 32.h,
          ),
           TitleWidget(
            title: 'Appointments',
            subtitle: '',
            onTapSeeAll: () {
              locator<MainRouter>().push(  FieldWorkerAppointmentListPageRoute(tabIndex: 0, priorityTabIndex: 0)  );
            },

          ),
          Gap(24.h),
          CustomTabbar(
            height: 37.h,
            onTap: (page) {
              //  _pageController.jumpToPage(page);
            },
            tabController: _typeTabController,
            tabs: const [
              Tab(
                text: 'Emergency',
              ),
              Tab(
                text: 'Regular',
              ),
            ],
            padding: EdgeInsets.symmetric(horizontal: 100.w),
          ),
          Gap(24.h),
          FieldWorkerAppointmentListWithPriority(
            key: fieldWorkerAppointmentListWithPriorityState,
            appointments: appointments,
          )

        ],
      ) : const OfflineFieldWorkerPage(),
    );
  }
}
