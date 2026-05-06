import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_event.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/global.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_rounded_button.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';

import '../bloc/car_state.dart';
import '../widgets/container_filter_widget.dart';

@RoutePage()
class CarFilterScreen extends StatefulWidget {
  const CarFilterScreen({super.key});

  @override
  State<CarFilterScreen> createState() => _CarFilterScreenState();
}

class _CarFilterScreenState extends State<CarFilterScreen> {
  late List<String> itemList;
  @override
  void initState() {
    itemList = [
      'Bluetooth',
      'speaker',
      'Adjustable Stree',
      'Airbag',
      'Aux',
      'ABS',
      'Fog Lights',
      'Adjustable Streeing',
      'Control'
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: '',
        homeButton: false,
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
          child: BlocBuilder<CarBloc, CarState>(
        bloc: GlobalBloc.carBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Price Range',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                RangeSlider(
                  values: state.rangeValues!,
                  max: 10000,
                  divisions: 80,
                  labels: RangeLabels(
                    state.rangeValues!.start.round().toString(),
                    state.rangeValues!.end.round().toString(),
                  ),
                  activeColor: SomiColors.blue,
                  onChanged: (RangeValues values) {
                    GlobalBloc.carBloc
                        .add(SetRangValuesEvent(rangeValues: values));
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '80 AED',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                    Text(
                      '10000 AED',
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Type',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const ContainerFilterWidget(
                  title: 'Honda',
                ),
                const Text(
                  'Model',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const ContainerFilterWidget(
                  title: '2019',
                ),
                const Text(
                  'Fuel Type',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const ContainerFilterWidget(
                  title: 'Petrol',
                ),
                const Text(
                  'Transmission',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const ContainerFilterWidget(
                  title: 'Automatic',
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 6,
                ),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 3),
                          child: Row(
                            children: [
                              Container(
                                width: 12,
                                height: 12,
                                decoration: (BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: SomiColors.greyLight))),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text('Sedan $index')
                            ],
                          ),
                        );
                      }),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Car Features',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(
                  height: 6,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 16,
                  children: List<Widget>.generate(
                      itemList.length, // place the length of the array here
                      (int i) {
                    return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                  color: SomiColors.grey.withOpacity(0.06),
                                  offset: const Offset(2, 4),
                                  spreadRadius: 2,
                                  blurRadius: 2)
                            ]),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 6, horizontal: 16),
                          child: Text(itemList[i]),
                        ));
                  }).toList(),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundedButton(
                      height: 45,
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      backgroundColor: SomiColors.blue,
                      text: 'Apply',
                      textColor: Colors.white,
                      pressed: () {
                        locator<MainRouter>()
                            .navigate(const IdentifyScreenRoute());
                      },
                    ),
                    CustomRoundedButton(
                      height: 45,
                      width: (MediaQuery.of(context).size.width / 2) - 20,
                      backgroundColor: Colors.white,
                      pressed: () {
                        Navigator.of(context).pop();
                      },
                      text: 'Cancel',
                      textColor: SomiColors.blue,
                    )
                  ],
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
