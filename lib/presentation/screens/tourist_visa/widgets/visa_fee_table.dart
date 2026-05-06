import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/constants.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_bloc.dart';
import 'package:somi/presentation/screens/tourist_visa/bloc/visa_app_state.dart';

class VisaFeeTable extends StatelessWidget {
  const VisaFeeTable({super.key});

  @override
  Widget build(BuildContext context) {
    final visaAppCubit = locator<VisaAppBloc>();
    return BlocBuilder<VisaAppBloc, VisaAppState>(
      bloc: visaAppCubit,
      builder: (context, state) => Column(
        children: [
          Text(
            'Visa Fee',
            style: kSectionTitle.copyWith(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.sizeOf(context).width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [kBoxShadow]),
            child: Column(
              children: [
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
                const Divider(),
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
                const Divider(),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
