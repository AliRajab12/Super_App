import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/add_overlay_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/item_disease.dart';

class WrapperDisease extends StatefulWidget {
 const  WrapperDisease({super.key,required this.title ,required this.items , required this.onTapClose , required this.onTapAdd});
  final List<DropDownModel> items;
  final Function(int index) onTapClose;
  final Function(Offset position , DropDownModel valueAdded) onTapAdd;
  final String title;

  @override
  State<WrapperDisease> createState() => _WrapperDiseaseState();
}

class _WrapperDiseaseState extends State<WrapperDisease> {
  GlobalKey<_WrapperDiseaseState> uniqueKey =
  GlobalKey<_WrapperDiseaseState>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: widget.title,
          subtitle: '',
          action: InkWell(
            onTap: (){
              RenderBox? renderBox;
              var parent =
                  uniqueKey.currentContext?.findRenderObject()?.parent;
              while (parent != null) {
                if (parent is RenderBox) {
                  renderBox = parent;
                  break;
                }
                parent = parent.parent;
              }
              if (renderBox == null) {
                debugPrint('Unable to find RenderBox ancestor.');
                return;
              }
              final Offset position = renderBox.localToGlobal(Offset.zero);

              CreateOverLay.toggleOverlay(
                context: context,
                left: position.dx - 150.w ,
                top: position.dy - 80.h,
                    // EdgeInsets.fromViewPadding(WidgetsBinding.instance.window.viewInsets,WidgetsBinding.instance.window.devicePixelRatio).bottom,
                width: 200.w,
                child: Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: AddOverlay(
                    onTapItem: (value){
                      widget.onTapAdd(position , value);
                      setState(() {

                      });
                    },
                    items: widget.items,
                  ),
                ),
              );



            },
            child: Row(
              children: [
                CustomText(
                  text: 'Add ',
                  key: uniqueKey,
                  textStyle: Theme.of(context).textTheme.labelLarge,
                  textFontWight: TextFontWight.bold,
                  textColor: OnlineClinicColorStyle.lightGray,
                ),
                Icon(
                  Icons.add,
                  size: 18.r,
                ),
              ],
            ),
          ),
        ),
        Gap(8.h),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16.w),
          child: Wrap(
            spacing: 5.w,
            runSpacing: 10.h,
            children: widget.items.map((e) {
              return ItemDisease(
                  title: e.title, onTapClose: (){
                widget.onTapClose(widget.items.indexOf(e));
              });
            }).toList(),
          ),
        ),
        Gap(20.h),
      ],
    );
  }
}
