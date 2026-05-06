import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';

class ContainerFilterWidget extends StatelessWidget {
  final String title;
  const ContainerFilterWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(bottom: 16, top: 8),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 45,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(120),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  blurRadius: 3,
                  spreadRadius: 3,
                  color: Colors.grey.withOpacity(0.1),
                  offset: const Offset(2, 4))
            ]),
        child: Padding(
          padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: SomiColors.grey,
                ),
              ),
              const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    size: 14,
                    color: SomiColors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
