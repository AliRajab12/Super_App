import 'package:dartz/dartz.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/data/models/appointment_model_imp.dart';

abstract class AppointmentRepository {
  Future<Either<String, List<AppointmentEntity>>> getAppointment({
    required final AppointmentModelImp model,
  });
}
