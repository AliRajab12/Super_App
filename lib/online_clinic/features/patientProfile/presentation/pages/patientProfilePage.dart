import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/pages/patient_profile_doctor/patient_profile_doctor_page.dart';

@RoutePage()
class PatientProfile extends StatelessWidget {
  const PatientProfile({
    required this.userType,
    super.key,
  });

  static const String route = '/patientProfile';
  final UserTypeEnum userType;

  @override
  Widget build(BuildContext context) {
    switch (userType) {
      case UserTypeEnum.doctor:
        return const PatientProfileDoctorPage(
          userTypeEnum: UserTypeEnum.doctor,
        );
      case UserTypeEnum.fieldWorker:
        return const PatientProfileDoctorPage(
          userTypeEnum: UserTypeEnum.fieldWorker,
        );
      case UserTypeEnum.patient:
        return const PatientProfileDoctorPage(
          userTypeEnum: UserTypeEnum.patient,
        );
    }
  }
}
