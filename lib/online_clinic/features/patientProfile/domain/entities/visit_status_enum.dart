import 'package:flutter/material.dart';

enum VisitStatusEnum { upcoming, missed, completed }

extension VisitStatusEnumExtension on VisitStatusEnum {
  String parseToString() {
    switch (this) {
      case VisitStatusEnum.upcoming:
        return 'Upcoming';
      case VisitStatusEnum.missed:
        return 'Missed';
      case VisitStatusEnum.completed:
        return 'Completed';
      default:
        return 'Unknown';
    }
  }

  Color parseToColor() {
    switch (this) {
      case VisitStatusEnum.upcoming:
        return const Color(0xff272D36);
      case VisitStatusEnum.missed:
        return const Color(0xffFF000F);
      case VisitStatusEnum.completed:
        return const Color(0xff00A49A);
      default:
        return const Color(0xFF3BB3D9);
    }
  }
}
