import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';

class CallButton extends StatelessWidget {
  const CallButton({super.key , this.width,  this.height , this.padding});
  final double? width;
  final double? height;
  final double? padding;

  @override
  Widget build(BuildContext context) {
    return AppButton.filled(
      label: null,
      height: height?? 40.r,
      widthp: width ?? 40.r,
      backgroundColor: OnlineClinicColorStyle.primary,
      customChild: Padding(
        padding: EdgeInsets.all( padding ?? 8.r),
        child:  CustomImage(
          imageSvgPath: 'images/svg/camera.svg',
          onTap: (){
            CallClass().joinMeeting(
              context: context,
              roomName: Constants.callRoomName,
            );
          },
        ),
      ),
      onTap: () => (){

      },
    );
  }

}
