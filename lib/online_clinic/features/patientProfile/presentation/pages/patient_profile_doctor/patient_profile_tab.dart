import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/medical_report_entity.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/medical_report_item_widget.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/widgets/patient_options.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/widgets/uneditable_text_field.dart';

class PatientProfileTab extends StatelessWidget {
  PatientProfileTab({super.key});

  final List<MedicalReportEntity> medicalReports = [
    MedicalReportEntity(
      title: 'CT Scan - Abdomen',
      reportDate: DateTime.now(),
      documentSize: '2T',
      documentType: 'PDF',
      document: null,
    ),
    MedicalReportEntity(
      title: 'CT Scan - Abdomen',
      reportDate: DateTime.now(),
      documentSize: '2b',
      documentType: 'jpeg',
      document: null,
    ),
    MedicalReportEntity(
      title: 'CT Scan - Abdomen',
      reportDate: DateTime.now(),
      documentSize: '800M',
      documentType: 'jpg',
      document: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UneditableTextField(
                  label: 'Blood Pressure',
                  value: '100',
                  width: 191.w,
                ),
                Gap(16.w),
                UneditableTextField(
                  label: 'Blood Glucose',
                  value: '100',
                  width: 191.w,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UneditableTextField(
                  label: 'Pulse',
                  value: '100',
                  width: 191.w,
                ),
                Gap(16.w),
                UneditableTextField(
                  label: 'Respiration',
                  value: '100',
                  width: 191.w,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                UneditableTextField(
                  label: 'Oxygen',
                  value: '97',
                  width: 191.w,
                ),
                Gap(16.w),
                UneditableTextField(
                  label: 'Temperature',
                  value: '37.5',
                  width: 191.w,
                ),
              ],
            ),
          ),
          // TitleWidget(
          //   title: 'General Condition',
          //   subtitle: '',
          //   action: CustomText(
          //     text: 'March 12',
          //     textStyle: Theme.of(context).textTheme.bodySmall,
          //     textFontWight: TextFontWight.bold,
          //     textColor: OnlineClinicColorStyle.lightGray5,
          //   ),
          // ),
          // SizedBox(
          //   height: 136.h,
          //   child: ListView.builder(
          //     itemCount: 10,
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return const ConditionCard();
          //     },
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 48.h , bottom: 16.h),
            child: const TitleWidget(
              title: 'Chronic Disease',
              subtitle: '',
              action: SizedBox(),
            ),
          ),
          const PatientOptions(
            options: [
              'IHD',
              'Obesity',
              'Thyroid',
              'Asthma',
              'Asthma',
              'Asthma',
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 48.h, bottom: 16.h),
            child: const TitleWidget(
              title: 'Surgeries',
              subtitle: '',
              action: SizedBox(),
            ),
          ),
          const PatientOptions(
            options: [
              'IHD',
              'Obesity',
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 48.h, bottom: 16.h),
            child: const TitleWidget(
              title: 'Genetic Disease',
              subtitle: '',
              action: SizedBox(),
            ),
          ),
          const PatientOptions(
            options: [
              'Obesity',
              'Diabetes',
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 48.h),
            child: TitleWidget(
              title: 'Medical Report',
              subtitle: '',
              action: CustomText(
                text: 'March 12',
                textStyle: Theme.of(context).textTheme.bodySmall,
                textFontWight: TextFontWight.bold,
                textColor: OnlineClinicColorStyle.lightGray5,
              ),
            ),
          ),
          ListView.builder(
            itemCount: medicalReports.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return MedicalReportItemWidget(
                model: medicalReports[index],
                onTap: () {
                  locator<MainRouter>().push(
                    MedicalGalleryPageRoute(userType: UserTypeEnum.doctor),
                  );
                },
              );
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 48.h , bottom: 16.h),
            child: TitleWidget(
              title: 'Field Worker’s Notes',
              subtitle: '',
              action: CustomText(
                text: 'March 12',
                textStyle: Theme.of(context).textTheme.bodySmall,
                textFontWight: TextFontWight.bold,
                textColor: OnlineClinicColorStyle.lightGray5,
              ),
            ),
          ),
          CustomContainer(
            elevationType: ElevationType.lowElevation,
            height: 110.h,
            color: OnlineClinicColorStyle.white,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            borderRadius: BorderRadius.circular(16.r),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      text: 'Observations: ',
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      textFontWight: TextFontWight.bold,
                      textColor: OnlineClinicColorStyle.dark,
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'By Joe Green',
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      textFontWight: TextFontWight.bold,
                      textColor: OnlineClinicColorStyle.lightGray,
                    )
                  ],
                ),
                Gap(16.h),
                Expanded(
                  child: CustomText(
                    textStyle: Theme.of(context).textTheme.labelLarge,
                    textColor: OnlineClinicColorStyle.dark2,
                    textFontWight: TextFontWight.regular,
                    multiLine: true,
                    text:
                    'Physical: Ms. Brown was alert and oriented to time, place, and person. She reported mild pain in her left calf, which she described as a dull ache. She was using a cane for mobility due to slight unsteadiness on her feet. ',
                  ),
                )
              ],
            ),
          ),
          Gap(16.h),
        ],
      ),
    );
  }
}
