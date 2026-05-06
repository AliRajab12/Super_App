class ObservationEntity {
  ObservationEntity({
    required this.doctorName,
    required this.observation,
    required this.observationDate,
  });

  final String? doctorName;
  final String? observation;
  final DateTime? observationDate;
}
