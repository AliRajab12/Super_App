import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/pages/field_worker_profile_page.dart';


class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.iconBackColor,
    this.hasPadding,
    this.onTapBack,
    this.showActionProfile = true,
    this.margin,
    this.action
  });

  final Color? iconBackColor;
  final bool? hasPadding;
  final GestureTapCallback? onTapBack;
  final bool showActionProfile;
  final EdgeInsets? margin;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(1.sw, 35.h),
      child: CustomContainer(
        height: 50.h,
        padding: (hasPadding ?? true)
            ? EdgeInsets.symmetric(horizontal: 16.w)
            : null,
        margin: margin ?? EdgeInsets.only(top: 33.h),
        // color: Colors.red,
        child: Row(
          children: [
            Navigator.of(context).canPop()
                ? CustomImage(
                  imageSvgPath: 'images/svg/arrow-left.svg',
                  onTap: () {
                    if (onTapBack != null) {
                      onTapBack!();
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  svgColor: iconBackColor ?? OnlineClinicColorStyle.dark,
                )
                : const SizedBox.shrink(),
            const Spacer(),
            if(showActionProfile)
              action ?? CustomContainer(
                elevationType: ElevationType.lowElevation,
                child: CustomImage(
                  imageWidth: 32.w,
                  imageHeight: 32.4,
                  onTap: (){
                    // showDialog(
                    //     context: context,
                    //     builder: (context){
                    //       return AlertDialog(
                    //         title: CustomText(
                    //           text: 'Switch Account',
                    //           textStyle: Theme.of(context).textTheme.bodyMedium,
                    //           textFontWight: TextFontWight.bold,
                    //           textColor: Theme.of(context).primaryColor,
                    //         ),
                    //         content: Column(
                    //           mainAxisSize: MainAxisSize.min,
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             InkWell(
                    //               onTap:(){
                    //                 locator<MainRouter>().push( const ClinicHomePageRoute()  );
                    //               },
                    //               child: SizedBox(
                    //                 height: 35,
                    //                 width: 1.sw,
                    //                 child: CustomText(
                    //                   text: 'Guest',
                    //                   textStyle: Theme.of(context).textTheme.bodyMedium,
                    //                   textFontWight: TextFontWight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //
                    //             InkWell(
                    //               onTap:(){
                    //                 locator<MainRouter>().push( UserHomePageRoute()  );
                    //               },
                    //               child: SizedBox(
                    //                 height: 35,
                    //                 width: 1.sw,
                    //                 child: CustomText(
                    //                   text: 'User',
                    //                   textStyle: Theme.of(context).textTheme.bodyMedium,
                    //                   textFontWight: TextFontWight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap:(){
                    //                 locator<MainRouter>().push( DoctorHomePageRoute()  );
                    //               },
                    //               child: SizedBox(
                    //                 height: 35,
                    //                 width: 1.sw,
                    //                 child: CustomText(
                    //                   text: 'Doctor',
                    //                   textStyle: Theme.of(context).textTheme.bodyMedium,
                    //                   textFontWight: TextFontWight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //             InkWell(
                    //               onTap:(){
                    //                 locator<MainRouter>().push( const FieldWorkerProfilePageRoute()  );
                    //               },
                    //               child: SizedBox(
                    //                 height: 35,
                    //                 width: 1.sw,
                    //                 child: CustomText(
                    //                   text: 'Field Worker',
                    //                   textStyle: Theme.of(context).textTheme.bodyMedium,
                    //                   textFontWight: TextFontWight.bold,
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //
                    //       );
                    //     });

                  },
                  imageSvgPath: 'images/svg/profile.svg',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
