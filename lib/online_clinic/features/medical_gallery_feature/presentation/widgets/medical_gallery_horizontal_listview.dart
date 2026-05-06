import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/edit_appointment_entity.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/medical_report_item_widget.dart';

class MedicalGalleryHorizontalListView extends StatefulWidget {
  const MedicalGalleryHorizontalListView({
    required this.model,
    required this.userType,
    super.key,
  });

  final EditAppointmentEntity model;
  final UserTypeEnum userType;

  @override
  State<MedicalGalleryHorizontalListView> createState() =>
      _MedicalGalleryHorizontalListViewState();
}

class _MedicalGalleryHorizontalListViewState
    extends State<MedicalGalleryHorizontalListView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95.h,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: widget.model.reportList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          GlobalKey<_MedicalGalleryHorizontalListViewState> uniqueKey =
              GlobalKey<_MedicalGalleryHorizontalListViewState>();
          return MedicalReportItemWidget(
            padding: EdgeInsets.only(
              top: 4.h,
              bottom: 12.h,
            ),
            model: widget.model.reportList[index],
            isExpanded: false,
            onTap: () => debugPrint(index.toString()),
            moreIconKey: uniqueKey,
            moreOnTap: widget.userType == UserTypeEnum.fieldWorker ? () {
              RenderBox? renderBox;
              var parent = uniqueKey.currentContext?.findRenderObject()?.parent;
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
                left: position.dx - 100.w,
                top: position.dy + 20.h,
                // right: 70.w,
                // bottom: 100.h,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //         CreateOverLayRow(
                      //           imageSvgPath: 'images/svg/trash.svg',
                      //           text: 'Delete file',
                      //           isShowDivider: true,
                      //         ),
                      //         CreateOverLayRow(
                      //           imageSvgPath: 'images/svg/edit-2.svg',
                      //           text: 'Edit file name',
                      //           isShowDivider: false,
                      //         ),
                      CreateOverLayRow(
                        imageSvgPath: 'images/svg/trash.svg',
                        text: 'Delete file',
                        isShowDivider: true,
                        width: 142.w,
                      ),
                      CreateOverLayRow(
                        imageSvgPath: 'images/svg/edit-2.svg',
                        text: 'Edit file name',
                        isShowDivider: false,
                        width: 142.w,
                      ),
                    ],
                  ),
                ),
              );

              // CreateOverLay.toggleOverlay(
              //   context: context,
              //   left: position.dx - 100.w,
              //   top: position.dy + 20.h,
              //   height: 63.h,
              //   width: 116.w,
              //   child: Container(
              //     padding: EdgeInsets.symmetric(
              //         horizontal: 8.w, vertical: 8.h),
              //     child: const Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       mainAxisSize: MainAxisSize.min,
              //       children: [

              //       ],
              //     ),
              //   ),
              // );
            } : null,
          );
        },
      ),
    );
  }
}
