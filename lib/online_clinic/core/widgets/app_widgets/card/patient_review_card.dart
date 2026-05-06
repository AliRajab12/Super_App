import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class PatientsReviewCard extends StatelessWidget {
  const PatientsReviewCard(
      {super.key,
      required this.name,
      required this.comment,
      required this.date,
      required this.rate,
      required this.height,
      required this.width,
      required this.margin});
  final String name;
  final String comment;
  final String date;
  final double rate;
  final double height;
  final double width;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      elevationType: ElevationType.lowElevation,
      padding: EdgeInsets.all(16.r),
      margin: margin,
      borderRadius: BorderRadius.circular(16.r),
      // height: height,
      width: width,
      color: OnlineClinicColorStyle.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CustomImage(
                imagePngOrJpgPath: 'images/onine_clinic_png/profile.png',
                imageWidth: 40.w,
                imageHeight: 40.h,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    textFontWight: TextFontWight.bold,
                  ),
                  Gap(4.h),
                  RatingBarIndicator(
                    rating: rate,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: OnlineClinicColorStyle.yellowRating,
                    ),
                    itemCount: 5,
                    itemSize: 7.0,
                    direction: Axis.horizontal,
                  ),
                ],
              ),
              CustomText(
                text: date,
                textColor: OnlineClinicColorStyle.lightGray,
                textStyle: Theme.of(context).textTheme.labelMedium,
                textFontWight: TextFontWight.regular,
              )
            ],
          ),
          SizedBox(height: 12.w),
          CustomText(
            multiLine: true,
            text: comment,
            textStyle: Theme.of(context).textTheme.bodySmall,
            textFontWight: TextFontWight.regular,
          )
        ],
      ),
    );
  }
}
