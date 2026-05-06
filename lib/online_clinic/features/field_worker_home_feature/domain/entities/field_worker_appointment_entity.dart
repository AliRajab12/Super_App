import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';

class FieldWorkerAppointmentEntity
{
  FieldWorkerAppointmentEntity( {
    this.firstName,
    this.lastName,
    this.avatar,
    this.appointmentDate,
    this.doctorName,
    this.appointmentPriorityType,
    this.appointmentType,
    this.isEditable,
  });


  final String? firstName;
  final String? lastName;
  final String? avatar;
  final DateTime? appointmentDate;
  final String? doctorName;
  final AppointmentPriorityTypeEnum? appointmentPriorityType;
  final AppointmentTypeEnum? appointmentType;

  final bool? isEditable;

}
