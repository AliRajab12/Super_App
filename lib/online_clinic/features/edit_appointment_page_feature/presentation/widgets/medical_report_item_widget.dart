import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/medical_report_entity.dart';

class MedicalReportItemWidget extends StatelessWidget {
  const MedicalReportItemWidget({
    required this.model,
    required this.onTap,
    this.isExpanded = true,
    this.padding,
    this.moreOnTap,
    this.moreIconKey,
    super.key,
  });

  final MedicalReportEntity model;
  final bool isExpanded;
  final EdgeInsets? padding;
  final Key? moreIconKey;
  final void Function() onTap;
  final void Function()? moreOnTap;

  @override
  Widget build(BuildContext context) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Builder(
          builder: (context) {
            return InkWell(
              onTap: () => onTap(),
              child: Padding(
                padding: padding ?? EdgeInsets.only(bottom: 16.h),
                child: CustomContainer(
                  height: 78.h,
                  width: isExpanded ? 1.sw : 298.w,
                  elevationType: ElevationType.noElevation,
                  color: OnlineClinicColorStyle.white,
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: Row(
                    children: [
                      _boxImage(),
                      Gap(8.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 1.sw,
                              child: Padding(
                                padding:  EdgeInsets.only(top: 8.h),
                                child: Row(
                                  children: [
                                    Expanded(child: _titleWidget(context)),
                                    if(moreOnTap != null)SizedBox(
                                      height: 24,
                                      width: 24,
                                      child: InkWell(
                                        onTap: moreOnTap,
                                        child: CustomImage(
                                          imageSvgPath: 'images/svg/more-vertical.svg',
                                          key: moreIconKey,
                                          imageHeight: 24,
                                          imageWidth: 24,
                                        ),
                                      ),
                                    ),
                                    Gap(16.w),
                                  ],
                                ),
                              ),
                            ),
                            Gap(16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _documentInfo(context),
                                _appointmentDateWidget(context),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      );

  Widget _documentInfo(BuildContext context) =>
      Padding(
        padding:  EdgeInsets.only( bottom:8.h),
        child: CustomText(
          text: '${model.documentType},${model.documentSize}',
          textStyle: Theme
              .of(context)
              .textTheme
              .labelLarge,
          textFontWight: TextFontWight.bold,
          textColor: OnlineClinicColorStyle.lightGray4,
        ),
      );

  Widget _appointmentDateWidget(BuildContext context) =>
      Padding(
        padding: EdgeInsets.only(right: 8.w),
        child: CustomText(
          text: model.reportDate != null
              ? DateFormat('d MMMM').format(model.reportDate!)
              : '-',
          textStyle: Theme
              .of(context)
              .textTheme
              .labelMedium,
          textFontWight: TextFontWight.medium,
          textColor: OnlineClinicColorStyle.lightGray4,
        ),
      );

  Widget _titleWidget(BuildContext context) =>
      CustomText(
        text: model.title!,
        textStyle: Theme
            .of(context)
            .textTheme
            .bodyLarge,
        textFontWight: TextFontWight.bold,
      );

  Widget _boxImage() =>
      Padding(
        padding: EdgeInsets.only(
          left: 8.w,
          top: 8.w,
          bottom: 8.w,
        ),
        child: CustomImage(
          imageSvgPath: 'images/svg/box.svg',
          imageWidth: 50.w,
          imageHeight: 50.h,
          borderRadius: 4.r,
        ),
      );
}
