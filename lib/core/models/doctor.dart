import 'package:freezed_annotation/freezed_annotation.dart';
part 'doctor.freezed.dart';
part 'doctor.g.dart';

@freezed
class Doctor with _$Doctor {
  factory Doctor({
    @Default('') String id,
    @Default('') String firstName,
    @Default('') String lastName,
    @Default('') String imageUrl,
    @Default('') String jobRole,
    @Default('') String stars,
  }) = _Doctor;

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);
}

List<Doctor> doctors = [
  Doctor(
    id: '1',
    firstName: 'Adelina',
    lastName: 'Edwards',
    imageUrl: 'images/d1.png',
    jobRole: 'Critical Care Specialist',
    stars: '4.9',
  ),
  Doctor(
    id: '2',
    firstName: 'Dr. Bernard',
    lastName: 'Bliss',
    imageUrl: 'images/d2.png',
    jobRole: 'Cardiologist',
    stars: '4.7',
  ),
  Doctor(
    id: '3',
    firstName: 'Frida',
    lastName: 'Park, MD',
    imageUrl: 'images/d1.png',
    jobRole: 'Pediatrician',
    stars: '4.8',
  ),
  Doctor(
    id: '4',
    firstName: 'Harry',
    lastName: 'Wans, FSc',
    imageUrl: 'images/d2.png',
    jobRole: 'General Physician',
    stars: '4.9',
  ),
  Doctor(
    id: '5',
    firstName: 'Mi',
    lastName: 'James, MBBS',
    imageUrl: 'images/d1.png',
    jobRole: 'Eye Specialist',
    stars: '4.8',
  ),
];
