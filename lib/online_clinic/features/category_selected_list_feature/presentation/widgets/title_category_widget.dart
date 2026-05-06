import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/category_entity.dart';

class TitleCategory extends StatelessWidget {
  const TitleCategory({super.key , required this.categoryEntity});
  final CategoryEntity categoryEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomText(
             text: categoryEntity.name,
             textStyle: Theme.of(context).textTheme.bodySmall,
             textColor: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.lightGray : OnlineClinicColorStyle.lightGray,
           ),
           Gap(4.h),
           Row(
             children: [
               Expanded(
                 child: CustomText(
                   text: 'Choose your ${categoryEntity.name}',
                   textStyle: Theme.of(context).textTheme.bodyLarge,
                   // textColor: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.lightGray : OnlineClinicColorStyle.lightGray,
                 ),
               ),
               CustomText(text: 'sort by',
                 textStyle: Theme.of(context).textTheme.labelLarge,
                 textColor: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.lightGray : OnlineClinicColorStyle.lightGray,

               ),
               Gap(
                   3.w
               ),
               const CustomImage(
                 imageSvgPath: 'images/svg/sort.svg',
               )

             ],
           )
         ],

      ),
    );
  }
}
