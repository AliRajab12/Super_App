import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/enums/blood_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/edit_appointment_entity.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/medical_report_entity.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_gallery_cout_selectedgrid_text.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_gallery_fab.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_gallery_gridview.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/widgets/medical_gallery_horizontal_listview.dart';

import '../../../edit_appointment_page_feature/presentation/widgets/upload_image_bottomsheet.dart';

@RoutePage()
class MedicalGalleryPage extends StatefulWidget {
  const MedicalGalleryPage({
    required this.userType,
    super.key,
  });

  static const String route = '/medicalGalleryPage';
  final UserTypeEnum userType;

  @override
  State<MedicalGalleryPage> createState() => _MedicalGalleryPageState();
}

class _MedicalGalleryPageState extends State<MedicalGalleryPage> {
  EditAppointmentEntity model = EditAppointmentEntity(
    age: 10,
    weight: 100,
    height: 180,
    heartRate: 250,
    temperature: 47.5,
    bloodType: BloodEnum.oMinus,
    reportList: [
      MedicalReportEntity(
        title: 'CT Scan - Abdomen',
        reportDate: DateTime.now(),
        documentSize: '2T',
        documentType: 'PDF',
        document: null,
      ),
      MedicalReportEntity(
        title: 'CT Scan - Abdomen',
        reportDate: DateTime.now(),
        documentSize: '2b',
        documentType: 'jpeg',
        document: null,
      ),
      MedicalReportEntity(
        title: 'CT Scan - Abdomen',
        reportDate: DateTime.now(),
        documentSize: '800M',
        documentType: 'jpg',
        document: null,
      ),
    ],
    chronicDiseaseList: [],
    geneticDiseaseList: [],
    surgeriesList: [],
  );

  bool isSelectMode = false;
  bool isShowDeselectAndRemove = false;

  List<bool> selectedList = List.generate(20, (_) => false);
  int selectedCount = 0;
  bool allSelected = false;
  GlobalKey<MedicalGalleryCountSelectedGridTextState> textCountKey =
      GlobalKey<MedicalGalleryCountSelectedGridTextState>();

  GlobalKey<MedicalGalleryGridViewState> imageListKey =
      GlobalKey<MedicalGalleryGridViewState>();

  void countSelectedGridItem() {
    selectedCount = selectedList.where((e) => e).length;
    allSelected = selectedCount == selectedList.length;
    textCountKey.currentState?.selectedCount = selectedCount;
    textCountKey.currentState?.allSelected = allSelected;
    if (selectedList.where((isSelected) => isSelected).isNotEmpty) {
      textCountKey.currentState?.isShowFileInf = false;
    } else {
      textCountKey.currentState?.isShowFileInf = true;
    }
    textCountKey.currentState?.setState(() {});
  }

