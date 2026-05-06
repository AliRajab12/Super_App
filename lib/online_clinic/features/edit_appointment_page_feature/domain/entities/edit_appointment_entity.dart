
import 'package:somi/online_clinic/core/enums/blood_enum.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/medical_report_entity.dart';

class EditAppointmentEntity {
  EditAppointmentEntity({
    required this.age,
    required this.weight,
    required this.height,
    required this.heartRate,
    required this.temperature,
    required this.bloodType,
    required this.reportList,
    required this.chronicDiseaseList,
    required this.geneticDiseaseList,
    required this.surgeriesList
  });

  final int? age;
  final int? weight;
  final int? height;
  final int? heartRate;
  final double? temperature;
  final BloodEnum? bloodType;
  final List<MedicalReportEntity> reportList;
  final List<DropDownModel> chronicDiseaseList;
  final List<DropDownModel> surgeriesList;
  final List<DropDownModel> geneticDiseaseList;
}
