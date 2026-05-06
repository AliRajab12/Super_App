import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/observation_entity.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/prescription_entity.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/widgets/observation_item_widget.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/widgets/prescription_item_widget.dart';

class PatientHistoryPage extends StatelessWidget {
  PatientHistoryPage({super.key, required this.userTypeEnum});

  final List<PrescriptionEntity> prescriptions = [
    PrescriptionEntity(
      drugName: 'Dexamethasone',
      drugAmount: '4 ml',
      drugTiming: 'per 4 h',
    ),
    PrescriptionEntity(
      drugName: 'Zyrtec',
      drugAmount: '3 tablets',
      drugTiming: 'per 8 h',
      drugDescription: 'eat whit water not beer',
    ),
    PrescriptionEntity(
      drugName: 'Claritin',
      drugAmount: '3 tablets',
      drugTiming: 'per 12 h',
    ),
    PrescriptionEntity(
      drugName: 'Dexamethasone',
      drugAmount: '3 tablets',
      drugTiming: 'per 12 h',
      drugDescription: 'eat whit water not beer',
    ),
    PrescriptionEntity(
      drugName: 'Dexamethasone',
      drugAmount: '3 tablets',
      drugTiming: 'per 12 h',
    ),
    PrescriptionEntity(
      drugName: 'Dexamethasone',
      drugAmount: '3 tablets',
      drugTiming: 'per 12 h',
    ),
  ];
  final UserTypeEnum userTypeEnum;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _prescriptionHeader(context),
            Gap(22.h),
            _prescriptionsList(prescriptions, context),
            Gap(48.h),
            _observationHeader(context),
            const ObservationItemWidget()
          ],
        ),
      ),
    );
  }

  Widget _prescriptionsList(
          List<PrescriptionEntity> prescriptions, BuildContext context) =>
      DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
          boxShadow: [
                  OnlineClinicColorStyle.noneBoxShadow,
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _prescriptionListviewFrame(prescriptions),
            if (userTypeEnum == UserTypeEnum.patient) _orderButton(context),
          ],
        ),
      );

  Widget _prescriptionListviewFrame(List<PrescriptionEntity> prescriptions) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: prescriptions.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => PrescriptionItemWidget(
        index: index,
        userType: userTypeEnum,
        onTap: () => print(index),
        isLastIndex: index == prescriptions.length - 1,
        model: prescriptions[index],
        addDrugContainer: index == prescriptions.length - 1 &&
            userTypeEnum == UserTypeEnum.doctor,
      ),
    );
  }

  Widget _orderButton(BuildContext context) {
    return AppButton.filled(
      padding: EdgeInsets.symmetric(vertical: 16.h),hasElevation: false,
      label: 'ORDER',
      onTap: () {},
      widthp: 372.w,
      height: 40.h,
      labelColor: OnlineClinicColorStyle.primary,
      borderColor: OnlineClinicColorStyle.primary,
      backgroundColor: OnlineClinicColorStyle.primary,
      customChild: Center(
        child: CustomText(
          text: 'ORDER',
          textStyle: Theme.of(context).textTheme.bodyLarge,
          textColor: OnlineClinicColorStyle.white,
        ),
      ),
    );
  }

  Widget _prescriptionHeader(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                text: 'Prescriptions',
                textFontWight: TextFontWight.bold,
                textStyle: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      );

  Widget _observationHeader(BuildContext context) => Row(
        children: [
          Expanded(
            child: CustomText(
              text: 'Doctor’s Notes',
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          // CustomText(
          //   text: DateFormat(DateFormat.MONTH_DAY).format(DateTime.now()),
          //   textFontWight: TextFontWight.bold,
          //   textColor: OnlineClinicColorStyle.lightGray,
          //   textStyle: Theme.of(context).textTheme.bodySmall,
          // ),
        ],
      );
}
