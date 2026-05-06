import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class ObservationItemWidget extends StatelessWidget {
  const ObservationItemWidget({
    super.key,
  });



  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.r),
        child: CustomContainer(
          height: 110.h,
          borderRadius: BorderRadius.all(Radius.circular(16.r)),
          color: OnlineClinicColorStyle.white,
          boxShadow: [
            OnlineClinicColorStyle.noneBoxShadow,
          ],
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 16.h,
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _observationTitle(context),
                Gap(16.h),
                _observation(context),
              ],
            ),
          ),
        ),
      );

  Widget _observation(BuildContext context) => CustomText(
    text: 'Physical: Ms. Brown was alert and oriented to time, place, and person. She reported mild pain in her left calf, which she described as a dull ache. She was using a cane for mobility due to slight unsteadiness on her feet. ',
        multiLine: true,
        textStyle: Theme.of(context).textTheme.labelLarge,
        textColor: OnlineClinicColorStyle.dark2,
        textFontWight: TextFontWight.regular,
      );

  Widget _observationTitle(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomText(
              text: 'Observations:',
              textStyle: Theme.of(context).textTheme.bodySmall,
              textColor: OnlineClinicColorStyle.dark,
              textFontWight: TextFontWight.bold,
            ),
          ),
        ],
      );
}
