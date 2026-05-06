import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/doctor_appointment_entity.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/presentation/widgets/doctor_appointment_card_widget.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/pages/patientProfilePage.dart';

class DoctorAppointmentListWithPriority extends StatefulWidget {
  const DoctorAppointmentListWithPriority(
      {super.key, required this.appointments});

  final List<DoctorAppointmentEntity> appointments;

  @override
  State<DoctorAppointmentListWithPriority> createState() =>
      DoctorAppointmentListWithPriorityState();
}

class DoctorAppointmentListWithPriorityState
    extends State<DoctorAppointmentListWithPriority> {
  List<DoctorAppointmentEntity> appointmentsFilter = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    appointmentsFilter = widget.appointments;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: appointmentsFilter.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 8.h,
          ),
          child: DoctorAppointmentCardWidget(
            appointment: appointmentsFilter[index],
            makeCallTap: () {
              CallClass().joinMeeting(
                context: context,
                roomName: Constants.callRoomName,
              );
            },
            checkupTap: () {
              locator<MainRouter>().push(
                PatientProfileRoute(
                  userType: UserTypeEnum.doctor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
