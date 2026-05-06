import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';

class CreateOverLay {
  static OverlayEntry? overlayEntry;

  static void removeOverlay(){
    overlayEntry?.remove();
    overlayEntry = null;
  }
  static void toggleOverlay({
    required BuildContext context,
    double? width,
    double? height,
    double? top,
    double? left,
    double? bottom,
    double? right,
    Positioned? positioned,
    Color? backgroundColor,
    Color? barrierColor,
    Widget? child,
  }) {
    overlayEntry?.remove();
    var overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) => SizedBox(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          // fit: StackFit.expand,
          children: [
            ModalBarrier(
              onDismiss: () {
                overlayEntry?.remove();
                overlayEntry = null;
              },
              color: Colors.grey.withOpacity(0.4),
            ),
            // positioned ??
            Positioned(
              bottom: bottom,
              top: top,
              left: left,
              right: right,
              child: CustomContainer(
                  width: width ?? 116.w,
                  // height: height ?? 63.h,
                  color: const Color(0xFFFEFEFE),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: child),
            ),
          ],
        ),
      ),
    );

    overlayState.insert(overlayEntry!);

  }
}
