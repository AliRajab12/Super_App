import 'package:freezed_annotation/freezed_annotation.dart';
part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  factory Address({
    @Default('') String? type,
    @Default('') String? name,
    @Default('') String? apartment,
    @Default('') String? floorNo,
    @Default('') String? building,
    @Default('') String? neighbrhood,
    @Default('') String? streetName,
    @Default('') String? city,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}
