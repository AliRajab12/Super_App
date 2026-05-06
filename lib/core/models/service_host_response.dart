// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_host_response.freezed.dart';
part 'service_host_response.g.dart';

@freezed
class ServiceHostResponse with _$ServiceHostResponse {
  factory ServiceHostResponse({String? ServiceHost}) = _ServiceHostResponse;

  factory ServiceHostResponse.fromJson(Map<String, dynamic> json) =>
      _$ServiceHostResponseFromJson(json);
}
