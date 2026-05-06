import 'package:freezed_annotation/freezed_annotation.dart';
part 'credit_card.freezed.dart';
part 'credit_card.g.dart';

@freezed
class CreditCard with _$CreditCard {
  factory CreditCard({
    @Default('') String number,
    @Default('') String holderName,
    @Default('') String cvv,
    @Default('') String type,
    @Default('') String expirationDate,
  }) = _CreditCard;

  factory CreditCard.fromJson(Map<String, dynamic> json) =>
      _$CreditCardFromJson(json);
}
