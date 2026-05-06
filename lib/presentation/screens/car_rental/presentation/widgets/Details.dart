import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/utility.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_event.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_state.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/dialog_time.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../pages/map.dart';
import 'Navigator.dart';

class Details extends StatelessWidget {
  final String type;
  final BuildContext context2;
  const Details({super.key, required this.type, required this.context2});

  @override
  Widget build(BuildContext context) {
    final carBloc = locator<CarBloc>();
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(children: [
          ListTile(
            tileColor: Colors.white,
            leading:
                const Icon(Icons.calendar_today_outlined, color: kTextColor),
            title: Text(
                Utility.getDateTimeFromUTC(type == 'Delivery'
                    ? carBloc.state.firstDate!
                    : carBloc.state.endDate!),
                style: kPrice),
            trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        child: SfDateRangePicker(
                          onSelectionChanged: (args) {
                            PickerDateRange date = args.value;
                            carBloc.add(SetDateDurationEvent(
                              firstDate: date.startDate ?? DateTime.now(),
                              lastDate: date.endDate ?? DateTime.now(),
                            ));
                          },
                          view: DateRangePickerView.month,
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
                  ).then((value) => showTimeDialog(
                      context: context,
                      isStart: true,
                      value: carBloc.state.firstTime,
                      callBack: (value) {
                        if (type == 'Delivery') {
                          carBloc.add(SetFirstTimeEvent(firstTime: value));
                        } else {
                          carBloc.add(SetLastTimeEvent(lastTime: value));
                        }
                      }));
                },
                icon: const Icon(Icons.edit, color: kTextColor)),
            subtitle: Text(
                type == 'Delivery'
                    ? carBloc.state.firstTime!
                    : carBloc.state.endTime!,
                style: kCarDetails),
          ),
          // )
          if (type == 'Delivery')
            BlocBuilder<CarBloc, CarState>(
                bloc: carBloc,
                builder: (_, item) => ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.location_on, color: kTextColor),
                      title: Text(
                          carBloc.state.deliveryAddress?.title ??
                              'Enter Your $type Location',
                          style: kPrice),
                      trailing: IconButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                map(
                                    title: 'Delivery',
                                    context2: context2,
                                    llg2: carBloc.state.deliveryAddress!.lng ==
                                                null ||
                                            carBloc.state.deliveryAddress!
                                                    .lat ==
                                                null
                                        ? null
                                        : LatLng(
                                            carBloc.state.deliveryAddress!.lat!,
                                            carBloc
                                                .state.deliveryAddress!.lng!)));
                          },
                          icon: const Icon(Icons.edit, color: kTextColor)),
                    )),
          if (type != 'Delivery')
            BlocBuilder<CarBloc, CarState>(
                bloc: carBloc,
                builder: (_, item) => ListTile(
                      tileColor: Colors.white,
                      leading: const Icon(Icons.location_on, color: kTextColor),
                      title: Text(
                          item.returnAddress?.title ??
                              'Enter Your $type Location',
                          style: kPrice),
                      trailing: IconButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                map(
                                    title: 'Return',
                                    context2: context2,
                                    llg2: item.returnAddress!.lng == null ||
                                            item.returnAddress!.lat == null
                                        ? null
                                        : LatLng(item.returnAddress!.lat!,
                                            item.returnAddress!.lng!)));
                          },
                          icon: const Icon(Icons.edit, color: kTextColor)),
                    ))
        ]));
  }
}
