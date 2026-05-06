import 'package:flutter/material.dart';
import 'package:somi/core/theme/constants.dart';

class CustomDropDown<T> extends StatelessWidget {
  final ValueChanged<T?>? onChange;
  final T initialValue;
  final List<DropdownMenuItem<T>> items;
  const CustomDropDown({
    super.key,
    required this.onChange,
    required this.initialValue,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 40,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [kBoxShadow],
          borderRadius: BorderRadius.circular(30)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          value: initialValue,
          isDense: true,
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.grey,
          ),
          style: const TextStyle(
              color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
          items: items,
          onChanged: onChange,
        ),
      ),
    );
  }
}
