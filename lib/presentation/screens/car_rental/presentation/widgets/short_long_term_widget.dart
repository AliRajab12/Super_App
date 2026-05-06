import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';

class ShortLongTermWidget extends StatelessWidget {
  final bool selected;
  final bool isShort;
  const ShortLongTermWidget(
      {super.key, required this.selected, required this.isShort});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: [
            Text(
              isShort ? 'Short Term' : 'Long Term',
              style: TextStyle(
                  color: selected ? Colors.white : SomiColors.greySecondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              isShort ? 'Days and week' : '+1 Month',
              style: TextStyle(
                  color: selected ? Colors.white : SomiColors.greySecondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ),
    );
  }
}
