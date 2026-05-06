import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';

class SpecificationItemWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  const SpecificationItemWidget(
      {super.key, required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 8),
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: SomiColors.blue,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: const Offset(2, 4))
            ]),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(imageUrl),
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            )
          ],
        )),
      ),
    );
  }
}
