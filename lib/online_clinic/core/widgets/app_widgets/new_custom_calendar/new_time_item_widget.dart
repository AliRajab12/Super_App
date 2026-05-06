import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class NewTimeItemWidget extends StatelessWidget {
  const NewTimeItemWidget({
    required this.isBooked,
    required this.index,
    super.key,
  });

  final int index;
  final bool isBooked;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.r),
      child: CustomContainer(
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        border:
            isBooked ? null : Border.all(color: OnlineClinicColorStyle.primary),
        height: 40.h,
        width: 92.w,
        color: isBooked ? OnlineClinicColorStyle.lightColor3 : null,
        child: Center(
          child: CustomText(
            text: '1$index:00',
            textColor: isBooked
                ? OnlineClinicColorStyle.gray1
                : OnlineClinicColorStyle.primaryDark1,
            textStyle: Theme.of(context).textTheme.bodyLarge,
            textFontWight: TextFontWight.bold,
          ),
        ),
      ),
    );
  }
}
