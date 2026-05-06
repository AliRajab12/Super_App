class PrescriptionEntity {
  PrescriptionEntity({
    required this.drugName,
    required this.drugAmount,
    required this.drugTiming,
    this.drugDescription,
  });

  final String? drugName;
  final String? drugAmount;
  final String? drugTiming;
  final String? drugDescription;
}
