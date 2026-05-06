import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';

class OfflineFieldWorkerPage extends StatelessWidget {
  const OfflineFieldWorkerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomImage(
      imagePngOrJpgPath: 'images/onine_clinic_png/offline.png',
      imageWidth: 428.r,
      imageHeight: 526.r,
    );
  }
}
