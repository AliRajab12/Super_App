import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/category_entity.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/widgets/categoryItem.dart';

class CategoryWidget extends StatelessWidget {
   CategoryWidget({super.key});
  
  List<CategoryEntity> categoryList = [
    CategoryEntity(name: "Neurology",
        iconPath: "images/onine_clinic_png/neurology.png"),
    CategoryEntity(name: "Dentist",
        iconPath: "images/onine_clinic_png/dentist.png"),
    CategoryEntity(name: "Cardiology",
        iconPath: "images/onine_clinic_png/cardiology.png"),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Padding(
        //   padding:  EdgeInsets.symmetric(horizontal: 16.w),
        //   child: Row(
        //     children: [
        //       CustomText(text: "Categories",
        //         textStyle: Theme.of(context).textTheme.bodyLarge ,
        //       textFontWight: TextFontWight.bold,
        //       ),
        //       const Expanded(child: SizedBox()),
        //       AppButton.text(
        //         labelStyle: Theme.of(context).textTheme.labelLarge,
        //           labelColor: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.lightGray : OnlineClinicColorStyle.lightGray,
        //           label: "see all",
        //           onTap: (){
        //
        //       })
        //     ],
        //   ),
        // ),
        // Gap(4.h),
        // Padding(
        //   padding:  EdgeInsets.symmetric(horizontal: 16.w),
        //   child: CustomText(
        //       text: "Choose your specialist or medical condition ",
        //       textStyle: Theme.of(context).textTheme.bodySmall,
        //   ),
        // ),

        const TitleWidget(title: 'Categories', subtitle: 'Choose your specialist or medical condition '),


        SizedBox(
          height: 114.w,
          width: 1.sw,

          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: categoryList.length,
              physics: const BouncingScrollPhysics(),
              itemBuilder:(context , index){
            return CategoryItem(
              categoryEntity: categoryList[index],
            );
          }),
        )

      ],

    );
  }
}
