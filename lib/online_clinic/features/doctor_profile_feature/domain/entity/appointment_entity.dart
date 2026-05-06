import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';

class AppointmentEntity {
  AppointmentEntity({
    this.firstName,
    this.lastName,
    this.avatar,
    this.appointmentDate,
    this.expertise,
     this.title,
     this.subtitle,
     this.hasFieldWorker,
     this.time,
    this.today,
     this.appointmentPriorityTypeEnum
  });

  final String? firstName;
  final String? lastName;
  final String? avatar;
  final DateTime? appointmentDate;
  final String? expertise;
  final String? title;
  final String? subtitle;
  final String? time;
  final bool? hasFieldWorker;
  final bool? today;
  final AppointmentPriorityTypeEnum? appointmentPriorityTypeEnum;

}
