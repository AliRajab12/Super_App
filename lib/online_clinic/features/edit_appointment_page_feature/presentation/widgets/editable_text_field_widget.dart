import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class EditableTextFieldWidget extends StatelessWidget {
  const EditableTextFieldWidget({
    required this.controller,
    required this.label,
    this.textInputType,
    super.key,
  });

  final TextEditingController controller;
  final TextInputType? textInputType;
  final String label;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 41.h,
        width: double.infinity,
        child: TextField(
          controller: controller,
          keyboardType: textInputType,
          style: Theme.of(context).textTheme.bodySmall,
          decoration: InputDecoration(
            prefix: CustomText(
              text: '$label : ',
              textStyle: Theme.of(context).textTheme.bodyMedium,
              textFontWight: TextFontWight.bold,
            ),
            // label: CustomText(
            //   text: '$label : ',
            //   textStyle: Theme.of(context).textTheme.bodyMedium,
            //   textFontWight: TextFontWight.bold,
            // ),
            contentPadding: EdgeInsets.only(
              bottom: 16.h,
              right: 8.w,
              left: 8.w,
            ),
            suffix: const CustomImage(
              imageSvgPath: 'images/svg/underline_edit.svg',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4.r),
              ),
            ),
            focusColor: Colors.red
          ),
        ),
      );
}
