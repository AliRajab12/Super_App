import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/utils/size_utils.dart';

class VisaServiceContainer extends StatelessWidget {
  final Color color;
  final double borderRadius;
  final String imagePath;
  final String text;
  final Color textColor;
  final Function() onTap;
  const VisaServiceContainer(
      {super.key,
      required this.color,
      this.borderRadius = 10,
      required this.imagePath,
      required this.text,
      required this.textColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        height: 125,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300, blurRadius: 3, spreadRadius: 0.2)
            ]),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20.v,
              ),
              SvgPicture.asset(imagePath),
              SizedBox(
                height: 15.v,
              ),
              FittedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Text(
                    text,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
