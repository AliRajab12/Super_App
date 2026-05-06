import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/common/bloc/payment_bloc.dart';
import 'package:somi/presentation/common/bloc/payment_state.dart';

class PaymentWayRoundedContainer extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final String paymentWayLogo;
  const PaymentWayRoundedContainer(
      {super.key,
      required this.onTap,
      required this.text,
      required this.paymentWayLogo});

  @override
  Widget build(BuildContext context) {
    final bloc = locator<PaymentBloc>();

    return BlocBuilder<PaymentBloc, PaymentState>(
      bloc: bloc,
      builder: (context, state) {
        return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300, width: 1)),
            child: ListTile(
                onTap: onTap,
                dense: true,
                title: Text(text),
                leading: SvgPicture.asset(paymentWayLogo),
                trailing: Icon(
                  Icons.radio_button_checked,
                  color: (state.userCreditCard?.number == text)
                      ? AppColors.primary
                      : Colors.grey,
                )));
      },
    );
  }
}
