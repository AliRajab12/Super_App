import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final double height;
  final String title;
  final Function() tap;

  const CustomButton(
      {super.key,
      required this.height,
      required this.title,
      required this.tap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: tap,
        child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: kPrimaryColor, borderRadius: BorderRadius.circular(25)),
            height: height,
            child: Center(
                child: title.isEmpty
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(title,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center))));
  }
}
