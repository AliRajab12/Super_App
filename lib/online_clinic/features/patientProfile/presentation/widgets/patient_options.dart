import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class PatientOptions extends StatelessWidget {
  const PatientOptions({super.key, required this.options});

  final List<String> options;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        options.length > 3
            ? Expanded(
                child: _content(),
              )
            : _content()
        //Spacer()
      ],
    );
  }

  CustomContainer _content() {
    return CustomContainer(
      height: 34.h,
      color: OnlineClinicColorStyle.dark1,
      margin: EdgeInsets.only(left: 16.w),
      // boxConstraints: BoxConstraints.loose(Size(10.w, 34.h)),
      borderRadius: BorderRadius.circular(8),
      child: ListView.separated(
        itemCount: options.length,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        //physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Center(
              child: CustomText(
                text: options[index],
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.medium,
                textColor: OnlineClinicColorStyle.white,
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const VerticalDivider(
            color: OnlineClinicColorStyle.gray1,
            thickness: 2,
            endIndent: 6,
            indent: 6,
          );
        },
      ),
    );
  }
}
