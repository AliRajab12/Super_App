import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class VisaAppEvent extends Equatable {
  const VisaAppEvent();
}

class SetCountry extends VisaAppEvent {
  final String country;

  const SetCountry(this.country);

  @override
  List<Object?> get props => [country];
}

class SetDuration extends VisaAppEvent {
  final String duration;
  const SetDuration(this.duration);

  @override
  List<Object?> get props => [duration];
}

class SetVisaType extends VisaAppEvent {
  final String visaType;
  const SetVisaType(this.visaType);

  @override
  List<Object?> get props => [visaType];
}

class SetVisaArriveExitDate extends VisaAppEvent {
  final DateTimeRange newDateRange;
  const SetVisaArriveExitDate(this.newDateRange);

  @override
  List<Object?> get props => [newDateRange];
}

class NavigateToDocumentsStep extends VisaAppEvent {
  const NavigateToDocumentsStep();

  @override
  List<Object?> get props => [];
}

class NavigateToCheckEligibiltyStep extends VisaAppEvent {
  const NavigateToCheckEligibiltyStep();

  @override
  List<Object?> get props => [];
}

class CheckVisaEligibility extends VisaAppEvent {
  const CheckVisaEligibility();

  @override
  List<Object?> get props => [];
}

class UploadFile extends VisaAppEvent {
  final BuildContext context;
  final int index;
  final bool isNewApp;
  const UploadFile(
      {required this.context, required this.index, required this.isNewApp});

  @override
  List<Object?> get props => [context, index, isNewApp];
}

class RemoveFile extends VisaAppEvent {
  final int index;
  const RemoveFile({
    required this.index,
  });

  @override
  List<Object?> get props => [
        index,
      ];
}

class SumbitVisaApplication extends VisaAppEvent {
  const SumbitVisaApplication();

  @override
  List<Object?> get props => [];
}

class SumbitRenewalVisaApplication extends VisaAppEvent {
  const SumbitRenewalVisaApplication();

  @override
  List<Object?> get props => [];
}

class ResetState extends VisaAppEvent {
  const ResetState();

  @override
  List<Object?> get props => [];
}
