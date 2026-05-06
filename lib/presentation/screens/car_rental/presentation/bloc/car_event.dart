import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../core/models/location.dart';

abstract class CarEvent extends Equatable {}

class SetDateDurationEvent extends CarEvent {
  final DateTime? firstDate;
  final DateTime? lastDate;
  SetDateDurationEvent({
    this.firstDate,
    this.lastDate,
  });
  @override
  List<Object?> get props => [];
}

class SetFirstTimeEvent extends CarEvent {
  final String? firstTime;
  SetFirstTimeEvent({
    this.firstTime,
  });

  @override
  List<Object?> get props => [];
}

class SetLastTimeEvent extends CarEvent {
  final String? lastTime;
  SetLastTimeEvent({
    this.lastTime,
  });

  @override
  List<Object?> get props => [];
}

class OpenUpdateEvent extends CarEvent {
  final bool? value;
  OpenUpdateEvent({
    this.value,
  });

  @override
  List<Object?> get props => [];
}

class SetRangValuesEvent extends CarEvent {
  final RangeValues? rangeValues;
  SetRangValuesEvent({
    this.rangeValues,
  });

  @override
  List<Object?> get props => [];
}

class UploadFileEvent extends CarEvent {
  final int? index;
  final BuildContext context;
  UploadFileEvent({
    this.index,
    required this.context,
  });

  @override
  List<Object?> get props => [];
}

class RemoveFileEvent extends CarEvent {
  final int? index;
  RemoveFileEvent({
    this.index,
  });

  @override
  List<Object?> get props => [index];
}

class SetDeliveryOptionEvent extends CarEvent {
  final int? index;
  SetDeliveryOptionEvent({
    this.index,
  });

  @override
  List<Object?> get props => [index];
}

class SetDriverOptionEvent extends CarEvent {
  final int? index;
  SetDriverOptionEvent({
    this.index,
  });

  @override
  List<Object?> get props => [index];
}

class SetDeliveryAddressEvent extends CarEvent {
  final Location? index;
  SetDeliveryAddressEvent({
    this.index,
  });

  @override
  List<Object?> get props => [index];
}

class SetReturnAddressEvent extends CarEvent {
  final Location? index;
  SetReturnAddressEvent({
    this.index,
  });

  @override
  List<Object?> get props => [index];
}
