import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../../../../core/utils/utility.dart';
import '../bloc/car_event.dart';
import '../bloc/car_state.dart';
import 'from_until_widget.dart';
import 'global.dart';

class DetailsDateWidget extends StatefulWidget {
  const DetailsDateWidget({super.key});

  @override
  State<DetailsDateWidget> createState() => _DetailsDateWidgetState();
}

class _DetailsDateWidgetState extends State<DetailsDateWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
        bloc: GlobalBloc.carBloc,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(2, 4),
                        blurRadius: 3,
                        spreadRadius: 3)
                  ]),
              child: state.openUpdate == true
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 16, end: 16, top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Edit time',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  GlobalBloc.carBloc
                                      .add(OpenUpdateEvent(value: false));
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const FromUntilWidget(),
                      ],
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(SvgImages.datePickerIcon),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 130,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Utility.getDateTimeFromUTC(
                                                  state.firstDate!),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              Utility.getDateTimeFromUTC(
                                                  state.endDate!),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 80,
                                                child: TextScroll(
                                                  state.firstTime ?? '',
                                                  mode: TextScrollMode.bouncing,
                                                  velocity: const Velocity(
                                                      pixelsPerSecond:
                                                          Offset(150, 0)),
                                                  delayBefore: const Duration(
                                                      milliseconds: 2500),
                                                  numberOfReps: 5,
                                                  pauseBetween: const Duration(
                                                      milliseconds: 500),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
                                                  selectable: true,
                                                )),
                                            SizedBox(
                                                width: 80,
                                                child: TextScroll(
                                                  state.endTime ?? '',
                                                  mode: TextScrollMode.bouncing,
                                                  velocity: const Velocity(
                                                      pixelsPerSecond:
                                                          Offset(150, 0)),
                                                  delayBefore: const Duration(
                                                      milliseconds: 2500),
                                                  numberOfReps: 5,
                                                  pauseBetween: const Duration(
                                                      milliseconds: 500),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                  textAlign: TextAlign.left,
                                                  selectable: true,
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      GlobalBloc.carBloc
                                          .add(OpenUpdateEvent(value: true));
                                    },
                                    child: SvgPicture.asset(
                                      SvgImages.editIcon,
                                      color: SomiColors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          );
        });
  }
}