  void markAllGrids() {
    if (!allSelected) {
      for (int i = 0; i < selectedList.length; i++) {
        selectedList[i] = true;
      }
      selectedCount = selectedList.where((e) => e).length;
      allSelected = selectedCount == selectedList.length;
      textCountKey.currentState?.selectedCount = selectedCount;
      textCountKey.currentState?.allSelected = allSelected;
      //select all
      textCountKey.currentState?.isAllSelected = true;
      imageListKey.currentState?.isSelectedAll = true;

      imageListKey.currentState?.setState(() {});

      allSelected = true;
    } else {
      //deselected
      for (int i = 0; i < selectedList.length; i++) {
        selectedList[i] = false;
      }
      selectedCount = selectedList.where((e) => e).length;
      allSelected = selectedCount == selectedList.length;
      textCountKey.currentState?.selectedCount = selectedCount;
      textCountKey.currentState?.allSelected = allSelected;

      textCountKey.currentState?.isAllSelected = false;
      imageListKey.currentState?.isSelectedAll = false;

      imageListKey.currentState?.setState(() {});
      allSelected = false;
    }
    textCountKey.currentState?.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      showAppAppbar: true,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16.w,
        ),
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gap(18.h),
                CustomText(
                  text: 'Medical Report',
                  textStyle: Theme.of(context).textTheme.titleSmall,
                  textFontWight: TextFontWight.bold,
                ),
                Gap(16.h),
                MedicalGalleryHorizontalListView(
                  model: model,
                  userType: widget.userType,
                ),
                Gap(50.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MedicalGalleryCountSelectedGridText(
                      allSelected: allSelected,
                      onTap: () => markAllGrids(),
                      selectedCount: selectedCount,
                      key: textCountKey,
                    ),
                    if (widget.userType == UserTypeEnum.fieldWorker)
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: InkWell(
                          onTap: () {
                            isShowDeselectAndRemove
                                ? CreateOverLay.toggleOverlay(
                                    context: context,
                                    left: 290.w,
                                    top: 350.h,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const CreateOverLayRow(
                                            imageSvgPath:
                                                'images/svg/trash.svg',
                                            text: 'Delete file',
                                            isShowDivider: true,
                                          ),
                                          CreateOverLayRow(
                                            imageSvgPath:
                                                'images/svg/gallery-remove.svg',
                                            text: 'Deselect',
                                            isShowDivider: false,
                                            onTap: () {
                                              setState(() {
                                                isSelectMode = false;
                                                for (int i = 0;
                                                    i < selectedList.length;
                                                    i++) {
                                                  selectedList[i] = false;
                                                }

                                                textCountKey.currentState
                                                    ?.isShowFileInf = true;
                                                textCountKey.currentState
                                                    ?.selectedCount = 0;
                                                CreateOverLay.removeOverlay();
                                                isShowDeselectAndRemove = false;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : CreateOverLay.toggleOverlay(
                                    context: context,
                                    left: 290.w,
                                    top: 350.h,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 8.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CreateOverLayRow(
                                            imageSvgPath:
                                                'images/svg/gallery-tick.svg',
                                            width: 100.w,
                                            text: 'Select',
                                            isShowDivider: false,
                                            onTap: () {
                                              setState(() {
                                                isSelectMode = true;
                                                imageListKey.currentState
                                                    ?.isSelectedAll = false;
                                                CreateOverLay.removeOverlay();
                                                isShowDeselectAndRemove = true;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                          },
                          child: const CustomImage(
                            imageSvgPath: 'images/svg/more-vertical.svg',
                            imageHeight: 24,
                            imageWidth: 24,
                          ),
                        ),
                      ),
                  ],
                ),
                MedicalGalleryGridView(
                  key: imageListKey,
                  isSelectMode: isSelectMode,
                  selectedList: selectedList,
                  onItemTapped: (int index, bool isSelected) {
                    selectedList[index] = isSelected;
                    countSelectedGridItem();
                  },
                ),
              ],
            ),
            if (widget.userType == UserTypeEnum.fieldWorker)
              MedicalGalleryFAB(
                takePhoto: () async {
                  final pickedFiles = await Utils.takePhoto();
                  if (pickedFiles != null && pickedFiles.isNotEmpty) {
                    setState(() {
                      // selectedList.add({pickedFiles.first: BottomSheetFileTypes.image});
                    });
                  }
                },
                chooseFile: () async {
                  final xFiles = await Utils.pickFiles();
                  if (xFiles == null || xFiles.isEmpty) {
                    return;
                  }
                  for (final file in xFiles) {
                    BottomSheetFileTypes type = BottomSheetFileTypes.document;
                    final mimeType = Utils.getFileExtension(file.name);
                    switch (mimeType) {
                      case '.mp3':
                        type = BottomSheetFileTypes.audio;
                        break;
                      case '.jpg':
                        type = BottomSheetFileTypes.image;
                        break;
                      case '.mp4':
                        type = BottomSheetFileTypes.video;
                        break;
                      case '.pdf':
                        type = BottomSheetFileTypes.document;
                        break;
                      case '.doc':
                        type = BottomSheetFileTypes.document;
                        break;
                      case '.aac':
                        type = BottomSheetFileTypes.audio;
                        break;
                    }
                    setState(() {
                      // files.add({file: type});
                    });
                  }
                },
                chooseFromGallery: () async {
                  final xFiles = await Utils.pickFiles();
                  if (xFiles == null || xFiles.isEmpty) {
                    return;
                  }
                  for (final file in xFiles) {
                    BottomSheetFileTypes type = BottomSheetFileTypes.document;
                    final mimeType = Utils.getFileExtension(file.name);
                    switch (mimeType) {
                      case '.mp3':
                        type = BottomSheetFileTypes.audio;
                        break;
                      case '.jpg':
                        type = BottomSheetFileTypes.image;
                        break;
                      case '.mp4':
                        type = BottomSheetFileTypes.video;
                        break;
                      case '.pdf':
                        type = BottomSheetFileTypes.document;
                        break;
                      case '.doc':
                        type = BottomSheetFileTypes.document;
                        break;
                      case '.aac':
                        type = BottomSheetFileTypes.audio;
                        break;
                    }
                    setState(() {
                      // files.add({file: type});
                    });
                  }
                },
              ),
          ],
        ),
      ),
    );
  }
}
