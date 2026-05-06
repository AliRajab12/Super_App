import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/bloc/payment_bloc.dart';
import 'package:somi/presentation/common/bloc/payment_state.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'add_new_credit_card_form.dart';
import 'payment_way_rounded_container.dart';

class PaymentWayCard extends StatefulWidget {
  final String text;
  final String imagePath;
  final int index;
  const PaymentWayCard({
    super.key,
    required this.text,
    required this.imagePath,
    required this.index,
  });

  @override
  State<PaymentWayCard> createState() => _PaymentWayCardState();
}

class _PaymentWayCardState extends State<PaymentWayCard> {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = locator<PaymentBloc>();
    return BlocBuilder<PaymentBloc, PaymentState>(
      bloc: bloc,
      builder: (context, state) => AnimatedContainer(
          curve: Curves.fastLinearToSlowEaseIn,
          duration: const Duration(milliseconds: 600),
          child: AnimatedCrossFade(
            firstChild: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () {
                  bloc.add(SetPaymentWay(index: widget.index));
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset(
                      widget.imagePath,
                      width: 15,
                      height: 20,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(widget.text,
                          textScaleFactor: 1.1,
                          style: kSectionTitle.copyWith(fontSize: 14)),
                    ),
                    Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.grey,
                      size: 27,
                    ),
                  ],
                ),
              ),
            ),
            secondChild: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [kBoxShadow],
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(
                        () => isExpanded = !isExpanded,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                widget.imagePath,
                                width: 15,
                                height: 20,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Text(widget.text,
                                    textScaleFactor: 1.1,
                                    style:
                                        kSectionTitle.copyWith(fontSize: 14)),
                              ),
                              Icon(
                                isExpanded
                                    ? Icons.keyboard_arrow_up
                                    : Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: 27,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(height: 10),
                  if (widget.index == 0 && isExpanded) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: (state.userPaymentCards.isEmpty)
                          ? const AddNewCreditCardForm()
                          : Column(
                              children: [
                                Column(
                                  children: List.generate(
                                    state.userPaymentCards.length,
                                    (index) => PaymentWayRoundedContainer(
                                      text:
                                          state.userPaymentCards[index].number,
                                      onTap: () {
                                        bloc.add(SetUserCreditCard(
                                            creditCard:
                                                state.userPaymentCards[index]));
                                      },
                                      paymentWayLogo:
                                          'images/svg/${state.userPaymentCards[index].type}.svg',
                                    ),
                                  ),
                                ),
                                (state.displayNewCardForm)
                                    ? Column(
                                        children: [
                                          // Close button
                                          Align(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: InkWell(
                                                onTap: () {
                                                  bloc.add(
                                                      const ToggleNewCardForm(
                                                          displayNewCardForm:
                                                              false));
                                                },
                                                child: const Icon(Icons.close)),
                                          ),
                                          const AddNewCreditCardForm(),
                                        ],
                                      )
                                    : Container(
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomButton(
                                            height: 50,
                                            borderRadius: 25,
                                            onPressed: () {
                                              setState(() {
                                                if (state.userPaymentCards
                                                        .length <
                                                    5) {
                                                  bloc.add(
                                                      const ToggleNewCardForm(
                                                          displayNewCardForm:
                                                              true));
                                                }
                                              });
                                            },
                                            child: const FittedBox(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons
                                                      .add_circle_outline_outlined),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    'Add new card',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ),
                              ],
                            ),
                    ),
                  ] else
                    ...[]
                ],
              ),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 800),
            reverseDuration: Duration.zero,
            sizeCurve: Curves.fastLinearToSlowEaseIn,
          )),
    );
  }
}
