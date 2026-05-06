import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/common/bloc/payment_bloc.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/payment_methods_card.dart';

@RoutePage()
class VisaPaymentScreen extends StatelessWidget {
  const VisaPaymentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    locator<PaymentBloc>().add(const FetchUserCreditCards());
    return Scaffold(
        backgroundColor: SomiColors.background,
        appBar: CustomAppBar(
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () {
            visaAppCubit.add(const ResetState());
            locator<MainRouter>().popUntilRouteWithPath('/home');
          },
          title: 'Payment',
          backgroundColor: SomiColors.background,
        ),
        body: BlocBuilder<VisaAppBloc, VisaAppState>(
            bloc: visaAppCubit,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Select pyament method',
                    style: kSectionTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const PaymentMethodsCard(),
                  const SizedBox(height: 20),
                  Text(
                    'Visa Fee',
                    style: kSectionTitle.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      if (state.country.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Nationality',
                              style: kSectionTitle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              state.country,
                              style: kSectionTitle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                      if (state.duration.isNotEmpty) ...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Duration',
                              style: kSectionTitle.copyWith(
                                  fontSize: 16, fontWeight: FontWeight.w500),
                            ),
                            Text(
                              state.duration,
                              style: kSectionTitle.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.primary),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Colors.grey.shade300,
                          ),
                        ),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fee',
                            style: kSectionTitle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '800 AED',
                            style: kSectionTitle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Divider(
                          color: Colors.grey.shade300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: kSectionTitle.copyWith(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                          Text(
                            '800 AED',
                            style: kSectionTitle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary),
                          )
                        ],
                      ),
                    ],
                  ),
                ]),
              );
            }),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CustomButton(
                      height: 50,
                      width: MediaQuery.sizeOf(context).width / 2,
                      borderRadius: 30,
                      backgroundColor: Colors.white,
                      forgroundColor: Colors.black,
                      onPressed: () {},
                      child: const Text(
                        'Call',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      )),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: BlocBuilder<VisaAppBloc, VisaAppState>(
                    bloc: visaAppCubit,
                    builder: (context, state) => CustomButton(
                        width: MediaQuery.sizeOf(context).width / 2,
                        height: 50,
                        borderRadius: 30,
                        onPressed: () {
                          visaAppCubit.add(const SumbitVisaApplication());
                        },
                        child: (state.loading)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                'Pay',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              )),
                  ),
                ),
              ],
            )));
  }
}
