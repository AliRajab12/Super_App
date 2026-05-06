import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';


class DateItemWidget extends StatelessWidget {
  const DateItemWidget({
    required this.index,
    required this.date,
    required this.isBooked,
    super.key,
  });

  final int index;
  final DateTime date;
  final bool isBooked;

  @override
  Widget build(BuildContext context) {
    int indexedDate = date.day -1 ;
    return Padding(
        padding: EdgeInsets.only(
          bottom: 17.h,
          top: 5.h,
        ),
        child: CustomContainer(
          border:
              index == indexedDate ? Border.all(color: OnlineClinicColorStyle.primary) : null,
          elevationType: ElevationType.highElevation,
          height: 94.h,
          width: 60.w,
          borderRadius: BorderRadius.all(Radius.circular(24.r)),
          color: index == indexedDate
              ? OnlineClinicColorStyle.lightGray
              : (index + 1 == indexedDate || index - 1 == indexedDate)
                  ? OnlineClinicColorStyle.lightGray4
                  : OnlineClinicColorStyle.lightColor3,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: (index + 1).toString(),
                    textColor: index == indexedDate
                        ? OnlineClinicColorStyle.dark2
                        : (index + 1 == indexedDate || index - 1 == indexedDate)
                            ? OnlineClinicColorStyle.gray2
                            : OnlineClinicColorStyle.gray1,
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    textFontWight: TextFontWight.bold,
                  ),
                  Gap(12.h),
                  CustomText(
                    text: DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(
                      date.year,
                      date.month,
                      index + 1,
                    )),
                    textColor: index == indexedDate
                        ? OnlineClinicColorStyle.dark2
                        : (index + 1 == indexedDate || index - 1 == indexedDate)
                            ? OnlineClinicColorStyle.gray2
                            : OnlineClinicColorStyle.gray1,
                    textStyle: Theme.of(context).textTheme.bodySmall,
                    textFontWight: TextFontWight.regular,
                  ),
                ],
              ),
              Positioned(
                top: 1,
                right: 1,
                child: CustomContainer(
                  height: 10.h,
                  width: 10.w,
                  color: isBooked ? OnlineClinicColorStyle.dark : OnlineClinicColorStyle.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      );
  }
}
