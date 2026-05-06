import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/diseaseCategories_widget.dart';
import 'package:somi/online_clinic/features/user_home_feature/domain/entity/diseaseCategoryEntity.dart';

class DiseaseCategoryList extends StatelessWidget {
   DiseaseCategoryList({super.key });
  List<DiseaseCategoryEntity> categoryList = [
    DiseaseCategoryEntity(
        title: 'Fever',
        iconPath: 'images/onine_clinic_png/fever.png'
    ), DiseaseCategoryEntity(
        title: 'Cough',
        iconPath: 'images/onine_clinic_png/dry.png'
    ), DiseaseCategoryEntity(
        title: 'Vomit',
        iconPath: 'images/onine_clinic_png/man.png'
    ), DiseaseCategoryEntity(
        title: 'Flu',
        iconPath: 'images/onine_clinic_png/dry.png'
    ), DiseaseCategoryEntity(
        title: 'Cold',
        iconPath: 'images/onine_clinic_png/dry.png'
    ), DiseaseCategoryEntity(
        title: 'Acne',
        iconPath: 'images/onine_clinic_png/dry.png'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return   SizedBox(
      height: 152.w,
      width: 1.sw,

      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          padding: EdgeInsets.only(top: 24.h , bottom: 40.h , left: 16.w , right: 16.w),
          physics: const BouncingScrollPhysics(),
          itemBuilder:(context , index){
            return DiseaseCategoriesWidget(
             diseaseCategoryEntity: categoryList[index],
            );
          }),
    );
  }
}
