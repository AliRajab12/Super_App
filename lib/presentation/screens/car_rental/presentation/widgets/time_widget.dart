import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/colors.dart';
import '../bloc/car_bloc.dart';
import '../bloc/car_event.dart';
import '../bloc/car_state.dart';
import 'dialog_time.dart';

class TimeWidget extends StatelessWidget {
  final CarBloc bloc;
  const TimeWidget({super.key, required this.bloc});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      bloc: bloc,
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                showTimeDialog(
                    context: context,
                    isStart: true,
                    value: state.firstTime,
                    callBack: (value) {
                      bloc.add(SetFirstTimeEvent(firstTime: value));
                    });
              },
              child: Container(
                width: (MediaQuery.of(context).size.width / 2) - 34,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: SomiColors.forestLight1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      state.firstTime!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            InkWell(
              onTap: () {
                showTimeDialog(
                    context: context,
                    isStart: false,
                    value: state.endTime,
                    callBack: (value) {
                      bloc.add(SetLastTimeEvent(lastTime: value));
                    });
              },
              child: Container(
                width: (MediaQuery.of(context).size.width / 2) - 34,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: SomiColors.forestLight1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      state.endTime!,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
