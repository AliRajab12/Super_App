import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/data/data_sources/my_appointment_api_provider.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/data/models/appointment_model_imp.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/domain/repositories/appointment_repository.dart';

class AppointmentRepositoryImp extends AppointmentRepository {
  AppointmentRepositoryImp({
    required this.appointmentApiProvider,
  });

  final MyAppointmentApiProvider appointmentApiProvider;

  @override
  Future<Either<String, List<AppointmentEntity>>> getAppointment({
    required AppointmentModelImp model,
  })async {
    try {
      final result = await appointmentApiProvider.getAppointments();
      return Right(result);
    } on DioException catch (e) {
      return Left(e.toString());
    }
  }
}
