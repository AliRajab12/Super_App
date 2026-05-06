import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/tab_bar/custom_tab_bar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/doctor_appointment_entity.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/presentation/widgets/doctor_appointment_list.dart';
@RoutePage()
class DoctorAppointmentListPage extends StatefulWidget {
  const DoctorAppointmentListPage({super.key , required this.tabIndex , required this.priorityTabIndex});
  static const String route = '/doctorAppointmentListPage';
  final int tabIndex;
  final int priorityTabIndex;
  @override
  State<DoctorAppointmentListPage> createState() =>
      _DoctorAppointmentListPageState();
}

class _DoctorAppointmentListPageState extends State<DoctorAppointmentListPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late TabController _typeTabController;
  late PageController _pageController;
  TextEditingController searchController = TextEditingController();
  List<DoctorAppointmentEntity> appointments = [
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.today,
      hasFieldWorker: false,
    ),
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.upComing,
      hasFieldWorker: true,
    ),
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: false,
    ),
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.today,
      hasFieldWorker: true,
    ),
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.upComing,
      hasFieldWorker: false,
    ),
    DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz',
      appointmentPriorityType: AppointmentPriorityTypeEnum.urgent,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),DoctorAppointmentEntity(
      firstName: 'jamshid',
      lastName: 'jamshid',
      avatar: 'images/onine_clinic_png/person.png',
      appointmentDate: DateTime.now(),
      sickness: 'mariz R',
      appointmentPriorityType: AppointmentPriorityTypeEnum.regular,
      appointmentType: AppointmentTypeEnum.completed,
      hasFieldWorker: true,
    ),
  ];
  List<DoctorAppointmentEntity> appointmentsFilter = [];
  AppointmentTypeEnum appointmentTypeEnumSelected = AppointmentTypeEnum.today;

  GlobalKey<DoctorAppointmentListWithPriorityState> doctorAppointmentListWithPriorityStateKey = GlobalKey();


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _typeTabController = TabController(length: 2, vsync: this);

    _tabController.index = widget.tabIndex;
    _typeTabController.index = widget.priorityTabIndex;



    _tabController.addListener(() {
      if(_tabController.index == 0){
        /// today tab
        appointmentTypeEnumSelected = AppointmentTypeEnum.today;
        appointmentsFilter = appointments.where((element) => element.appointmentType == AppointmentTypeEnum.today).toList();


      }else  if(_tabController.index == 1){
        /// upcoming tab
        appointmentTypeEnumSelected = AppointmentTypeEnum.upComing;
        appointmentsFilter = appointments.where((element) => element.appointmentType == AppointmentTypeEnum.upComing).toList();

      }else  if(_tabController.index == 2){
        /// completed tab
        appointmentTypeEnumSelected = AppointmentTypeEnum.completed;
        appointmentsFilter = appointments.where((element) => element.appointmentType == AppointmentTypeEnum.completed).toList();

      }
      doctorAppointmentListWithPriorityStateKey.currentState?.appointmentsFilter = appointmentsFilter;
      doctorAppointmentListWithPriorityStateKey.currentState?.setState(() {
      });
    });
    _typeTabController.addListener(() {
      if(_typeTabController.index == 0){
        /// urgent
        appointmentsFilter = appointments.where((element) {
          return element.appointmentType == appointmentTypeEnumSelected && element.appointmentPriorityType == AppointmentPriorityTypeEnum.urgent;
        }).toList();

      }else if(_typeTabController.index == 1){
        /// regular
        appointmentsFilter = appointments.where((element) {
          return element.appointmentType == appointmentTypeEnumSelected && element.appointmentPriorityType == AppointmentPriorityTypeEnum.regular;
        }).toList();

      }

      doctorAppointmentListWithPriorityStateKey.currentState?.appointmentsFilter = appointmentsFilter;
      doctorAppointmentListWithPriorityStateKey.currentState?.setState(() {
      });

    });

    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CustomBody(
      showAppAppbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16.h),
          Center(
            child: AppTextField(
              controller: searchController,
              hintText: 'Search a doctor or medical condition',
            ),
          ),
          Gap(25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              text: 'Appointments',
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
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
                text: 'Urgent',
              ),
              Tab(
                text: 'Regular',
              ),
            ],
            padding: EdgeInsets.symmetric(horizontal: 100.w),
          ),
          Gap(8.h),
          CustomTabbar(
            height: 37.h,
            onTap: (page) {
              //  _pageController.jumpToPage(page);
            },
            tabController: _tabController,
            tabs: const [
              Tab(
                text: 'Today’s',
              ),
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          Gap(16.h),
          DoctorAppointmentListWithPriority(
            key: doctorAppointmentListWithPriorityStateKey,
            appointments: appointments,
          ),
        ],
      ),
    );
  }
}
