enum GenderEnum {
  male(1, 'Mr','Male'),
  female(2, 'Ms','Female');

  const GenderEnum(
    this.id,
    this.prefixValue,
    this.gender,
  );

  factory GenderEnum.fromValue(
      final String? gender,
      ) {
    switch (gender) {
      case 'Female':
        return GenderEnum.female;
      case 'Male':
        return GenderEnum.male;
      default:
        return GenderEnum.male;
    }
  }

  final int id;
  final String prefixValue;
  final String gender;
}
