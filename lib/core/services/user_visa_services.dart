import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:somi/core/network/network_config.dart';

class UserVisaService {
  final NetworkProvider network;

  UserVisaService(this.network);

  Future<bool> checkVisaEligibility(
      {required String countryCode, required String duraiton}) async {
    // final response = await network.noAuth().post(
    //       '/api/v1/user/visa/check-eligibilty',
    //       data: jsonEncode({countryCode, duraiton}),
    //     );
    return true;
  }

  Future<bool> sumbitVisaApplication({
    required String country,
    required String visaDuration,
    required File passport,
    required File nationalID,
    required File photograph,
  }) async {
    // final response = await network.noAuth().post(
    //       '/api/v1/user/visa/submit-application',
    //       data: jsonEncode({countryCode, duraiton}),
    //     );
    return true;
  }

  Future<bool> sumbitRenewalVisaApplication({
    required String visaType,
    required String visaDuration,
    required String visaAriveDate,
    required String visaExitDate,
    required File passport,
    required File previousVisa,
    required File photograph,
  }) async {
    // final response = await network.noAuth().post(
    //       '/api/v1/user/visa/submit-application',
    //       data: jsonEncode({countryCode, duraiton}),
    //     );
    return true;
  }
}
