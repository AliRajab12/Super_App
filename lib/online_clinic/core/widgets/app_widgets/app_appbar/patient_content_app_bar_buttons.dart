import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';

class PatientContentAppBarButtons extends StatefulWidget {
  const PatientContentAppBarButtons({
    required this.pageState,
    required this.changPageState,
    super.key,
  });

  final FieldWorkerPageStateEnum pageState;
  final void Function(FieldWorkerPageStateEnum) changPageState;

  @override
  State<PatientContentAppBarButtons> createState() =>
      _PatientContentAppBarButtonsState();
}

class _PatientContentAppBarButtonsState
    extends State<PatientContentAppBarButtons> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _appBarElevatedButton(
          context,
          onTap: () => widget.changPageState.call(
            widget.pageState == FieldWorkerPageStateEnum.edit
                ? FieldWorkerPageStateEnum.location
                : FieldWorkerPageStateEnum.edit,
          ),
          svg: widget.pageState == FieldWorkerPageStateEnum.edit
              ? 'images/svg/location_button.svg'
              : 'images/svg/person_button.svg',
        ),
        _appBarElevatedButton(
          context,
          onTap: () => debugPrint('data'),
          svg: 'images/svg/call_button.svg',
        ),
        _appBarElevatedButton(
          context,
          onTap: () => debugPrint('data'),
          svg: 'images/svg/message_button.svg',
        ),
      ],
    );
  }

  Widget _appBarElevatedButton(
    BuildContext context, {
    required void Function() onTap,
    required String svg,
  }) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Padding(
        padding: EdgeInsets.only(
          right: 8.0.w,
          bottom: 8.h,
        ),
        child: InkWell(
          onTap: onTap,
          child: CustomImage(
            imageSvgPath: svg,
            imageHeight: 32.h,
            imageWidth: 32.w,
            svgColor: OnlineClinicColorStyle.primary,
          ),
        ),
      ),
    );
  }
}
