import 'package:freezed_annotation/freezed_annotation.dart';

part 'primary_contact.freezed.dart';

part 'primary_contact.g.dart';

@freezed
class PrimaryContact with _$PrimaryContact {
  const factory PrimaryContact({
    @JsonKey(name: 'FirstName') String? firstName,
    @JsonKey(name: 'LastName') String? lastName,
    @JsonKey(name: 'Name') String? name,
    @JsonKey(name: 'OrganizationCode') String? organizationCode,
  }) = _PrimaryContact;

  factory PrimaryContact.fromJson(Map<String, dynamic> json) =>
      _$PrimaryContactFromJson(json);
}
