import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_type_enum.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/domain/entities/field_worker_appointment_entity.dart';

class FieldWorkerAppointmentCardWidget extends StatelessWidget {
  const FieldWorkerAppointmentCardWidget({
    required this.appointment,
    required this.makeCallTap,
    super.key,
  });

  final FieldWorkerAppointmentEntity appointment;
  final void Function() makeCallTap;

  @override
  Widget build(BuildContext context) => CustomContainer(
        width: 398.w,
        height: 136.h,
        color: OnlineClinicColorStyle.white,
        elevationType: ElevationType.noElevation,
        borderRadius: BorderRadius.all(
          Radius.circular(16.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _body(context),
            Row(
              children: [
                Expanded(child: _address(context)),
                Gap(15.w),
                _selectLocation(context),
              ],
            ),
          ],
        ),
      );

  Widget _body(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(),
          Expanded(child: _content(context)),
        ],
      );

  Widget _image() => Padding(
        padding: EdgeInsets.only(left: 8.w, top: 8.h, bottom: 8.h),
        child: CustomImage(
          imagePngOrJpgPath: appointment.avatar,
          imageHeight: 80.h,
          showFullScreen: true,
          imageWidth: 60.w,
          borderRadius: 8.r,
        ),
      );

  Widget _content(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Gap(2.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  constraints: BoxConstraints(maxWidth: 210.w),
                  child: _fullName(context)),
              Expanded(child: _emergencyTitle(context)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _doctorName(context),
                      _appointmentDate(context),
                    ],
                  ),
                ),
                // const Spacer(),
                AppButton.filled(
                  label: appointment.appointmentType ==
                      AppointmentTypeEnum.suggestion ?'Accept' : 'Profile',
                  onTap: () {
                    locator<MainRouter>().push(
                      EditAppointmentPageRoute(
                        pageState:appointment.appointmentType ==
                            AppointmentTypeEnum.suggestion ? FieldWorkerPageStateEnum.location : FieldWorkerPageStateEnum.edit,
                        userType: UserTypeEnum.fieldWorker,
                      ),
                    );
                  },
                  widthp: 73.h,
                  height: 32.h,
                  labelColor: OnlineClinicColorStyle.white,
                  borderColor: (appointment.appointmentType ==
                          AppointmentTypeEnum.completed)
                      ? const Color(0xFFA5A9BB)
                      : OnlineClinicColorStyle.primary,
                  backgroundColor: (appointment.appointmentType ==
                          AppointmentTypeEnum.completed)
                      ? const Color(0xFFA5A9BB)
                      : OnlineClinicColorStyle.primary,
                  labelStyle: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      );

  Widget _emergencyTitle(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12.h, right: 8.w, left: 8.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: CustomText(
              text: (appointment.appointmentPriorityType ==
                      AppointmentPriorityTypeEnum.regular)
                  ? ''
                  : 'Emergency',
              textStyle: Theme.of(context).textTheme.labelMedium,
              textColor: (appointment.appointmentPriorityType ==
                          AppointmentPriorityTypeEnum.urgent &&
                      appointment.appointmentType ==
                          AppointmentTypeEnum.completed)
                  ? const Color(0xFFA5A9BB)
                  : const Color(0xFFFF000F),
            ),
          ),
          Gap(10.w),
          // const Spacer(),
          CustomText(
            text: '1 day ago',
            textColor: OnlineClinicColorStyle.lightGray,
            textFontWight: TextFontWight.regular,
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }

  Widget _doctorName(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(
          imageSvgPath: 'images/svg/archive_book.svg',
          imageHeight: 15.h,
          imageWidth: 15.w,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 5.87.w),
            child: CustomText(
              text: '${appointment.doctorName}',
              textColor: OnlineClinicColorStyle.lightGray,
              textFontWight: TextFontWight.regular,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget _fullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, top: 10.h, bottom: 8.h),
      child: CustomText(
        text: '${appointment.firstName} ${appointment.lastName}',
        textColor: OnlineClinicColorStyle.dark,
        textFontWight: TextFontWight.bold,
        textStyle: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }

  Widget _address(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, bottom: 8.h, top: 8.5.h),
      child: Row(
        children: [
          CustomImage(
            imageSvgPath: 'images/svg/bold_location.svg',
            imageHeight: 16.h,
            imageWidth: 16.w,
          ),
          Gap(4.w),
          Expanded(
            child: CustomText(
              text:
                  'Villa 123, Street 24m, Community A Dubai, United Arab Emirates',
              textColor: OnlineClinicColorStyle.lightGray,
              textFontWight: TextFontWight.regular,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _appointmentDate(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomImage(
          imageSvgPath: 'images/svg/calendar-tick.svg',
          imageHeight: 15.h,
          imageWidth: 15.w,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 8.0.w),
            child: CustomText(
              text: appointment.appointmentDate != null
                  ? DateFormat('MMMM d, yyyy, hh:mm a')
                      .format(appointment.appointmentDate!)
                  : '-',
              textColor: OnlineClinicColorStyle.lightGray,
              textFontWight: TextFontWight.regular,
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectLocation(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: Padding(
        padding: EdgeInsets.only(
          right: 8.0.w,
          bottom: 8.h,
        ),
        child: InkWell(
          onTap: () {
            locator<MainRouter>().push(
              EditAppointmentPageRoute(
                pageState: FieldWorkerPageStateEnum.location,
                userType: UserTypeEnum.fieldWorker,
              ),
            );
          },
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              border: Border.all(
                color: OnlineClinicColorStyle.primary,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(
                  50.r,
                ),
              ),
            ),
            child: SizedBox(
              child: Padding(
                padding: EdgeInsets.all(6.0.h),
                child: CustomImage(
                  imageSvgPath: 'images/svg/bold_location.svg',
                  imageHeight: 16.h,
                  imageWidth: 16.w,
                  svgColor: OnlineClinicColorStyle.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
