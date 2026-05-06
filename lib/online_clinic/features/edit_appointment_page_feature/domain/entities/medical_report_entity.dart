class MedicalReportEntity {
  MedicalReportEntity({
    required this.title,
    required this.reportDate,
    required this.document,
    required this.documentType,
    required this.documentSize,
  });

   String? title;
  final DateTime? reportDate;
  final String? document;
  final String? documentSize;
  final String? documentType;
}
