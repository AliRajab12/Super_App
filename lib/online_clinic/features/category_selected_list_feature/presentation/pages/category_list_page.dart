
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/doctor_list_widet/doctorList.dart';
import 'package:somi/online_clinic/features/category_selected_list_feature/presentation/widgets/title_category_widget.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/category_entity.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/doctor_entity.dart';

@RoutePage()
class CategoryListPage extends StatelessWidget {
   CategoryListPage({super.key , required this.categoryEntity});
  static const route = '/categoryListPage';
  final CategoryEntity categoryEntity;
  TextEditingController searchController = TextEditingController();
   List<DoctorEntity> doctorList = [
     DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),
     DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),
     DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),
     DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),
     DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),   DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),   DoctorEntity(
         name: 'DR. Amelia Rodriguez',
         imagePath: 'images/onine_clinic_png/doctor.png',
         score: '4.5 Reviews',
         experience: '6 years of experience',
         specialist: 'Dentist'
     ),

   ];
  @override
  Widget build(BuildContext context) {
    return CustomBody(
      showAppAppbar: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(21.h),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: AppTextField(
                controller: searchController,
                hintText: 'Search a doctor or medical condition',
              ),
            ),
            Gap(32.h),

            TitleCategory(categoryEntity: categoryEntity,),
            Gap(24.h),
            DoctorList(
              doctorList: doctorList,
              usePadding: false,
              showBookButton: true,
              onTapBookButton: (){
                locator<MainRouter>().push(const DoctorProfilePageRoute()  );

              },
            ),




          ],
        )
    );
  }
}
