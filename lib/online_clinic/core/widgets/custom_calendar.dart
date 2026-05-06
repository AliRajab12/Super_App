import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';


class CustomCalendar extends StatefulWidget {
  CustomCalendar({
    required this.selectedDate,
    DateTime? initialDate,
    super.key,
  }) : initialDate = initialDate ?? DateTime.now();

  final DateTime initialDate;

  final void Function(
     DateTime startDate,
     DateTime endDate,
  ) selectedDate;

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  int? currentDay;
  int? currentTime;

  @override
  void initState() {
    super.initState();
    currentDay = widget.initialDate.day -1;
    currentTime = widget.initialDate.hour * 2;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _calendarHeader(),
        _daysOfMonth(),
        _timeOfDay(),
        AppButton.filled(
          onTap: () => widget.selectedDate(
            DateTime(
              widget.initialDate.year,
              widget.initialDate.month,
              currentDay! + 1,
              int.parse(_calculateHourStartTime(currentTime!)),
              int.parse(_calculateMinuteStartTime(currentTime!)),
            ),
             DateTime(
              widget.initialDate.year,
              widget.initialDate.month,
              currentDay! + 1,
              int.parse(_calculateHourEndTime(currentTime!)),
              int.parse(_calculateMinuteEndTime(currentTime!)),
            ),
          ),
          label: 'Finalize Your Appointment',
          height: 48.h,
          backgroundColor: OnlineClinicColorStyle.primary,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
        ),
      ],
    );
  }

  Widget _calendarHeader() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 32.r),
        child: Row(
          children: [
            CustomText(
              text: 'Schedule',
              textStyle: Theme.of(context).textTheme.titleMedium,
              textFontWight: TextFontWight.bold,
            ),
          ],
        ),
      );

  Widget _daysOfMonth() {
    return SizedBox(
      height: 116.h,
      width: 1.sw,
      child: CarouselSlider.builder(
        itemCount: _daysInMonthFunction(),
        options: CarouselOptions(
          viewportFraction: 0.18,initialPage: currentDay!,
          onScrolled: (value) => setState(() {
            currentDay = value?.toInt();
          }),
          enableInfiniteScroll: false,
          // height: 142.h,
          onPageChanged: (index, reason) => setState(() {
            currentDay = index;
          }),
        ),
        itemBuilder: (context, index, realIndex) => _dateItemWidget(
          context: context,
          index: index,
          isBooked: index % 2 == 0,
        ),
      ),
    );
  }

  Padding _dateItemWidget({
    required int index,
    required BuildContext context,
    required bool isBooked,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 17.h,
        top: 5.h,
      ),
      child: CustomContainer(
        border:
            index == currentDay ? Border.all(color: OnlineClinicColorStyle.primary) : null,
        elevationType: ElevationType.highElevation,
        height: 94.h,
        width: 60.w,
        borderRadius: BorderRadius.all(Radius.circular(24.r)),
        color: index == currentDay
            ? OnlineClinicColorStyle.lightGray
            : (index + 1 == currentDay || index - 1 == currentDay)
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
                  textColor: index == currentDay
                      ? OnlineClinicColorStyle.dark2
                      : (index + 1 == currentDay || index - 1 == currentDay)
                          ? OnlineClinicColorStyle.gray2
                          : OnlineClinicColorStyle.gray1,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  textFontWight: TextFontWight.bold,
                ),
                Gap(12.h),
                CustomText(
                  text: DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(
                    widget.initialDate.year,
                    widget.initialDate.month,
                    index + 1,
                  )),
                  textColor: index == currentDay
                      ? OnlineClinicColorStyle.dark2
                      : (index + 1 == currentDay || index - 1 == currentDay)
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

  Widget _timeOfDay() => SizedBox(
        width: 1.sw,
        height: 119.h,
        child: CarouselSlider.builder(
          itemCount: 48,
          options: CarouselOptions(
            viewportFraction: 0.18,
            onScrolled: (value) => setState(() {
              currentTime = value?.toInt();
            }),
            enableInfiniteScroll: false,
            initialPage: currentTime!,
            onPageChanged: (index, reason) => setState(() {
              currentTime = index;
            }),
          ),
          itemBuilder: (context, index, realIndex) => _timeItemWidget(
            index: index,
            context: context,
            isBooked: index % 2 == 0,
          ),
        ),
      );

  Padding _timeItemWidget({
    required int index,
    required BuildContext context,
    required bool isBooked,
  }) {
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

  String _calculateHourStartTime(int index) =>
      index % 2 == 0 ? '${index ~/ 2}' : '${index ~/ 2}';

  String _calculateMinuteStartTime(int index) =>
      index % 2 == 0 ? '00' : '30';

  String _calculateEndTime(int index) => index % 2 == 0
      ? '${(index ~/ 2).toString().padLeft(2, "0")}:30'
      : '${((index ~/ 2) + 1).toString().padLeft(2, "0")}:00';

  String _calculateHourEndTime(int index) => index % 2 == 0
      ? (index ~/ 2).toString().padLeft(2, "0")
      : ((index ~/ 2) + 1).toString().padLeft(2, "0");

  String _calculateMinuteEndTime(int index) =>
      index % 2 == 0 ? '30' : '00';

  int _daysInMonthFunction() {
    DateTime firstDayOfMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month, 1);
    DateTime firstDayOfNextMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month + 1, 1);
    Duration difference = firstDayOfNextMonth.difference(firstDayOfMonth);

    return difference.inDays;
  }
}
