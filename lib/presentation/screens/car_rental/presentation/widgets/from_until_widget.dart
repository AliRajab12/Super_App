import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/time_widget.dart';
import 'date_widget.dart';
import 'global.dart';

class FromUntilWidget extends StatefulWidget {
  const FromUntilWidget({
    super.key,
  });

  @override
  State<FromUntilWidget> createState() => _FromUntilWidgetState();
}

class _FromUntilWidgetState extends State<FromUntilWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'From',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: SomiColors.greyLight),
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    'Until',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: SomiColors.greyLight),
                  ),
                ),
              ],
            ),
          ),
          DateWidget(
            bloc: GlobalBloc.carBloc,
          ),
          const SizedBox(
            height: 12,
          ),
          TimeWidget(
            bloc: GlobalBloc.carBloc,
          ),
        ],
      ),
    );
  }
}
