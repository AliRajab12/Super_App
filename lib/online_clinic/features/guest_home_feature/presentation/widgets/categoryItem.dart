import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/category_selected_list_feature/presentation/pages/category_list_page.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/category_entity.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key , required this.categoryEntity});
  final CategoryEntity categoryEntity;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        locator<MainRouter>().push(CategoryListPageRoute( categoryEntity: categoryEntity)  );
      },
      child: CustomContainer(
        height: 60.h,
        boxConstraints: BoxConstraints(minWidth: 150.w),
        elevationType: ElevationType.noElevation,
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        margin: EdgeInsets.only(left: 16.w , right:  8.w , top:  24.h , bottom: 40.h),
        color: Theme.of(context).brightness == Brightness.light ? OnlineClinicColorStyle.white : OnlineClinicColorStyle.white,
        child: Padding(
          padding: EdgeInsets.only(right: 8.w),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomImage(
                imageHeight: 40.h,
                imageWidth: 60.w,
                imagePngOrJpgPath: categoryEntity.iconPath,
              ),
              CustomText(
                text: categoryEntity.name,
                textStyle: Theme.of(context).textTheme.bodySmall,
                textFontWight: TextFontWight.bold,
              )
            ],
          ),
        ),

      ),
    );
  }
}
