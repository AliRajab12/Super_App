import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';

class ProfileRow extends StatelessWidget {
  final String title;
  final String image;
  final bool? divider;
  final bool? hideIcon;
  final VoidCallback? press;
  const ProfileRow(
      {super.key,
      required this.title,
      required this.image,
      this.divider,
      this.press,
      this.hideIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsetsDirectional.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          InkWell(
            onTap: () => press!(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.asset(image),
                      const SizedBox(
                        width: 12,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                hideIcon != null && hideIcon == true
                    ? const SizedBox()
                    : SvgPicture.asset(SvgImages.arrowIcon)
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          divider != null && divider == true
              ? Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 6),
                  child: Container(
                    height: 0.2,
                    color: SomiColors.greyLight,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
