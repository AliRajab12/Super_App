import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key ,
    required this.title ,
    required this.subtitle ,
    this.iconSvgPath,
    this.action,
    this.onTapSeeAll,
    this.iconPngOrJpg
  });
  final String title;
  final String subtitle;
  final String? iconSvgPath;
  final String? iconPngOrJpg;
  final Widget? action;
  final GestureTapCallback? onTapSeeAll;

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height:22.h,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(text: title,
                        textStyle: Theme.of(context).textTheme.bodyLarge ,
                        textFontWight: TextFontWight.bold,
                      ),
                      if(iconSvgPath != null || iconPngOrJpg != null)
                      Container(
                        margin:EdgeInsets.only(bottom: 2.h),
                        child: CustomImage(
                          imageSvgPath: iconSvgPath,
                          imagePngOrJpgPath: iconPngOrJpg,
                          imageWidth: 25.r,
                          imageHeight: 25.r,
                        ),
                      )
                    ],
                  ),
                ),
                if(subtitle !='')
                Gap(4.h),
                if(subtitle !='')
                CustomText(
                  text: subtitle,
                  textStyle: Theme.of(context).textTheme.bodySmall ,
                ),

              ],
            ),
          ),
          action ??  InkWell(
            onTap: onTapSeeAll,
            child:
                CustomText(text: 'see all',
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                  textColor: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.lightGray : OnlineClinicColorStyle.lightGray,

                ),
          )
        ],
      ),
    );
  }
}
