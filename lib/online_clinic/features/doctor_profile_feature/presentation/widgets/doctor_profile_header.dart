import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class DoctorProfileHeader extends StatelessWidget {
  const DoctorProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: const EdgeInsets.all(0),
      width: 430.w,
      height: 293.h,
      color: OnlineClinicColorStyle.dark,
      decorationImage: const DecorationImage(
        image: AssetImage('images/onine_clinic_png/doctor_container_back.png'),
        fit: BoxFit.fill,
      ),
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32.r),
          bottomRight: Radius.circular(32.r)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: CustomAppBar(
              iconBackColor: OnlineClinicColorStyle.white,
              showActionProfile: false,
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0.r,
                horizontal: 16.0.r,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: 'Doctor name',
                      textColor: Colors.white,
                      textFontWight: TextFontWight.bold,
                      textStyle: Theme.of(context).textTheme.titleSmall),
                  SizedBox(height: 4.h),
                  CustomText(
                    text: 'Expertise',
                    textColor: Colors.white,
                    textStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 12.w,
            //  left: 100,
            top: -90.h,
            child: Transform.flip(
              flipX: false,
              child: CustomImage(
                imagePngOrJpgPath:
                    'images/onine_clinic_png/dr_without_back.png',
                imageWidth: 314.w,
                imageHeight: 471.h,
                boxFit: BoxFit.cover,
                // alignment: Alignment.centerRight,
              ),
            ),
          )
        ],
      ),
    );
  }
}
