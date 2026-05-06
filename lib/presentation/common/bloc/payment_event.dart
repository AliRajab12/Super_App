part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
}

class SetPaymentWay extends PaymentEvent {
  final int index;

  const SetPaymentWay({required this.index});

  @override
  List<Object?> get props => [index];
}

class SetUserCreditCard extends PaymentEvent {
  final CreditCard creditCard;

  const SetUserCreditCard({required this.creditCard});

  @override
  List<Object?> get props => [creditCard];
}

class FetchUserCreditCards extends PaymentEvent {
  const FetchUserCreditCards();

  @override
  List<Object?> get props => [];
}

class SendCreditCardOTP extends PaymentEvent {
  final bool saveCreditDetails;
  final CreditCard cardDetails;
  const SendCreditCardOTP(
      {required this.saveCreditDetails, required this.cardDetails});

  @override
  List<Object?> get props => [saveCreditDetails, cardDetails];
}

class ToggleNewCardForm extends PaymentEvent {
  final bool displayNewCardForm;
  const ToggleNewCardForm({required this.displayNewCardForm});

  @override
  List<Object?> get props => [displayNewCardForm];
}
