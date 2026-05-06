import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_calendar/time_item_widget.dart';


class TimeListCalendarWidget extends StatefulWidget {
  TimeListCalendarWidget({
    required this.initialDate,
    required this.currentTime,
    required this.returnedCurrentTime,
    super.key,
  });

  final void Function(int) returnedCurrentTime;
  int currentTime;
  DateTime initialDate;

  @override
  State<TimeListCalendarWidget> createState() => _DaysListCalendarWidgetState();
}

class _DaysListCalendarWidgetState extends State<TimeListCalendarWidget> {
  int currentTime = 0;
  @override
  void initState() {
    super.initState();
    currentTime = widget.currentTime +1;
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1.sw,
      height: 119.h,
      child: CarouselSlider.builder(
        itemCount: 48,
        options: CarouselOptions(
          viewportFraction: 0.18,
          scrollPhysics: const BouncingScrollPhysics(),
          initialPage: widget.currentTime ,
          enableInfiniteScroll: false,
          pageSnapping: true,
          onPageChanged: (index, reason) => setState(() {
            widget.returnedCurrentTime.call(index);
            currentTime = index +1;
            DateTime tempDate = widget.initialDate;
            widget.initialDate = DateTime(
              tempDate.year,
              tempDate.month,
              tempDate.day,
              int.parse(_calculateHourStartTime(widget.currentTime)),
              int.parse(_calculateMinuteStartTime(widget.currentTime)),
            );
          }),
        ),
        itemBuilder: (context, index, realIndex) => TimeItemWidget(
          index: index,
          currentTime: currentTime -1,
          date: widget.initialDate,
          isBooked: index % 2 == 0,
        ),
      ),
    );
  }

  String _calculateHourStartTime(int index) =>
      index % 2 == 0 ? '${index ~/ 2}' : '${index ~/ 2}';

  String _calculateMinuteStartTime(int index) => index % 2 == 0 ? '00' : '30';

}
