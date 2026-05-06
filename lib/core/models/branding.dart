// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'branding.freezed.dart';
part 'branding.g.dart';

@freezed
class Branding with _$Branding {
  factory Branding({
    @Default(null) String? BrandColor,
    @Default(null) bool? UseLightText,
  }) = _Branding;

  factory Branding.fromJson(Map<String, dynamic> json) =>
      _$BrandingFromJson(json);
}
