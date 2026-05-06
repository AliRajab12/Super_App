import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/patient_profile_appointment_entity.dart';
import 'patient_profile_card_widget.dart';

class ProfileAppointmentList extends StatefulWidget {
  const ProfileAppointmentList(
      {super.key, required this.appointments, required this.scrollController});

  final List<PatientProfileAppointmentEntity> appointments;
  final ScrollController scrollController;

  @override
  State<ProfileAppointmentList> createState() => ProfileAppointmentListState();
}

class ProfileAppointmentListState extends State<ProfileAppointmentList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.appointments.length,
      shrinkWrap: true,
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 30.h),
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: PatientProfileAppointmentCardWidget(
          appointment: widget.appointments[index],
          makeCallTap: () {
            CallClass().joinMeeting(
              context: context,
              roomName: Constants.callRoomName,
              userName: (widget.appointments[index].firstName != null &&
                          widget.appointments[index].firstName!.isNotEmpty) ||
                      (widget.appointments[index].lastName != null &&
                          widget.appointments[index].lastName!.isNotEmpty)
                  ? '${widget.appointments[index].firstName} ${widget.appointments[index].lastName}'
                  : null,
            );
          },
          checkupTap: () {},
        ),
      ),
    );
  }
}
