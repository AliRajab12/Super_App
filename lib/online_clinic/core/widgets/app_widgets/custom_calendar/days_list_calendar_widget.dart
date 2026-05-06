import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_calendar/date_item_widget.dart';

class DaysListCalendarWidget extends StatefulWidget {
  DaysListCalendarWidget({
    required this.initialDate,
    required this.returnedCurrentDay,
    super.key,
  });

  final void Function(int) returnedCurrentDay;
  DateTime initialDate;

  @override
  State<DaysListCalendarWidget> createState() => DaysListCalendarWidgetState();
}

class DaysListCalendarWidgetState extends State<DaysListCalendarWidget> {
 bool sss = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 116.h,
      width: 1.sw,
      child: CarouselSlider.builder(
        itemCount: countOfDaysInMonth(),
        options: CarouselOptions(
          viewportFraction: 0.18,
          scrollPhysics: const BouncingScrollPhysics(),
          initialPage: widget.initialDate.day -1,
          enableInfiniteScroll: false,
          pageSnapping: true,
          onPageChanged: (index, reason) => setState(() {
            widget.returnedCurrentDay.call(index + 1);
            DateTime tempDate = widget.initialDate;
            widget.initialDate = DateTime(
              tempDate.year,
              tempDate.month,
              index +1,
            );
          }),
        ),
        itemBuilder: (context, index, realIndex) => DateItemWidget(
          index: index,
          date: widget.initialDate,
          isBooked: index % 2 == 0,
        ),
      ),
    );
  }

  void updateWidget(DateTime newDate){
    if(newDate != widget.initialDate){
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
