import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_calendar/days_list_calendar_widget.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_calendar/time_list_calendar_widget.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/dropDown/app_drop_down.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class CustomCalendar extends StatelessWidget {
  CustomCalendar({
    required this.selectedDate,
    DateTime? initialDate,
    super.key,
  }) : initialDate = initialDate ?? DateTime.now();

  DateTime initialDate;

  final List<DropDownModel> yearsModel = [];
  final List<DropDownModel> months = [];
  int? selectedMonth;
  GlobalKey<DaysListCalendarWidgetState> monthKey = GlobalKey();

  final void Function({
    required DateTime startDate,
    required DateTime endDate,
  }) selectedDate;

  @override
  Widget build(BuildContext context) {
    for (var i = initialDate.year; i < initialDate.year + 5; ++i) {
      yearsModel.add(DropDownModel(
        title: i.toString(),
        id: i,
      ));
    }
    for (var i = 1; i < 13; ++i) {
      months.add(
        DropDownModel(
          title: DateFormat(DateFormat.MONTH).format(
            DateTime(
              initialDate.year,
              i,
              initialDate.day,
            ),
          ),
          id: i,
        ),
      );
    }
    int currentDay = initialDate.day;
    int currentTime = initialDate.hour * 2;
    selectedMonth = initialDate.month;
    return Column(
      children: [
        _calendarHeader(context),
        DaysListCalendarWidget(
          key: monthKey,
          initialDate: initialDate,
          returnedCurrentDay: (returnedCurrentDay) =>
              currentDay = returnedCurrentDay,
        ),
        TimeListCalendarWidget(
          initialDate: initialDate,
          currentTime: currentTime,
          returnedCurrentTime: (returnedCurrentTime) =>
              currentTime = returnedCurrentTime,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _help(
                context,
                color: OnlineClinicColorStyle.primary,
                title: 'Available',
              ),
              Gap(8.w),
              _help(
                context,
                color: OnlineClinicColorStyle.dark,
                title: 'Booked',
              ),
            ],
          ),
        ),
        Gap(8.h),
        AppButton.filled(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          onTap: () => selectedDate(
            startDate: DateTime(
              initialDate.year,
              initialDate.month,
              currentDay,
              int.parse(_calculateHourStartTime(currentTime)),
              int.parse(_calculateMinuteStartTime(currentTime)),
            ),
            endDate: DateTime(
              initialDate.year,
              initialDate.month,
              currentDay,
              int.parse(_calculateHourEndTime(currentTime)),
              int.parse(_calculateMinuteEndTime(currentTime)),
            ),
          ),
          label: 'Finalize Your Appointment',
          height: 48.h,
          backgroundColor: OnlineClinicColorStyle.primary,
        ),
      ],
    );
  }

  Widget _help(
    BuildContext context, {
    required Color color,
    required String title,
  }) =>
      Row(
        children: [
          CustomContainer(
            color: color,
            height: 8.h,
            width: 8.w,
            shape: BoxShape.circle,
          ),
          Gap(4.w),
          CustomText(
            text: title,
            textStyle: Theme.of(context).textTheme.labelMedium,
            textColor: OnlineClinicColorStyle.lightGray,
          )
        ],
      );

  Widget _calendarHeader(final BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 16.r, right: 16.r, bottom: 32.r),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: CustomText(
                text: 'Schedule',
                textStyle: Theme.of(context).textTheme.titleMedium,
                textFontWight: TextFontWight.bold,
              ),
            ),
            _getMonth(context),
            Gap(8.w),
            _getYear(context),
          ],
        ),
      );

  Widget _getYear(final BuildContext context) => AppDropDown(
        initValue: yearsModel.firstWhere(
          (element) => element.id == initialDate.year,
        ),
        itemList: yearsModel,
        onSelected: (value) {
          int year = value.id!;
          DateTime tempDate = initialDate;
          initialDate = DateTime(
            year,
            tempDate.month,
            tempDate.day,
            tempDate.hour,
            tempDate.minute,
          );
          monthKey.currentState?.updateWidget(DateTime(
            year,
            tempDate.month,
            tempDate.day,
            tempDate.hour,
            tempDate.minute,
          ));
        },
      );

  Widget _getMonth(final BuildContext context) => AppDropDown(
        initValue: months.singleWhere((element) => element.id == selectedMonth),
        itemList: months,
        onSelected: (value) {
            selectedMonth = value.id;
            DateTime tempDate = initialDate;
            initialDate = DateTime(
              tempDate.year,
              value.id!,
              tempDate.day,
              tempDate.hour,
              tempDate.minute,
            );
            monthKey.currentState?.updateWidget(DateTime(
              tempDate.year,
              value.id!,
              tempDate.day,
              tempDate.hour,
              tempDate.minute,
            ));
        },
      );

  String _calculateHourStartTime(int index) =>
      index % 2 == 0 ? '${index ~/ 2}' : '${index ~/ 2}';

  String _calculateMinuteStartTime(int index) => index % 2 == 0 ? '00' : '30';

  String _calculateHourEndTime(int index) => index % 2 == 0
      ? (index ~/ 2).toString().padLeft(2, "0")
      : ((index ~/ 2) + 1).toString().padLeft(2, "0");

  String _calculateMinuteEndTime(int index) => index % 2 == 0 ? '30' : '00';
}
