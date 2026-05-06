import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/enums/patient_page_state_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class DoctorBottomAppBarWidget extends StatefulWidget {
  const DoctorBottomAppBarWidget({
    required this.patientPageState,
    required this.changPatientPageState,
    super.key,
  });

  final PatientPageStateEnum patientPageState;
  final void Function(PatientPageStateEnum) changPatientPageState;

  @override
  State<DoctorBottomAppBarWidget> createState() => _DoctorBottomAppBarWidget();
}

class _DoctorBottomAppBarWidget extends State<DoctorBottomAppBarWidget> {
  @override
  Widget build(BuildContext context) => widget.patientPageState ==
          PatientPageStateEnum.appointments
      ? const SizedBox.shrink()
      : Column(
          children: [
            CustomImage(
              imagePngOrJpgPath:
                  widget.patientPageState == PatientPageStateEnum.history
                      ? 'images/onine_clinic_png/doctor_amelia.png'
                      : 'images/onine_clinic_png/field_worker.png',
              imageHeight: 30.h,
              imageWidth: 30.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: widget.patientPageState == PatientPageStateEnum.history
                      ? 'Doctor:'
                      : 'Field Worker:',
                  textStyle: Theme.of(context).textTheme.labelMedium,
                  textFontWight: TextFontWight.bold,
                  textColor: OnlineClinicColorStyle.lightGray4,
                ),
                Gap(2.w),
                CustomText(
                  text: widget.patientPageState == PatientPageStateEnum.history
                      ? 'DR. Amelia Rodriguez'
                      : 'Mathew Wallis',
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  textFontWight: TextFontWight.bold,
                  textColor: OnlineClinicColorStyle.white,
                )
              ],
            ),
          ],
        );
}
