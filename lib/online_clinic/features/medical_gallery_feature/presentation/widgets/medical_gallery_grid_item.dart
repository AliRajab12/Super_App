import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class GridItem extends StatefulWidget {
  final int index;
  final bool isSelectMode;
   bool isSelectAll;
  final Function(int, bool) onItemTapped;

   GridItem({
    super.key,
    required this.index,
    required this.onItemTapped,
    required this.isSelectMode,
    required this.isSelectAll
  });

  @override
  State<GridItem> createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.isSelectMode) {
          widget.isSelectAll = ! widget.isSelectAll;

          setState(() {});
          widget.onItemTapped(widget.index, widget.isSelectAll);
        }else{
          locator<MainRouter>().push(
            FullScreenPhotoPageRoute(
              pngUrl: 'images/onine_clinic_png/medical_ct_1.png',
            ),
          );
        }
      },
      child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            widget.index % 2 == 0
                ? Container(
                    height: 100.h,
                    width: 100.w,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    child: const CustomImage(
                      showFullScreen: true,
                      imagePngOrJpgPath:
                          'images/onine_clinic_png/medical_ct_1.png',
                      boxFit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 100.h,
                    width: 100.w,
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    child: CustomImage(
                      showFullScreen: true,
                      imagePngOrJpgPath:
                          'images/onine_clinic_png/medical_ct_2.png',
                      imageWidth: 100.w,
                      imageHeight: 100.h,
                      boxFit: BoxFit.cover,
                    ),
                  ),
            Container(
              height: 26.h,
              width: 94.w,
              color: Colors.grey.withOpacity(0.7),
              child: Padding(
                padding: EdgeInsets.only(left: 8.w, top: 3.h, bottom: 3.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      text: 'Head CT Scan',
                      textColor:
                          Theme.of(context).brightness == Brightness.light
                              ? OnlineClinicColorStyle.white
                              : OnlineClinicColorStyle.white,
                      textFontWight: TextFontWight.bold,
                    ),
                    CustomText(
                      textStyle: Theme.of(context).textTheme.labelSmall,
                      text: 'Feb 24, 2023',
                      textColor:
                          Theme.of(context).brightness == Brightness.light
                              ? OnlineClinicColorStyle.white
                              : OnlineClinicColorStyle.white,
                    ),
                  ],
                ),
              ),
            ),
            widget.isSelectMode
                ? Align(
                    alignment: Alignment.topRight,
                    child: Checkbox(
                      value: widget.isSelectAll ,
                      onChanged: (bool? newValue) {
                        if (widget.isSelectMode) {
                          widget.isSelectAll = !widget.isSelectAll;
                          setState(() {});
                          widget.onItemTapped(widget.index, widget.isSelectAll);
                        }
                      },
                      side: const BorderSide(
                        color: Colors.white,
                      ),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      activeColor: Colors.white,
                      checkColor: Colors.grey.withOpacity(0.7),
                      focusColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
