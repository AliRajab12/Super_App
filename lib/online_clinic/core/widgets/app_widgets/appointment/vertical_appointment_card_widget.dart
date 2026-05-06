import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/call_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';

class VerticalAppointmentCardWidget extends StatelessWidget {
  const VerticalAppointmentCardWidget({
    super.key ,

    required this.appointmentEntity,
    required this.onTapMakeCall
  });

  final AppointmentEntity appointmentEntity;
  final Function() onTapMakeCall;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        locator<MainRouter>().push(
          PatientProfileRoute(
            userType: UserTypeEnum.doctor,
          ),
        );
      },
      child: CustomContainer(
        width: 144.w,
        // height: 115.h,
        color: OnlineClinicColorStyle.white,
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
        margin: EdgeInsets.only(left: 8.w , right: 8.w ),
        elevationType: ElevationType.noElevation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomImage(
              imagePngOrJpgPath: appointmentEntity.avatar,
              imageWidth: 60.r,
              imageHeight: 60.r
            ),
            Gap(16.h),
            if(appointmentEntity.appointmentPriorityTypeEnum == AppointmentPriorityTypeEnum.urgent)
            CustomText(
              text: 'Emergency',
              textStyle: Theme.of(context).textTheme.labelLarge,
              textColor: Colors.red,
            ),
            if(appointmentEntity.appointmentPriorityTypeEnum == AppointmentPriorityTypeEnum.urgent)
            Gap(4.h),
            CustomText(
              text: appointmentEntity.title??'',
              textStyle: Theme.of(context).textTheme.bodyLarge,
              textFontWight: TextFontWight.bold,
            ),
            Gap(4.h),
            CustomText(
                text: appointmentEntity.subtitle??'',
                textStyle: Theme.of(context).textTheme.labelLarge,
              textColor: OnlineClinicColorStyle.lightGray,
            ) ,

            Gap(4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImage(
                  imageSvgPath:'images/svg/timer.svg' ,
                  imageWidth: 20.r,
                  imageHeight: 20.r,
                  svgColor:OnlineClinicColorStyle.dark ,
                ),
                CustomText(
                    text: appointmentEntity.time??'',
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  textColor: OnlineClinicColorStyle.lightGray,
                ),
                CustomText(
                    text: ' AM',
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  textColor: OnlineClinicColorStyle.lightGray,
                ),
              ],
            ),
            Gap(10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(text: 'Field Worker',
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  textColor: OnlineClinicColorStyle.lightGray,
                ),
                Gap(2.w),
                 CustomImage(
                  imageSvgPath:(appointmentEntity.hasFieldWorker ?? false) ? 'images/svg/tick-circle.svg' : 'images/svg/close-circle.svg',
                )
              ],
            ),

            Gap(10.h),

             CallButton(
              width: 32.r,
               height: 32.r,
               padding: 8.r,
            ),
            Gap(10.h),


          ],
        ),
      ),
    );
  }

}
