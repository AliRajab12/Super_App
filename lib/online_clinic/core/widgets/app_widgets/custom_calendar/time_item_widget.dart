import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';


class TimeItemWidget extends StatelessWidget {
  const TimeItemWidget({
    required this.index,
    required this.currentTime,
    required this.date,
    required this.isBooked,
    super.key,
  });

  final int index;
  final int currentTime;
  final DateTime date;
  final bool isBooked;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: EdgeInsets.only(
      bottom: 20.h,
      top: 5.h,
    ),
    child: CustomContainer(
      border:
      index == currentTime ? Border.all(color: OnlineClinicColorStyle.primary) : null,
      elevationType: ElevationType.highElevation,
      height: 94.h,
      width: 60.w,
      borderRadius: BorderRadius.all(Radius.circular(24.r)),
      color: index == currentTime
          ? OnlineClinicColorStyle.lightGray
          : (index + 1 == currentTime || index - 1 == currentTime)
          ? OnlineClinicColorStyle.lightGray4
          : OnlineClinicColorStyle.lightColor3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: _calculateStartTime(index),
                textColor: index == currentTime
                    ? OnlineClinicColorStyle.dark2
                    : (index + 1 == currentTime || index - 1 == currentTime)
                    ? OnlineClinicColorStyle.gray2
                    : OnlineClinicColorStyle.gray1,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.bold,
              ),
              Gap(12.h),
              CustomText(
                text: _calculateEndTime(index),
                textColor: index == currentTime
                    ? OnlineClinicColorStyle.dark2
                    : (index + 1 == currentTime || index - 1 == currentTime)
                    ? OnlineClinicColorStyle.gray2
                    : OnlineClinicColorStyle.gray1,
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.bold,
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

  String _calculateStartTime(int index) =>
      index % 2 == 0 ? '${index ~/ 2}:00' : '${index ~/ 2}:30';

  String _calculateEndTime(int index) => index % 2 == 0
      ? '${(index ~/ 2).toString()}:30'
      : '${((index ~/ 2) + 1).toString()}:00';
}
