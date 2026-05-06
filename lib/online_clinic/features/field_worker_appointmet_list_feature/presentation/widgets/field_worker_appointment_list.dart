import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/domain/entities/field_worker_appointment_entity.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/widgets/field_worker_appointment_card_widget.dart';
class FieldWorkerAppointmentListWithPriority extends StatefulWidget {
  const FieldWorkerAppointmentListWithPriority({
    super.key,
    required this.appointments,
  });

  final List<FieldWorkerAppointmentEntity> appointments;

  @override
  State<FieldWorkerAppointmentListWithPriority> createState() =>
      FieldWorkerAppointmentListWithPriorityState();
}

class FieldWorkerAppointmentListWithPriorityState
    extends State<FieldWorkerAppointmentListWithPriority> {
  List<FieldWorkerAppointmentEntity> appointmentsFilter = [];

  @override
  void initState() {
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
          child: FieldWorkerAppointmentCardWidget(
            appointment: appointmentsFilter[index],
            makeCallTap: () {
              CallClass().joinMeeting(
                context: context,
                roomName: Constants.callRoomName,
              );
            },
          ),
        ),
      ),
    );
  }
}
