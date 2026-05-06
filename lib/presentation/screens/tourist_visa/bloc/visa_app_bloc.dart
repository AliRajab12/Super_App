import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:somi/core/services/user_visa_services.dart';
import 'package:somi/core/utils/file_uploader.dart';
import 'package:somi/core/utils/utility.dart';

import 'visa_app_event.dart';
import 'visa_app_state.dart';

class VisaAppBloc extends Bloc<VisaAppEvent, VisaAppState> {
  final UserVisaService userVisaService;

  VisaAppBloc({required this.userVisaService}) : super(const VisaAppState()) {
    //------------------------ Set Country ------------------------
    on<SetCountry>((event, emit) async {
      if (event.country != state.country) {
        emit(state.copyWith(
          country: event.country,
          isEligible: false,
          step: 0,
        ));
      } else {
        emit(state.copyWith(country: event.country));
      }
    });
    //------------------------ Set Duration ------------------------
    on<SetDuration>((event, emit) async {
      if (event.duration != state.duration) {
        emit(state.copyWith(
          duration: event.duration,
          isEligible: false,
          step: 0,
        ));
      } else {
        emit(state.copyWith(duration: event.duration));
      }
    });
    //------------------------ Set Visa Type ------------------------
    on<SetVisaType>((event, emit) async {
      emit(state.copyWith(visaType: event.visaType));
    });
    //------------------------ Set Visa Arrive-Exit Dates ------------------------
    on<SetVisaArriveExitDate>((event, emit) async {
      emit(state.copyWith(
          visaArriveDate: Utility.getDateFromUTC(event.newDateRange.start),
          visaExitDate: Utility.getDateFromUTC(event.newDateRange.end)));
    });
    //------------------------ Navigate to upload documents step ------------------------
    on<NavigateToDocumentsStep>((event, emit) async {
      if (state.step == 1) {
        emit(state.copyWith(step: state.step + 1));
      }
    });
    //------------------------ Navigate to upload documents step ------------------------
    on<NavigateToCheckEligibiltyStep>((event, emit) async {
      if (state.step == 2) {
        emit(state.copyWith(step: state.step - 1));
      }
    });
    //------------------------ Check Visa Eligibility ------------------------
    on<CheckVisaEligibility>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      await Future.delayed(const Duration(seconds: 1));
      try {
        // Response (isEligible,country, duration,Fee)
        final isEligible = await userVisaService.checkVisaEligibility(
            countryCode: state.country, duraiton: state.duration);
        emit(state.copyWith(
            isEligible: isEligible,
            step: (isEligible) ? state.step + 1 : state.step));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    //------------------------ Upload visa related file ------------------------
    on<UploadFile>((event, emit) async {
      final file = await FileUploader.pickAndUploadFile(event.context);
      switch (event.index) {
        case 0:
          emit(state.copyWith(passport: file));
          break;
        case 1:
          emit(state.copyWith(nID: file));
          break;
        case 2:
          emit(state.copyWith(photograph: file));
          break;
        case 3:
          emit(state.copyWith(previousVisa: file));
          break;
      }
      if (event.isNewApp) {
        if (state.passport != null &&
            state.nID != null &&
            state.photograph != null) {
          emit(state.copyWith(doumentsUploaded: true));
        } else {
          if (state.passport != null &&
              state.previousVisa != null &&
              state.photograph != null) {
            emit(state.copyWith(doumentsUploaded: true));
          }
        }
      }
    });
    //------------------------ Remove visa related file ------------------------
    on<RemoveFile>((event, emit) async {
      switch (event.index) {
        case 0:
          emit(state.copyWith(passport: null, doumentsUploaded: false));
          break;
        case 1:
          emit(state.copyWith(nID: null, doumentsUploaded: false));
          break;
        case 2:
          emit(state.copyWith(photograph: null, doumentsUploaded: false));
          break;
        case 3:
          emit(state.copyWith(previousVisa: null, doumentsUploaded: false));
          break;
      }
    });
    //------------------------ Sumbit Visa Application ------------------------
    on<SumbitVisaApplication>((event, emit) async {
      emit(state.copyWith(loading: true));
      await Future.delayed(const Duration(seconds: 3));
      try {
        final response = await userVisaService.sumbitVisaApplication(
            country: state.country,
            visaDuration: state.duration,
            nationalID: state.nID!,
            passport: state.passport!,
            photograph: state.photograph!);
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    //------------------------ Sumbit Renewal Visa Application ------------------------
    on<SumbitRenewalVisaApplication>((event, emit) async {
      emit(state.copyWith(loading: true));
      await Future.delayed(const Duration(seconds: 3));
      try {
        final response = await userVisaService.sumbitRenewalVisaApplication(
            visaType: state.visaType,
            visaDuration: state.duration,
            visaAriveDate: state.visaArriveDate,
            visaExitDate: state.visaExitDate,
            previousVisa: state.previousVisa!,
            passport: state.passport!,
            photograph: state.photograph!);
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    //------------------------ Reset Visa App State ------------------------
    on<ResetState>((event, emit) async {
      emit(VisaAppState.initial());
    });
  }
}
