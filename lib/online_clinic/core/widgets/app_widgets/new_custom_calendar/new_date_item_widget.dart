import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/day_model.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class NewDateItemWidget extends StatelessWidget {
  const NewDateItemWidget({
    required this.index,
    required this.date,
    required this.model,
    required this.isBooked,
    super.key,
  });

  final int index;
  final DateTime date;
  final bool isBooked;
  final DayModel model;

  @override
  Widget build(BuildContext context) {
    final int indexedDate = date.day - 1;

    return Padding(
      padding: EdgeInsets.only(
        bottom: 17.h,
        top: 5.h,
      ),
      child: CustomContainer(
        border: index == indexedDate
            ? Border.all(color: OnlineClinicColorStyle.primary)
            : null,
        elevationType: ElevationType.noElevation,
        height: 120.h,
        width: 60.w,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        color: OnlineClinicColorStyle.lightGray4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: model.weekName,
              textColor: OnlineClinicColorStyle.dark,
              textStyle: Theme.of(context).textTheme.bodySmall,
            ),
            Gap(8.h),
            CustomText(
              text: model.day.toString(),
              textColor: OnlineClinicColorStyle.dark,
              textStyle: Theme.of(context).textTheme.titleMedium,
              textFontWight: TextFontWight.bold,
            ),
            Gap(8.h),
            CustomText(
              text: model.freeSlot != 0 ? '${model.freeSlot} slots' : '-',
              textStyle: Theme.of(context).textTheme.bodySmall,
              textColor: _getFreeSlots() != 0
                  ? OnlineClinicColorStyle.primaryDark1
                  : OnlineClinicColorStyle.gray,
            ),
          ],
        ),
      ),
    );
  }

  int _getFreeSlots() {
    if (index % 5 == 0) {
      return 0;
    }
    return ((index - 1) % 8) + 1;
  }
}
