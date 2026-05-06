import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';


class UserComment extends StatelessWidget {
  const UserComment(
      {super.key,
      required this.name,
      required this.comment,
      required this.date,
      required this.rate});
  final String name;
  final String comment;
  final String date;
  final double rate;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      // padding: EdgeInsets.all(8.r),
      margin: EdgeInsets.only(right: 16.w,bottom:15),
      borderRadius: BorderRadius.circular(16.r),
      height: 173.h,
      width: 266.w,
      color: OnlineClinicColorStyle.white,
      elevationType: ElevationType.noElevation,

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 16.h , bottom: 8.h , left: 16.w , right: 16.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomImage(
                  imagePngOrJpgPath: 'images/onine_clinic_png/profile.png',
                  imageWidth: 40.w,
                  imageHeight: 40.h,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: name,
                        textStyle: Theme.of(context).textTheme.bodyLarge,
                        textFontWight: TextFontWight.bold,
                      ),
                      SizedBox(height: 4.h),
                      RatingBarIndicator(
                        rating: rate,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: OnlineClinicColorStyle.yellowRating,
                        ),
                        itemCount: 5,
                        itemSize: 12.r,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(top: 5.h),
                  child: CustomText(
                    text: date,
                    textStyle: Theme.of(context).textTheme.labelMedium,
                    textFontWight: TextFontWight.regular,
                    textColor: OnlineClinicColorStyle.lightGray,
                  ),
                )
              ],
            ),
          ),
          // SizedBox(height: 12.h),
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left: 16.w , right: 16.w , bottom: 8.h),
              child: CustomText(
                multiLine: true,
                text: comment,
                textStyle: Theme.of(context).textTheme.bodySmall,
                textColor: OnlineClinicColorStyle.dark1,
              ),
            ),
          )
        ],
      ),
    );
  }
}
