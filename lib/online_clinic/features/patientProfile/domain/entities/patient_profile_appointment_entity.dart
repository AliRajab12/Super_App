
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';

import 'visit_status_enum.dart';

class PatientProfileAppointmentEntity {
  PatientProfileAppointmentEntity({
    this.firstName,
    this.lastName,
    this.avatar,
    this.appointmentDate,
    this.sickness,
    this.hasFieldWorker,
    this.appointmentPriorityType,
    this.appointmentType,
    this.visitStatus,
  });

  final String? firstName;
  final String? lastName;
  final String? avatar;
  final DateTime? appointmentDate;
  final String? sickness;
  final bool? hasFieldWorker;
  final AppointmentPriorityTypeEnum? appointmentPriorityType;
  final AppointmentTypeEnum? appointmentType;
  final VisitStatusEnum? visitStatus;
}
