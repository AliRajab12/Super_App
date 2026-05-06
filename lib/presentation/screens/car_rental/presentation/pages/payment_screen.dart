import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/presentation/common/widgets/custom_rounded_button.dart';
import 'package:somi/presentation/common/widgets/payment_methods_card.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../common/widgets/app_dialogs.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../widgets/car_info_widget.dart';
import '../widgets/cost_breakdown.dart';

@RoutePage()
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Payment',
        homeButton: true,
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarInfoWidget(),
              SizedBox(
                height: 16,
              ),
              Text(
                'Select Payment Method',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
              PaymentMethodsCard(),
              SizedBox(
                height: 16,
              ),
              CoastBreakDown(),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
        child: CustomRoundedButton(
          text: 'Book Now',
          pressed: () {
            showPaymentDialog(context);
          },
        ),
      ),
    );
  }
}
