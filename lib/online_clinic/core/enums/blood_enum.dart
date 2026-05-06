enum BloodEnum {
  aPlus(1, 'A+'),
  aMinus(2, 'A-'),
  bPlus(3, 'B+'),
  bMinus(4, 'B-'),
  abPlus(5, 'AB+'),
  abMinus(6, 'AB-'),
  oPlus(7, 'O+'),
  oMinus(8, 'O-'),
  golden(9, 'G');

  const BloodEnum(
    this.id,
    this.value,
  );

  factory BloodEnum.fromValue(
      final String? value,
      ) {
    switch (value) {
      case 'A+':
        return BloodEnum.aPlus;
      case 'A-':
        return BloodEnum.aMinus;
      case 'B+':
        return BloodEnum.bPlus;
      case 'B-':
        return BloodEnum.bMinus;
      case 'AB+':
        return BloodEnum.abPlus;
      case 'AB-':
        return BloodEnum.abMinus;
      case 'O+':
        return BloodEnum.oPlus;
      case 'O-':
        return BloodEnum.oMinus;
      case 'G':
        return BloodEnum.golden;
      default:
        return BloodEnum.abPlus;
    }
  }

  final int id;
  final String value;
}
