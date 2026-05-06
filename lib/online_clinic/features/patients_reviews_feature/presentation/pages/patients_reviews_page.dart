import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/card/patient_review_card.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

@RoutePage()
class PatientsReviewsPage extends StatelessWidget {
  const PatientsReviewsPage({super.key});
  static const String route = '/patientsReviewsPage';

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      showAppAppbar: true,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(45.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              text: 'Patients reviews',
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Gap(8.h),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(bottom: 16.h),
            itemBuilder: (context, index) {
              return PatientsReviewCard(
                  margin: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                  name: 'Joseph Kim $index',
                  comment:
                      'I recently started seeing Dr. Charlotte Lewis after experiencing chest pain, a family history of heart disease. From the very beginning, I was impressed by the professionalism and care of the entire staff.',
                  date: 'Oct 10, 2023',
                  rate: index.toDouble(),
                  height: 154.5.h,
                  width: 1.sw);
            },
            itemCount: 10,
          )),
        ],
      ),
    );
  }
}
