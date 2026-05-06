import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:somi/core/models/credit_card.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState {
  const PaymentState._();
  const factory PaymentState({
    @Default(false) bool loading,
    @Default(-1) int paymentWay,
    @Default(false) bool displayNewCardForm,
    @Default([]) List<CreditCard> userPaymentCards,
    @Default(null) CreditCard? userCreditCard,
    @Default(null) Object? error,
  }) = _PaymentState;

  factory PaymentState.initial() => const PaymentState();

  factory PaymentState.loading() => const PaymentState(loading: true);
  factory PaymentState.completed() => const PaymentState(loading: false);

  factory PaymentState.error(Object error) => PaymentState(error: error);
}
