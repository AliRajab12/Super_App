import 'package:freezed_annotation/freezed_annotation.dart';

part 'enrollment.freezed.dart';
part 'enrollment.g.dart';

@freezed
class Enrollment with _$Enrollment {
  const Enrollment._();

  const factory Enrollment({
    @JsonKey(name: 'CurriculumId') @Default(null) int? curriculumId,
    @JsonKey(name: 'EnrollDate') @Default(null) String? enrollDate,
    @JsonKey(name: 'PercentComplete') @Default(null) double? percentComplete,
  }) = _Enrollment;

  factory Enrollment.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentFromJson(json);
}
