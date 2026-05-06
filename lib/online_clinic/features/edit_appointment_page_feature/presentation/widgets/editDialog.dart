import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class EditDialog extends StatelessWidget {
  const EditDialog({super.key, required this.initValue ,required this.title});
  final String initValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController(
      text: initValue
    );
    return AppTextField(
      showPrefix: false,
      showSuffix: false,
      borderRadius: 10.r,
      contentPadding: EdgeInsets.symmetric(horizontal: 10.w , vertical: 11.h),
      height: 40.h,
      borderColor: Colors.transparent,
      controller: controller,

    );
  }
}
