import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/widgets/adaptive_alert_dialog.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';
import 'package:somi/presentation/common/widgets/custom_drop_down.dart';
import 'package:somi/presentation/screens/tourist_visa/widgets/upload_documents_card.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

@RoutePage()
class VisaRenewalScreen extends StatelessWidget {
  const VisaRenewalScreen({super.key});

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
                  title: 'Visa Renewal',
                  backgroundColor: SomiColors.background,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      'Please fill with the details',
                      style: kSectionTitle.copyWith(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        Text(
                          'Type',
                          style: kSectionTitle.copyWith(fontSize: 18),
                        ),
                        const Text(' *',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomDropDown(
                      initialValue:
                          (state.visaType.isEmpty) ? 'A2A' : state.visaType,
                      items: [
                        DropdownMenuItem(
                            value: 'A2A',
                            child: Text(
                              'Airport to airport (Transit)',
                              style: TextStyle(
                                  color: state.visaType == 'A2A'
                                      ? Colors.black
                                      : Colors.grey),
                            )),
                        DropdownMenuItem(
                            value: 'InC',
                            child: Text(
                              'Inside country',
                              style: TextStyle(
                                  color: state.visaType == 'InC'
                                      ? Colors.black
                                      : Colors.grey),
                            )),
                      ],
                      onChange: (newValue) {
                        visaAppCubit.add(SetVisaType(newValue!));
                      },
                    ),
                    const SizedBox(height: 20),
                    if (state.visaType == 'A2A') ...[
                      Row(
                        children: [
                          Text(
                            'Date',
                            style: kSectionTitle.copyWith(fontSize: 18),
                          ),
                          const Text(' *',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.red,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                child: SfDateRangePicker(
                                  onSelectionChanged: (args) {
                                    final date = args.value;
                                    DateTimeRange dateRange = DateTimeRange(
                                        start: date.startDate ?? DateTime.now(),
                                        end: date.endDate ??
                                            DateTime.now()
                                                .add(const Duration(days: 1)));
                                    visaAppCubit
                                        .add(SetVisaArriveExitDate(dateRange));
                                  },
                                  enablePastDates: false,
                                  allowViewNavigation: false,
                                  view: DateRangePickerView.month,
                                  todayHighlightColor: AppColors.primary,
                                  startRangeSelectionColor: AppColors.primary,
                                  endRangeSelectionColor: AppColors.primary,
                                  selectionColor: AppColors.primary,
                                  rangeSelectionColor:
                                      AppColors.primary.withOpacity(0.3),
                                  selectionMode:
                                      DateRangePickerSelectionMode.range,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [kBoxShadow],
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                    (state.visaArriveDate.isNotEmpty)
                                        ? '${state.visaArriveDate} - ${state.visaExitDate}'
                                        : 'Select date',
                                    style: TextStyle(
                                        color: (state.visaArriveDate.isNotEmpty)
                                            ? Colors.black
                                            : Colors.grey)),
                              ),
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                    Row(
                      children: [
                        Text(
                          'Duration',
                          style: kSectionTitle.copyWith(fontSize: 18),
                        ),
                        const Text(' *',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.red,
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomDropDown(
                      initialValue: (state.duration.isEmpty)
                          ? '96 hours'
                          : state.duration,
                      items: [
                        DropdownMenuItem(
                            value: '96 hours',
                            child: Text(
                              '96 hours',
                              style: TextStyle(
                                  color: state.duration == '96 hours'
                                      ? Colors.black
                                      : Colors.grey),
                            )),
                        DropdownMenuItem(
                            value: '14 days',
                            child: Text(
                              '14 days',
                              style: TextStyle(
                                  color: state.duration == '14 days'
                                      ? Colors.black
                                      : Colors.grey),
                            )),
                        DropdownMenuItem(
                            value: '30 days',
                            child: Text(
                              '30 days',
                              style: TextStyle(
                                  color: state.duration == '30 days'
                                      ? Colors.black
                                      : Colors.grey),
                            )),
                      ],
                      onChange: (newValue) {
                        visaAppCubit.add(SetDuration(newValue!));
                      },
                    ),
                    const SizedBox(height: 20),
                    const UploadDocumentsCard(isNewVisaApp: false),
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
                                  if (state.visaType.isEmpty) {
                                    showDegreedAdaptiveDialog(
                                      context,
                                      (context) => AdaptiveAlertDialog(
                                        title: const Text(
                                            'Please choose the Visa type'),
                                        actions: [
                                          DialogAction(
                                            label: 'Ok',
                                            isDefaultAction: true,
                                            onPressed: () {},
                                          ),
                                        ],
                                      ),
                                    );
                                  } else if (state.visaType == 'A2A' &&
                                      (state.visaExitDate.isEmpty ||
                                          state.visaArriveDate.isEmpty)) {
                                    showDegreedAdaptiveDialog(
                                      context,
                                      (context) => AdaptiveAlertDialog(
                                        title: const Text(
                                            'Please choose the Arrive - Exit dates'),
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
                                  } else if (state.passport == null ||
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
