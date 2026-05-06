import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:somi/core/models/credit_card.dart';
import 'package:somi/core/services/payment_service.dart';
import 'payment_state.dart';
part 'payment_event.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentService paymentService;

  PaymentBloc({required this.paymentService}) : super(const PaymentState()) {
    on<SetPaymentWay>((event, emit) async {
      emit(state.copyWith(paymentWay: event.index));
    });
    on<SetUserCreditCard>((event, emit) async {
      emit(state.copyWith(userCreditCard: event.creditCard));
    });
    on<FetchUserCreditCards>((event, emit) async {
      emit(state.copyWith(loading: true, error: null));
      try {
        final results = await paymentService.getUserCreditCards();
        // results
        emit(state.copyWith(userPaymentCards: state.userPaymentCards));
      } catch (e) {
        emit(state.copyWith(error: e));
      }
      emit(state.copyWith(loading: false));
    });
    on<SendCreditCardOTP>((event, emit) async {
      if (event.saveCreditDetails) {
        final List<CreditCard> creditCards = List.from(state.userPaymentCards);
        creditCards.add(event.cardDetails);
        emit(state.copyWith(
            userPaymentCards: creditCards, displayNewCardForm: false));
      }
    });
    on<ToggleNewCardForm>((event, emit) async {
      emit(state.copyWith(displayNewCardForm: event.displayNewCardForm));
    });
  }
}
