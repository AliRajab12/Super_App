import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';

class MedicalGalleryFAB extends StatelessWidget {
  const MedicalGalleryFAB({
    required this.takePhoto,
    required this.chooseFromGallery,
    required this.chooseFile,
    super.key,
  });


  final void Function() takePhoto;
  final void Function() chooseFromGallery;
  final void Function() chooseFile;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 17.w, bottom: 20.h),
      child: FloatingActionButton(
        onPressed: () {
          CreateOverLay.toggleOverlay(
            context: context,
            right: 70.w,
            bottom: 100.h,
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CreateOverLayRow(
                    imageSvgPath: 'images/svg/gallery.svg',
                    text: 'Choose from gallery',
                    isShowDivider: true,
                    width: 142.w,
                    onTap: () => chooseFromGallery(),
                  ),
                  CreateOverLayRow(
                    imageSvgPath: 'images/svg/folder.svg',
                    text: 'Choose file',
                    isShowDivider: true,
                    width: 142.w,
                    onTap: () => chooseFile(),
                  ),
                  CreateOverLayRow(
                    imageSvgPath: 'images/svg/take_photo.svg',
                    text: 'Take photo',
                    isShowDivider: false,
                    width: 142.w,
                    onTap: () => takePhoto(),
                  ),
                ],
              ),
            ),
          );
        },
        backgroundColor: OnlineClinicColorStyle.primary,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}