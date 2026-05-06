import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

enum BottomSheetFileTypes { image, video, audio, document }

class UploadImageBottomSheet extends StatefulWidget {
  const UploadImageBottomSheet(
      {super.key,
      required this.onChooseFromGallery,
      required this.onChooseFile,
      required this.onTakePhoto,
        required this.onTapSubmit,
        required this.descriptionController,
        required this.nameController,
      required this.files});

  final Function() onChooseFromGallery;
  final Function() onChooseFile;
  final Function() onTakePhoto;
  final List<Map<XFile, BottomSheetFileTypes>> files;
  final Function() onTapSubmit;
  final TextEditingController nameController ;
  final TextEditingController descriptionController  ;
  @override
  State<UploadImageBottomSheet> createState() => _UploadImageBottomSheetState();
}

class _UploadImageBottomSheetState extends State<UploadImageBottomSheet> {

  //
  // @override
  // void dispose() {
  //   widget.nameController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Gap(16.h),
          CustomText(
            text: 'File name',
            textStyle: Theme.of(context).textTheme.bodySmall,
            textFontWight: TextFontWight.medium,
            textColor: OnlineClinicColorStyle.dark,
          ),
          Gap(4.h),
          CustomContainer(
            elevationType: ElevationType.lowElevation,
            borderRadius: BorderRadius.circular(8),
            height: 34.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: OnlineClinicColorStyle.white,
            child: Center(
              child: TextField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  // contentPadding: EdgeInsets.all(0),
                  hintText: 'e.x Blood type test',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: OnlineClinicColorStyle.lightGray4),
                ),
              ),
            ),
          ),
          Gap(16.h),
          CustomText(
            text: 'Description',
            textStyle: Theme.of(context).textTheme.bodySmall,
            textFontWight: TextFontWight.medium,
            textColor: OnlineClinicColorStyle.dark,
          ),
          Gap(4.h),
          CustomContainer(
            elevationType: ElevationType.lowElevation,
            borderRadius: BorderRadius.circular(8),
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            color: OnlineClinicColorStyle.white,
            child: Center(
              child: TextField(
                maxLines: 2,
                controller:  widget.descriptionController,
                decoration: InputDecoration(
                  hintMaxLines: 2,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(0),
                  hintText:
                      'e.x This patient has gluten allergy . It is important for them to be careful about reading food labels to avoid ...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: OnlineClinicColorStyle.lightGray4),
                ),
              ),
            ),
          ),
          Gap(16.h),
          CustomText(
            text: 'Choose file',
            textStyle: Theme.of(context).textTheme.bodySmall,
            textFontWight: TextFontWight.medium,
            textColor: OnlineClinicColorStyle.dark,
          ),
          Gap(4.h),
          CustomContainer(
            height: 80.h,
            padding: EdgeInsets.only(top: 8.h, left: 8.w),
            color: OnlineClinicColorStyle.white,
            elevationType: ElevationType.lowElevation,
            borderRadius: BorderRadius.circular(8),
            child: Column(
              children: [
                InkWell(
                  onTap: widget.onChooseFromGallery,
                  child: Row(
                    children: [
                      CustomImage(
                        imageWidth: 16.w,
                        imageHeight: 16.h,
                        imageSvgPath: 'images/svg/gallery.svg',
                      ),
                      Gap(8.w),
                      CustomText(
                        text: 'Choose from gallery',
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        textColor: OnlineClinicColorStyle.gray,
                      )
                    ],
                  ),
                ),
                Gap(8.h),
                InkWell(
                  onTap: widget.onChooseFile,
                  child: Row(
                    children: [
                      CustomImage(
                        imageWidth: 16.w,
                        imageHeight: 16.h,
                        imageSvgPath: 'images/svg/folder.svg',
                      ),
                      Gap(8.w),
                      CustomText(
                        text: 'Choose file',
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        textColor: OnlineClinicColorStyle.gray,
                      )
                    ],
                  ),
                ),
                Gap(8.h),
                InkWell(
                  onTap: widget.onTakePhoto,
                  child: Row(
                    children: [
                      CustomImage(
                        imageWidth: 16.w,
                        imageHeight: 16.h,
                        imageSvgPath: 'images/svg/take_photo.svg',
                      ),
                      Gap(8.w),
                      CustomText(
                        text: 'Take photo',
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        textColor: OnlineClinicColorStyle.gray,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Gap(24.h),
          if (widget.files.isNotEmpty)
            SizedBox(
              height: 65.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final file = widget.files[index];

                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        CustomContainer(
                            height: 40.h,
                            width: 40.w,
                            color: OnlineClinicColorStyle.lightColor3,
                            borderRadius: BorderRadius.circular(4),
                            child: file.values.first ==
                                        BottomSheetFileTypes.image ||
                                    file.values.first ==
                                        BottomSheetFileTypes.video
                                ? CustomImage(
                                    borderRadius: 4,
                                    imageSvgPath: file.values.first ==
                                            BottomSheetFileTypes.video
                                        ? 'images/svg/play_circle.svg'
                                        : null,
                                    imageFile: file.values.first ==
                                            BottomSheetFileTypes.image
                                        ? File(file.keys.first.path)
                                        : null,
                                    boxFit: BoxFit.cover,
                                  )
                                : Center(
                                    child: CustomImage(
                                      imageSvgPath: file.values.first ==
                                              BottomSheetFileTypes.audio
                                          ? 'images/svg/microphone.svg'
                                          : 'images/svg/pdf_folder.svg',
                                      boxFit: BoxFit.cover,
                                    ),
                                  )),
                        Positioned(
                          top: -9.h,
                          right: -9.h,
                          child: SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: AppButton.filled(
                              onTap: () {
                                setState(() {
                                  widget.files.removeAt(index);
                                  //  widget.files.removeWhere((element) => element == widget.files[index].name);
                                });
                              },
                              backgroundColor: Colors.transparent,
                              label: null,
                              customChild: CustomImage(
                                imageWidth: 18.w,
                                imageHeight: 18.h,
                                svgColor: OnlineClinicColorStyle.dark,
                                imageSvgPath:
                                    'images/svg/white_close_circle.svg',
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                itemCount: widget.files.length,
              ),
            ),
          AppButton(
            height: 32.h,
            label: 'Submit',
            onTap: widget.onTapSubmit,
            backgroundColor: OnlineClinicColorStyle.primary,
          )
        ],
      ),
    );
  }
}
