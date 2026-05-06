import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/dropDown/app_drop_down.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/new_days_list_calendar_widget.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class NewCustomCalendar extends StatelessWidget {
  NewCustomCalendar({
    required this.selectedDate,
    DateTime? initialDate,
    super.key,
  }) : initialDate = initialDate ?? DateTime.now();

  DateTime initialDate;

  final List<DropDownModel> yearsModel = [];
  final List<DropDownModel> months = [];
  int? selectedMonth;
  int freeSlots = 1;
  GlobalKey<NewDaysListCalendarWidgetState> monthKey = GlobalKey();

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
    selectedMonth = initialDate.month;
    return Column(
      children: [
        _calendarHeader(context),
        NewDaysListCalendarWidget(
          key: monthKey,
          initialDate: initialDate,
          returnedCurrentDay: (_) {},
        ),
        Gap(8.h),
      ],
    );
  }

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
}
