import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class CreateOverLayRow extends StatelessWidget {
  const CreateOverLayRow({
    super.key,
    this.imageSvgPath,
    required this.text,
    this.onTap,
    required this.isShowDivider,
    this.width,
  });

  final String? imageSvgPath;

  final double? width;
  final String text;
  final bool isShowDivider;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CustomContainer(
            width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                if(imageSvgPath != null)
                CustomImage(
                  imageSvgPath: imageSvgPath,
                  imageWidth: 15.r,
                  imageHeight: 15.r,
                ),
                if(imageSvgPath != null)
                Gap(8.w),
                Expanded(
                  child: CustomText(
                    text: text,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
        isShowDivider
            ? Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: CustomContainer(
            width: width ?? 100.w,
            height: 1,
            color: OnlineClinicColorStyle.lightGray4,
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}
