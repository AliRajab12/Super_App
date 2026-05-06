import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class OnlineButton extends StatefulWidget {
  const OnlineButton({super.key , required this.onTapOnlineButton});
  final Function(bool isOnline) onTapOnlineButton;

  @override
  State<OnlineButton> createState() => _OnlineButtonState();
}

class _OnlineButtonState extends State<OnlineButton> {
   bool isOnline = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: 24.h),
      child: AppButton.filled(
            // borderColor: OnlineClinicColorStyle.primary,
            widthp: 198.w,
            customChild: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: isOnline ? 'You are online' : 'You are offline',
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  textColor:isOnline ? OnlineClinicColorStyle.white : OnlineClinicColorStyle.gray,
                ),
                Gap(
                    16.w
                ),
                CustomImage(
                  imageSvgPath:isOnline? 'images/svg/toggle-on-circle.svg': 'images/svg/toggle-off-circle.svg',
                  imageHeight: 20.r,
                  imageWidth: 20.r,
                  svgColor: isOnline ? OnlineClinicColorStyle.white : OnlineClinicColorStyle.gray,
                )

              ],
            ),
            onTap: (){
              isOnline = !isOnline;
              widget.onTapOnlineButton(isOnline);
              setState(() {

              });

            }, label: isOnline ? 'You are online' : 'You are offline',

        backgroundColor: isOnline ? OnlineClinicColorStyle.primary : OnlineClinicColorStyle.lightColor3
        ,),
    );
  }
}
