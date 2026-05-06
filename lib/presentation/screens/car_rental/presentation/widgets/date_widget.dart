import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../core/theme/colors.dart';
import '../../../../../core/theme/svg_images.dart';
import '../../../../../core/utils/utility.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_event.dart';
import '../bloc/car_state.dart';

class DateWidget extends StatefulWidget {
  final CarBloc bloc;
  const DateWidget({super.key, required this.bloc});

  @override
  State<DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<DateWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      bloc: widget.bloc,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SfDateRangePicker(
                          onSelectionChanged: (args) {
                            PickerDateRange date = args.value;
                            widget.bloc.add(SetDateDurationEvent(
                              firstDate: date.startDate ?? DateTime.now(),
                              lastDate: date.endDate ??
                                  date.startDate ??
                                  DateTime.now(),
                            ));
                          },
                          view: DateRangePickerView.month,
                          enablePastDates: false,
                          showActionButtons: true,
                          onSubmit: (v) {
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - 34,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: SomiColors.forestLight1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Utility.getDateTimeFromUTC(state.firstDate!),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(SvgImages.datePickerIcon)
                      ],
                    ),
                  ),
                )),
            const SizedBox(
              width: 12,
            ),
            InkWell(
                onTap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SfDateRangePicker(
                          onSelectionChanged: (args) {
                            PickerDateRange date = args.value;
                            widget.bloc.add(SetDateDurationEvent(
                                firstDate: date.startDate ?? DateTime.now(),
                                lastDate: date.endDate ??
                                    date.startDate ??
                                    DateTime.now()));
                          },
                          view: DateRangePickerView.month,
                          enablePastDates: false,
                          showActionButtons: true,
                          onSubmit: (v) {
                            Navigator.of(context).pop();
                          },
                          onCancel: () {
                            Navigator.of(context).pop();
                          },
                          selectionMode: DateRangePickerSelectionMode.range,
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  width: (MediaQuery.of(context).size.width / 2) - 34,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      color: SomiColors.forestLight1),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          Utility.getDateTimeFromUTC(state.endDate!),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(SvgImages.datePickerIcon)
                      ],
                    ),
                  ),
                ))
          ],
        );
      },
    );
  }
}
