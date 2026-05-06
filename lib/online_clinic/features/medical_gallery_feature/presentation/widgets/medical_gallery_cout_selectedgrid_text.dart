import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_galley_report_file_info.dart';

class MedicalGalleryCountSelectedGridText extends StatefulWidget {
  final bool allSelected;
  final int selectedCount;
  final int? isShowFileInf;

  final void Function()? onTap;

  const MedicalGalleryCountSelectedGridText(
      {super.key,
      required this.allSelected,
      required this.selectedCount,
      this.isShowFileInf,
      this.onTap});

  @override
  State<MedicalGalleryCountSelectedGridText> createState() =>
      MedicalGalleryCountSelectedGridTextState();
}

class MedicalGalleryCountSelectedGridTextState
    extends State<MedicalGalleryCountSelectedGridText> {
  bool allSelected = false;
  int selectedCount = 0;
  bool isShowFileInf = true;
  bool isAllSelected = false;
  void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return isShowFileInf
        ? const MedicalGalleyReportFileInfo()
        : Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                onTap: widget.onTap,
                child: Row(
                  children: [
                     CustomImage(
                      imageSvgPath: isAllSelected ? 'images/svg/gallery-remove.svg' :'images/svg/gallery-tick-ut.svg',
                       imageHeight: 20,
                       imageWidth: 20,
                    ),
                    Gap(4.w),
                    CustomText(
                      text: isAllSelected ? 'Deselect': 'Select all',
                      textStyle: Theme.of(context).textTheme.bodySmall,
                      // textFontWight: TextFontWight.bold,
                    ),
                  ],
                ),
              ),
              Gap(80.w),
              CustomText(
                text: allSelected
                    ? 'All items selected'
                    : '$selectedCount item selected',
                textStyle: Theme.of(context).textTheme.bodyMedium,
                textFontWight: TextFontWight.bold,
              ),
            ],
          );
  }
}
