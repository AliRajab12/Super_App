import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';

class FacilityItemWidget extends StatelessWidget {
  final String image;
  final String title;
  final String? subTitle;
  const FacilityItemWidget(
      {super.key, required this.image, required this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 8),
            child: SvgPicture.asset(image),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: SomiColors.grey,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 80,
                child: const Text(
                  'Lorem ipsum dolor sit amet consectetur. Turpis magna auctor suspendisse faucibus arcu rutrum.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: SomiColors.greySecondary),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
