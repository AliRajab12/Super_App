import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_event.dart';

class Options extends StatelessWidget {
  final String name;
  final List list;

  const Options({super.key, required this.name, required this.list});

  @override
  Widget build(BuildContext context) {
    final carBloc = locator<CarBloc>();
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(name, style: kPrice))),
        if (name == 'Driver')
          Column(
              children: list
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ListTile(
                        tileColor: Colors.white,
                        onTap: () {
                          carBloc.add(
                              SetDriverOptionEvent(index: list.indexOf(e)));
                        },
                        title: Text(e[0], style: kPrice),
                        trailing: Icon(Icons.radio_button_checked,
                            color: carBloc.state.driverOption == list.indexOf(e)
                                ? kPrimaryColor
                                : kTextColor),
                        subtitle: Text(e[1], style: kDelivery),
                      )))
                  .toList()),
        if (name != 'Driver')
          Column(
              children: list
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ListTile(
                        tileColor: Colors.white,
                        onTap: () {
                          carBloc.add(
                              SetDeliveryOptionEvent(index: list.indexOf(e)));
                        },
                        title: Text(e[0], style: kPrice),
                        trailing: Icon(Icons.radio_button_checked,
                            color:
                                carBloc.state.deliveryOption == list.indexOf(e)
                                    ? kPrimaryColor
                                    : kTextColor),
                        subtitle: Text(e[1], style: kDelivery),
                      )))
                  .toList()),
      ],
    );
  }
}
