import 'package:somi/core/models/credit_card.dart';
import 'package:somi/core/network/network_config.dart';

class PaymentService {
  final NetworkProvider network;
  PaymentService(this.network);

  Future<List<CreditCard>> getUserCreditCards() async {
    return [
      // CreditCard(
      //   number: 'xxxx-xxxx-xxxx-xxxx',
      //   type: 'visa',
      //   holderName: 'Ali',
      //   cvv: 'xxx',
      // ),
      // CreditCard(
      //   number: '1234-1234-1234-1234',
      //   type: 'master',
      //   holderName: 'Ahmad',
      //   cvv: 'xxx',
      // ),
    ];
  }
}
