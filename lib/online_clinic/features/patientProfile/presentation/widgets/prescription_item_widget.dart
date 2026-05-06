import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/prescription_entity.dart';

class PrescriptionItemWidget extends StatelessWidget {
  const PrescriptionItemWidget({
    required this.model,
    required this.index,
    required this.onTap,
    required this.isLastIndex,
    required this.userType,
    this.addDrugContainer = false,
    super.key,
  });

  final PrescriptionEntity model;
  final int index;
  final void Function() onTap;
  final bool addDrugContainer;
  final bool isLastIndex;
  final UserTypeEnum userType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: CustomContainer(
        // height: model.drugDescription != null ? 95.h :70.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(vertical: 16.h),
        border: !isLastIndex
            ? Border(
                bottom: BorderSide(
                  width: isLastIndex ? 0 : 1.w,
                  color: OnlineClinicColorStyle.lightGray4,
                ),
              )
            : null,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(index == 0 ? 16.r : 0),
          bottom: Radius.circular(
              isLastIndex && userType == UserTypeEnum.doctor ? 16.r : 0),
        ),
        color: OnlineClinicColorStyle.white,
        // boxShadow: isLastIndex && userType == UserTypeEnum.doctor
        //     ? [
        //         OnlineClinicColorStyle.noneBoxShadow,
        //       ]
        //     : null,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _boxImage(),
                Gap(4.w),
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.h,
                        child: Row(
                          children: [
                            Expanded(child: _drugName(context)),
                            if(userType == UserTypeEnum.doctor)CustomImage(
                              imageSvgPath: addDrugContainer
                                  ? 'images/svg/add-circle.svg'
                                  : 'images/svg/more-vertical.svg',
                              borderRadius: 8.r,
                            ),
                            Gap(4.w),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                        // width: 398.w,
                        child: Row(
                          children: [
                            _amountDrug(context),
                            _horizontalDivider(),
                            _timingDrug(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (model.drugDescription != null && model.drugDescription != '')
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: Row(
                  children: [
                    CustomText(
                      text: 'Note: ',
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      textFontWight: TextFontWight.bold,
                      textColor: OnlineClinicColorStyle.dark2,
                    ),
                    CustomText(
                      text: '${model.drugDescription}',
                      textStyle: Theme.of(context).textTheme.labelLarge,
                      textColor: OnlineClinicColorStyle.dark2,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _horizontalDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 8.w, right: 8.w),
      child: CustomContainer(
        width: 1,
        height: 10.h,
        color: OnlineClinicColorStyle.lightGray4,
      ),
    );
  }

  Widget _boxImage() => Padding(
        padding: EdgeInsets.only(left:addDrugContainer ?8.w :0 ,top: 8.h,),
        child: addDrugContainer
            ? CustomContainer(
              borderRadius: BorderRadius.all(Radius.circular(8.r)),
              color: OnlineClinicColorStyle.lightGray4,
              child: Padding(
                padding: EdgeInsets.all(11.r),
                child: CustomImage(
                          // boxFit: BoxFit.scaleDown,
                          imageSvgPath: 'images/svg/gallery-grey.svg',
                          imageWidth: 20.w,
                          imageHeight: 20.h,
                          borderRadius: 8.r,
                        ),
              ),
            )
            : CustomImage(
                imagePngOrJpgPath: 'images/onine_clinic_png/drug.png',
                imageWidth: 50.w,
                imageHeight: 50.h,
                borderRadius: 8.r,
              ),
      );

  Widget _drugName(BuildContext context) => CustomText(
    text: addDrugContainer ? 'Name' : model.drugName ?? 'Dexamethasone',
    textStyle: Theme.of(context).textTheme.bodyMedium,
    textColor: OnlineClinicColorStyle.dark,
    textFontWight: TextFontWight.bold,
  );

  Widget _amountDrug(BuildContext context) => Row(
        children: [
          CustomImage(
            imageSvgPath: 'images/svg/drug_amount.svg',
            imageWidth: 16.w,
            imageHeight: 16.h,
            borderRadius: 8.r,
          ),
          Gap(4.w),
          CustomText(
            text: addDrugContainer ? 'Amount' : model.drugAmount ?? '3 tablets',
            textStyle: Theme.of(context).textTheme.labelLarge,
            textColor: OnlineClinicColorStyle.dark,
          ),
        ],
      );

  Widget _timingDrug(BuildContext context) => Expanded(
        child: Row(
          children: [
            CustomImage(
              imageSvgPath: 'images/svg/calendar_drug.svg',
              imageWidth: 16.w,
              imageHeight: 16.h,
              borderRadius: 8.r,
            ),
            Gap(4.w),
            CustomText(
              text:
                  addDrugContainer ? 'Timing' : model.drugTiming ?? 'per 12 h',
              textStyle: Theme.of(context).textTheme.bodySmall,
              textColor: OnlineClinicColorStyle.dark,
            ),
          ],
        ),
      );
}
