import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/adaptive_alert_dialog.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';
import 'package:somi/presentation/screens/tourist_visa/widgets/upload_documents_card.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';

@RoutePage()
class VisaExtensionScreen extends StatelessWidget {
  const VisaExtensionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    return BlocBuilder<VisaAppBloc, VisaAppState>(
        bloc: visaAppCubit,
        builder: (context, state) {
          return WillPopScope(
            onWillPop: () async {
              visaAppCubit.add(const ResetState());
              Navigator.of(context).pop();
              return false;
            },
            child: Scaffold(
                backgroundColor: SomiColors.background,
                appBar: CustomAppBar(
                  onBackButtonPressed: () {
                    visaAppCubit.add(const ResetState());
                    Navigator.of(context).pop();
                  },
                  onHomeButtonPressed: () {
                    visaAppCubit.add(const ResetState());
                    locator<MainRouter>().popUntilRouteWithPath('/home');
                  },
                  title: 'Visa Extension',
                  backgroundColor: SomiColors.background,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(children: const [
                    SizedBox(
                      height: 25,
                    ),
                    UploadDocumentsCard(isNewVisaApp: false),
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
                                  'Contact Us',
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
                                  if (state.passport == null ||
                                      state.photograph == null ||
                                      state.previousVisa == null) {
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
                                  } else {
                                    locator<MainRouter>()
                                        .navigateNamed('/visa-payment');
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
