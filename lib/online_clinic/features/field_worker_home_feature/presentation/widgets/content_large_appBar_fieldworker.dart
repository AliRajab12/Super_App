import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class ContentLargeAppBarFieldWorker extends StatefulWidget {
   const ContentLargeAppBarFieldWorker({super.key , required this.onTapOnlineButton});
  final Function(bool isOnline) onTapOnlineButton;

  @override
  State<ContentLargeAppBarFieldWorker> createState() => _ContentLargeAppBarFieldWorkerState();
}

class _ContentLargeAppBarFieldWorkerState extends State<ContentLargeAppBarFieldWorker> {
  TextEditingController searchController = TextEditingController();

  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 16.w,
        bottom: 44.w,
        left: 16.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomAppBar(
            hasPadding: false,
            showActionProfile: false,
            iconBackColor: OnlineClinicColorStyle.white,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Welcome Lucas Martin',
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      textFontWight: TextFontWight.bold,
                      textColor:
                      Theme.of(context).brightness == Brightness.light
                          ? OnlineClinicColorStyle.white
                          : OnlineClinicColorStyle.white,
                    ),
                    Gap(4.h),
                    CustomText(
                      text: 'Have a nice day and great work!',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textFontWight: TextFontWight.regular,
                      textColor:
                      Theme.of(context).brightness == Brightness.light
                          ? OnlineClinicColorStyle.white
                          : OnlineClinicColorStyle.white,
                    ),
                  ],
                ),
              ),
              // if(!showActionAppbar)
              CustomImage(
                imagePngOrJpgPath: 'images/onine_clinic_png/profile.png',
                imageWidth: 40.w,
                imageHeight: 40.h,
              ),
            ],
          ),
          Gap(32.h),

          AppButton.outLined(
              borderColor: OnlineClinicColorStyle.primary,
              customChild: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: isOnline ? 'Offline' : 'Get online to accept appointments',
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    textColor: OnlineClinicColorStyle.primary,
                  ),
                  Gap(
                      16.w
                  ),
                  CustomImage(
                    imageSvgPath:isOnline? 'images/svg/toggle-on-circle.svg': 'images/svg/toggle-off-circle.svg',
                    imageHeight: 20.r,
                    imageWidth: 20.r,
                  )

                ],
              ),
              onTap: (){
                isOnline = !isOnline;
               widget.onTapOnlineButton(isOnline);

              })

          // AppTextField(
          //   controller: searchController,
          //   hintText: 'Search patients’ name or ID ',
          // )
        ],
      ),
    );
  }
}
