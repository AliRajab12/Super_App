import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/patient_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/models/appointment.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/doctor_bottom_app_bar_widget.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/patient_content_app_bar_buttons.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/call_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_calendar/select_appointment.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/healthy_widget.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/healthy_entity.dart';

class PatientContentLargeAppBar extends StatelessWidget {
  PatientContentLargeAppBar({
    required this.userType,
    this.patientPageState,
    this.fieldWorkerPageState,
    this.changePatientPageState,
    this.changeFieldWorkerPageState,
    super.key,
  });

  final TextEditingController searchController = TextEditingController();
  final List<HealthyEntity> healthyList = [
    HealthyEntity(title: 'Age', value: '30'),
    HealthyEntity(title: 'Gender', value: 'Male'),
    HealthyEntity(title: 'Height', value: '180'),
    HealthyEntity(title: 'Weight', value: '90'),
    HealthyEntity(title: 'Blood', value: 'AB+'),
  ];

  final UserTypeEnum userType;
  final FieldWorkerPageStateEnum? fieldWorkerPageState;
  final PatientPageStateEnum? patientPageState;
  final void Function(FieldWorkerPageStateEnum)? changeFieldWorkerPageState;
  final void Function(PatientPageStateEnum)? changePatientPageState;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomAppBar(
          hasPadding: true,
          showActionProfile: userType == UserTypeEnum.doctor,
          iconBackColor: OnlineClinicColorStyle.white,
          margin: EdgeInsets.only(top: 10.h),
          action: CallButton(
            width: 80.r,
            height: 35.r,
            padding: 5.r,
          ),
        ),
        CustomImage(
          imagePngOrJpgPath: 'images/onine_clinic_png/profile.png',
          imageWidth: 60.r,
          imageHeight: 60.r,
        ),
        Gap(8.h),
        CustomText(
          text: 'Sophia Brown',
          textStyle: Theme.of(context).textTheme.titleLarge,
          textFontWight: TextFontWight.bold,
          textColor: Theme.of(context).brightness == Brightness.light
              ? OnlineClinicColorStyle.white
              : OnlineClinicColorStyle.white,
        ),
        Gap(4.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (userType != UserTypeEnum.fieldWorker)
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SelectAppoitmentDialog(
                        onSelectDate: (selected) {
                          logger.w(selected);
                          Navigator.pop(context);
                        },
                        years: [
                          DropDownModel(title: '2024'),
                          DropDownModel(title: '2023'),
                        ],
                        appointments: [...Appointment.generateFakeData()],
                      );
                    },
                  );
                },
                child: CustomImage(
                  imageSvgPath: 'images/svg/green_calendar.svg',
                  imageWidth: 19.w,
                  imageHeight: 18.5.h,
                ),
              ),
            Gap(2.5.w),
            CustomText(
              text: 'March 13, 2024, 10:00',
              textStyle: Theme.of(context).textTheme.labelLarge,
              textFontWight: TextFontWight.medium,
              textColor: Theme.of(context).brightness == Brightness.light
                  ? OnlineClinicColorStyle.white
                  : OnlineClinicColorStyle.white,
            ),
            CustomText(
              text: 'AM',
              textStyle: Theme.of(context).textTheme.labelSmall,
              textFontWight: TextFontWight.medium,
              textColor: Theme.of(context).brightness == Brightness.light
                  ? OnlineClinicColorStyle.white
                  : OnlineClinicColorStyle.white,
            ),
            Gap(2.w),
            CustomImage(
              imageSvgPath: 'images/svg/timer.svg',
              svgColor: OnlineClinicColorStyle.white,
              imageWidth: 15.r,
              imageHeight: 15.r,
            )
          ],
        ),
        Gap(24.h),
        SizedBox(
          height: 48.h,
          // width: 1.sw,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: healthyList.length,
              itemBuilder: (context, index) {
                return HealthyWidget(
                  healthyEntity: healthyList[index],
                  userType: userType,
                );
              }),
        ),
        Gap(16.h),
        userType == UserTypeEnum.fieldWorker
            ? PatientContentAppBarButtons(
                pageState:
                    fieldWorkerPageState ?? FieldWorkerPageStateEnum.edit,
                changPageState: (pageState) => changeFieldWorkerPageState!.call(
                  pageState,
                ),
              )
            : userType == UserTypeEnum.doctor
                ? DoctorBottomAppBarWidget(
                    patientPageState:
                        patientPageState ?? PatientPageStateEnum.medicalReport,
                    changPatientPageState: (pageState) =>
                        changePatientPageState!.call(
                      pageState,
                    ),
                  )
                : const SizedBox.shrink(),
        Gap(27.h),
      ],
    );
  }
}
