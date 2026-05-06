import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_event.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';

import '../../../../../../common/widgets/custom_drop_down.dart';

class VisaAppCheckEligibilityWidget extends StatelessWidget {
  const VisaAppCheckEligibilityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    return BlocBuilder<VisaAppBloc, VisaAppState>(
      bloc: visaAppCubit,
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                'Nationality',
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
          GestureDetector(
            onTap: () {
              showCountryPicker(
                context: context,
                showPhoneCode: false,
                onSelect: (Country country) {
                  // visaAppCubit.setCountry(country.name);
                  visaAppCubit.add(SetCountry(country.name));
                },
              );
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [kBoxShadow],
                  borderRadius: BorderRadius.circular(30)),
              child: TextFormField(
                  readOnly: true,
                  enabled: false,
                  decoration: InputDecoration(
                      suffixIcon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.grey,
                      ),
                      fillColor: Colors.white,
                      labelText: state.country.isEmpty
                          ? 'Select country'
                          : state.country,
                      labelStyle: TextStyle(
                          color: state.country.isEmpty
                              ? Colors.grey
                              : Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: InputBorder.none)),
            ),
          ),
          const SizedBox(height: 20),
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
            initialValue:
                (state.duration.isEmpty) ? '96 hours' : state.duration,
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
        ],
      ),
    );
  }
}
