enum ProfileTypeEnum { medicalProfile, history, appointments }

extension ProfileTypeEnumExtension on ProfileTypeEnum {
  String parseToString() {
    switch (this) {
      case ProfileTypeEnum.medicalProfile:
        return 'Medical Profile';
      case ProfileTypeEnum.history:
        return 'History';
      case ProfileTypeEnum.appointments:
        return 'Appointments';
    }
  }
}
