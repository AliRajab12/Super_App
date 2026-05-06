
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';

class AppointmentModelImp extends AppointmentEntity{




  Map<String,dynamic> toJson() => {
    'firstName' : firstName,
    'lastName' : lastName,
    'avatar' : avatar,
    'appointmentDate' : appointmentDate?.toUtc(),
    'expertise' : expertise,
  };
}