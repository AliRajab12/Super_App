import 'package:somi/online_clinic/core/widgets/app_widgets/disable_calendaer/disable_calendar.dart';

class AppointmentScheduleEntity {
  final DateType dateType;
  final String startTime ;
  final String endTime ;
  AppointmentScheduleEntity({
    required this.dateType,
    required this.endTime,
    required this.startTime
});
}