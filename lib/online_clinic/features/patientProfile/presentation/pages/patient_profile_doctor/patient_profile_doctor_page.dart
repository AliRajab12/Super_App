import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/patient_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/patient_content_large_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/tab_bar/custom_tab_bar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/features/patientProfile/data/models/patient_profile_appointment_data.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/pages/patient_profile_doctor/patient_history_page.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/pages/patient_profile_doctor/patient_profile_tab.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/widgets/profile_appointment_list.dart';

class PatientProfileDoctorPage extends StatefulWidget {
  const PatientProfileDoctorPage({super.key , required this.userTypeEnum});
  final UserTypeEnum userTypeEnum;

  @override
  State<PatientProfileDoctorPage> createState() =>
      _PatientProfileDoctorPageState();
}

class _PatientProfileDoctorPageState extends State<PatientProfileDoctorPage> with TickerProviderStateMixin{
  GlobalKey<ProfileAppointmentListState> patientProfileAppointmentListStateKey =
      GlobalKey();
  late TabController _tabController;
  ScrollController scrollController = ScrollController();

  PatientPageStateEnum patientPageState = PatientPageStateEnum.medicalReport;


  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => CustomBody(
        contentLargeAppBar: PatientContentLargeAppBar(
          userType: UserTypeEnum.doctor,
          patientPageState: patientPageState,
          changePatientPageState: (p0) => patientPageState = p0,

        ),
        child: SizedBox(
          height: 1.sh,
          child: Column(
            children: [
              Gap(32.h),
              CustomTabbar(
                height: 37.h,
                onTap: (page) {
                  setState(() {
                    if(page == 0){
                      patientPageState =PatientPageStateEnum.medicalReport;
                    }
                    if(page == 1){
                      patientPageState =PatientPageStateEnum.history;
                    }
                    if(page == 2) {
                      patientPageState =PatientPageStateEnum.appointments;
                    }
                  });
                },
                padding: EdgeInsets.symmetric(horizontal: 42.h),
                tabController: _tabController,
                tabs: const [
                  Tab(
                    text: 'Medical Profile',
                  ),
                  Tab(
                    text: 'Prescription',
                  ),
                  Tab(
                    text: 'Appointments',
                  ),
                ],
              ),
              Gap(24.h),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    PatientProfileTab(),
                     PatientHistoryPage(
                       userTypeEnum: widget.userTypeEnum,
                     ),
                    ProfileAppointmentList(
                      scrollController: scrollController,
                      key: patientProfileAppointmentListStateKey,
                      appointments: appointments,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
