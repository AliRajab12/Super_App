import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';
import 'package:somi/presentation/screens/tourist_visa/features/apply_for_visa/presentation/widgets/visa_app_check_eligibility_widget.dart';
import 'package:somi/presentation/screens/tourist_visa/widgets/upload_documents_card.dart';
import 'package:somi/presentation/screens/tourist_visa/widgets/visa_fee_table.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/core/widgets/adaptive_alert_dialog.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';

@RoutePage()
class VisaApplicationScreen extends StatelessWidget {
  const VisaApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    return BlocBuilder<VisaAppBloc, VisaAppState>(
        bloc: visaAppCubit,
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              if (state.step == 2) {
                visaAppCubit.add(const NavigateToCheckEligibiltyStep());
              } else {
                visaAppCubit.add(const ResetState());
                Navigator.of(context).pop();
              }
              return false;
            },
            child: Scaffold(
                backgroundColor: SomiColors.background,
                appBar: CustomAppBar(
                  onBackButtonPressed: () {
                    if (state.step == 2) {
                      visaAppCubit.add(const NavigateToCheckEligibiltyStep());
                    } else {
                      visaAppCubit.add(const ResetState());
                      Navigator.of(context).pop();
                    }
                  },
                  onHomeButtonPressed: () {
                    visaAppCubit.add(const ResetState());
                    locator<MainRouter>().popUntilRouteWithPath('/home');
                  },
                  title: 'Visa Application',
                  backgroundColor: SomiColors.background,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('${state.step}/2'),
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 400),
                                alignment: Alignment.center,
                                width: (state.step == 0)
                                    ? MediaQuery.sizeOf(context).width * 0.03
                                    : (state.step == 1 ||
                                            (state.step == 2 &&
                                                !state.doumentsUploaded))
                                        ? MediaQuery.sizeOf(context).width * 0.4
                                        : MediaQuery.sizeOf(context).width *
                                            0.8,
                                height: 10,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    if (state.step <= 1) const VisaAppCheckEligibilityWidget(),
                    if (state.isEligible && state.step <= 1) ...[
                      const SizedBox(height: 20),
                      const VisaFeeTable()
                    ],
                    if (state.step == 2) ...[const UploadDocumentsCard()]
                  ]),
                ),
                bottomNavigationBar: BlocBuilder<VisaAppBloc, VisaAppState>(
                  bloc: visaAppCubit,
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CustomButton(
                                width: MediaQuery.sizeOf(context).width / 2,
                                height: 50,
                                borderRadius: 30,
                                onPressed: () {
                                  if (state.country.isEmpty) {
                                    showDegreedAdaptiveDialog(
                                      context,
                                      (context) => AdaptiveAlertDialog(
                                        title: const Text(
                                            'Please choose your nationality'),
                                        actions: [
                                          DialogAction(
                                            label: 'Ok',
                                            isDefaultAction: true,
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (state.duration.isEmpty) {
                                    showDegreedAdaptiveDialog(
                                      context,
                                      (context) => AdaptiveAlertDialog(
                                        title: const Text(
                                            'Please choose the visa\'s duration'),
                                        actions: [
                                          DialogAction(
                                            label: 'Ok',
                                            isDefaultAction: true,
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    switch (state.step) {
                                      case 0:
                                        visaAppCubit
                                            .add(const CheckVisaEligibility());
                                        break;
                                      case 1:
                                        if (state.isEligible) {
                                          visaAppCubit.add(
                                              const NavigateToDocumentsStep());
                                        }
                                        break;
                                      case 2:
                                        if (state.isEligible &&
                                            state.doumentsUploaded) {
                                          locator<MainRouter>()
                                              .navigateNamed('/visa-payment');
                                        } else {
                                          showDegreedAdaptiveDialog(
                                            context,
                                            (context) => AdaptiveAlertDialog(
                                              title: const Text(
                                                  'Please upload the required documents'),
                                              actions: [
                                                DialogAction(
                                                  label: 'Ok',
                                                  isDefaultAction: true,
                                                  onPressed: () {},
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                    }
                                  }
                                },
                                child: (state.loading)
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Continue',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                      )),
                          ),
                        ],
                      ),
                    );
                  },
                )),
          );
        });
  }
}
