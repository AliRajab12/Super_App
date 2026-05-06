import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class UneditableTextField extends StatelessWidget {
  const UneditableTextField({
    required this.label,
    required this.value,
    this.width,
    super.key,
  });

  final String label;
  final String value;
  final double? width;

  @override
  Widget build(BuildContext context) => CustomContainer(
        border: Border.all(
          color: OnlineClinicColorStyle.dark1,
        ),
        width: width,
        height: 41.h,
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 6.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                text: '$label : ',
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.bold,
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.w),
                child: CustomText(
                  text: value,
                  textStyle: Theme.of(context).textTheme.bodySmall,
                  // textFontWight: TextFontWight.bold,
                ),
              ),
            ],
          ),
        ),
      );
}
