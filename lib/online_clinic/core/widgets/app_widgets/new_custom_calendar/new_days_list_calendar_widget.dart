
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/day_model.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/new_date_item_widget.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/new_time_item_widget.dart';

class NewDaysListCalendarWidget extends StatefulWidget {
  NewDaysListCalendarWidget({
    required this.initialDate,
    required this.returnedCurrentDay,
    super.key,
  });

  final void Function(int) returnedCurrentDay;
  DateTime initialDate;

  @override
  State<NewDaysListCalendarWidget> createState() =>
      NewDaysListCalendarWidgetState();
}

class NewDaysListCalendarWidgetState extends State<NewDaysListCalendarWidget> {
  bool sss = false;
  int freeSlots = 5;

  List<DayModel> daysList = [];

  @override
  void initState() {
    for (var i = 0; i < countOfDaysInMonth(); ++i) {
      daysList.add(
        DayModel(
          day: i+1,
          freeSlot: _getFreeSlots(i),
          weekName: DateFormat(DateFormat.ABBR_WEEKDAY).format(DateTime(
            widget.initialDate.year,
            widget.initialDate.month,
            i + 1,
          )),
        ),
      );
    }
    super.initState();
  }

  int _getFreeSlots(int index) {
    if (index % 5 == 0) {
      return 0;
    }
    return ((index - 1) % 8) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _daysList(),
        _times(),
      ],
    );
  }

  Widget _times() => SizedBox(
        width: 1.sw,
        height: 119.h,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          child: Wrap(
            spacing: 0.r,
            alignment: WrapAlignment.start,
            children: List.generate(
              freeSlots,
              (index) => NewTimeItemWidget(
                isBooked: index % 2 == 0,
                index: index,
              ),
            ),
          ),
        ),
      );

  SizedBox _daysList() {
    return SizedBox(
      height: 136.h,
      width: 1.sw,
      child: CarouselSlider.builder(
        itemCount: countOfDaysInMonth(),
        options: CarouselOptions(
          viewportFraction: 0.16,
          scrollPhysics: const BouncingScrollPhysics(),
          initialPage: widget.initialDate.day - 1,
          enableInfiniteScroll: false,
          pageSnapping: true,
          onPageChanged: (index, reason) => setState(() {
            freeSlots = daysList[index].freeSlot;
            DateTime tempDate = widget.initialDate;
            widget.initialDate = DateTime(
              tempDate.year,
              tempDate.month,
              index + 1,
            );
          }),
        ),
        itemBuilder: (context, index, realIndex) {
          return NewDateItemWidget(
            index: index,
            model: daysList[index],
            date: widget.initialDate,
            isBooked: index % 2 == 0,
          );
        },
      ),
    );
  }

  void updateWidget(DateTime newDate) {
    if (newDate != widget.initialDate) {
      setState(() {
        widget.initialDate = newDate;
      });
    }
  }

  int countOfDaysInMonth() {
    DateTime firstDayOfMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month, 1);
    DateTime firstDayOfNextMonth =
        DateTime(widget.initialDate.year, widget.initialDate.month + 1, 1);
    Duration difference = firstDayOfNextMonth.difference(firstDayOfMonth);

    return difference.inDays;
  }
}
