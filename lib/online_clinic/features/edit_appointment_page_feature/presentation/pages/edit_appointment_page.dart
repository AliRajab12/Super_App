import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/enums/blood_enum.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/patient_content_large_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/edit_appointment_entity.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/domain/entities/medical_report_entity.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/editable_text_field_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/medical_report_item_widget.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/upload_image_bottomsheet.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/wrapper_disease.dart';
import 'package:somi/online_clinic/features/location_feature/presentation/pages/location_page.dart';

@RoutePage()
class EditAppointmentPage extends StatefulWidget {
  EditAppointmentPage({
    required this.userType,
    required this.pageState,
    super.key,
  });

  static const String route = '/editAppointmentPage';

  UserTypeEnum userType;
  FieldWorkerPageStateEnum pageState;

  @override
  State<EditAppointmentPage> createState() => _EditAppointmentPageState();
}

class _EditAppointmentPageState extends State<EditAppointmentPage> {
  List<Map<XFile, BottomSheetFileTypes>> files = [];
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
    chronicDiseaseList: [
      DropDownModel(title: 'IHD'),
      DropDownModel(title: 'Obesity'),
      DropDownModel(title: 'Asthma'),
    ],
    geneticDiseaseList: [
      DropDownModel(title: 'Obesity'),
      DropDownModel(title: 'Diabetes'),
    ],
    surgeriesList: [
      DropDownModel(title: 'Appendectomy'),
      DropDownModel(title: 'Cesarean section'),
      DropDownModel(title: 'Cholecystectomy'),
      DropDownModel(title: 'Tonsillectomy'),
    ],
  );
  TextEditingController ageController = TextEditingController(text: 's');
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bloodController = TextEditingController();
  TextEditingController heartRateController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController fileNameController = TextEditingController();
  TextEditingController fileDescriptionController = TextEditingController();

  GlobalKey chronicKey = GlobalKey();

  @override
  void initState() {
    ageController = TextEditingController(text: model.age.toString());
    weightController = TextEditingController(text: model.weight.toString());
    heightController = TextEditingController(text: model.height.toString());
    bloodController = TextEditingController(text: '130');
    heartRateController =
        TextEditingController(text: model.heartRate.toString());
    temperatureController =
        TextEditingController(text: model.temperature.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      bottomNavigationBar:  Padding(
        padding: EdgeInsets.only(left: 16.w ,right: 16.w,bottom: 10.h),
        child: widget.pageState == FieldWorkerPageStateEnum.edit ? AppButton(
          label: 'Save Changes',
          height: 40.h,
          backgroundColor: OnlineClinicColorStyle.primary,
        ) : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppButton.filled(
              label: 'Accept',
              onTap: () {
                widget.pageState = FieldWorkerPageStateEnum.edit;
                setState(() {});
              },
              height: 40.h,
              backgroundColor: OnlineClinicColorStyle.primary),
        ),
      ),
      contentLargeAppBar: PatientContentLargeAppBar(
        fieldWorkerPageState: widget.pageState,
        userType: widget.userType,
        changeFieldWorkerPageState: (pageState) => setState(() {
          widget.pageState = pageState;
        }),
      ),
      child: widget.pageState == FieldWorkerPageStateEnum.edit
          ? _editPage(context)
          : const LocationPage(),
    );
  }

  Widget _editPage(BuildContext context) => SizedBox(
        width: 1.sw,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ageAndWeight(
                        ageController: ageController,
                        weightController: weightController,
                      ),
                      _bloodAndHeight(
                        bloodController: bloodController,
                        heightController: heightController,
                      ),
                      _heartRateAndTemperature(
                        heartRateController: heartRateController,
                        temperatureController: temperatureController,
                      ),
                      Gap(10.h),
                      WrapperDisease(
                        title: 'Chronic Disease',
                        onTapAdd: (position, valueAdded) {
                          model.chronicDiseaseList.add(valueAdded);
                          setState(() {});
                        },
                        items: model.chronicDiseaseList,
                        onTapClose: (index) {
                          model.chronicDiseaseList.removeAt(index);
                          setState(() {});
                        },
                      ),
                      WrapperDisease(
                        title: 'Surgeries',
                        onTapAdd: (position, valueAdded) {
                          model.surgeriesList.add(valueAdded);
                          setState(() {});
                        },
                        items: model.surgeriesList,
                        onTapClose: (index) {
                          model.surgeriesList.removeAt(index);
                          setState(() {});
                        },
                      ),
                      WrapperDisease(
                        title: 'Genetic Disease',
                        onTapAdd: (position, valueAdded) {
                          model.geneticDiseaseList.add(valueAdded);
                          setState(() {});
                        },
                        items: model.geneticDiseaseList,
                        onTapClose: (index) {
                          model.geneticDiseaseList.removeAt(index);
                          setState(() {});
                        },
                      ),
                      _observationHeader(context),
                      _observationsList(model.reportList),
                      Gap(4.h),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      );

  Widget _ageAndWeight({
    required TextEditingController ageController,
    required TextEditingController weightController,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.r,
          vertical: 8.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: EditableTextFieldWidget(
                controller: ageController,
                label: 'Blood Presser',
                textInputType: TextInputType.number,
              ),
            ),
            Gap(8.w),
            Expanded(
              child: EditableTextFieldWidget(
                controller: weightController,
                label: 'blood glucose',
                textInputType: TextInputType.number,
              ),
            ),
          ],
        ),
      );

  Widget _bloodAndHeight({
    required TextEditingController bloodController,
    required TextEditingController heightController,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.r,
          vertical: 8.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: EditableTextFieldWidget(
                controller: bloodController,
                label: 'Pulse',
              ),
            ),
            Gap(8.w),
            Expanded(
              child: EditableTextFieldWidget(
                controller: heightController,
                label: 'Respiration',
                textInputType: TextInputType.number,
              ),
            ),
          ],
        ),
      );

  Widget _heartRateAndTemperature({
    required TextEditingController temperatureController,
    required TextEditingController heartRateController,
  }) =>
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.r,
          vertical: 8.w,
        ),
        child: Row(
          children: [
            Expanded(
              child: EditableTextFieldWidget(
                controller: heartRateController,
                label: 'Oxygen',
                textInputType: TextInputType.number,
              ),
            ),
            Gap(8.w),
            Expanded(
              child: EditableTextFieldWidget(
                controller: temperatureController,
                label: 'Temperature',
                textInputType: TextInputType.number,
              ),
            ),
          ],
        ),
      );

  Widget _observationsList(List<MedicalReportEntity> medicalReports) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: medicalReports.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            GlobalKey<_EditAppointmentPageState> uniqueKey =
                GlobalKey<_EditAppointmentPageState>();
            return MedicalReportItemWidget(
              model: medicalReports[index],
              onTap: () {
                locator<MainRouter>().push(
                  MedicalGalleryPageRoute(userType: UserTypeEnum.fieldWorker),
                );
              },
              moreIconKey: uniqueKey,
              moreOnTap: () {
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
                  left: position.dx - 100.w,
                  top: position.dy + 20.h,
                  width: 116.w,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.r))),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CreateOverLayRow(
                          imageSvgPath: 'images/svg/trash.svg',
                          text: 'Delete file',
                          isShowDivider: true,
                          width: 142.w,
                          onTap: () {
                            model.reportList.removeAt(index);
                            CreateOverLay.removeOverlay();
                            setState(() {});
                          },
                        ),
                        CreateOverLayRow(
                          imageSvgPath: 'images/svg/edit-2.svg',
                          text: 'Edit file name',
                          isShowDivider: false,
                          width: 142.w,
                          onTap: () {
                            _showButtonSheet(context, () {
                              model.reportList[index].title =
                                  fileNameController.text == ''
                                      ? 'New Name'
                                      : fileNameController.text;
                              setState(() {});
                            });
                            CreateOverLay.removeOverlay();
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      );

  Widget _observationHeader(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: TitleWidget(
          title: 'Medical Report',
          subtitle: '',
          action: InkWell(
            onTap: () {
              _showButtonSheet(context, () {
                model.reportList.add(
                  MedicalReportEntity(
                    title: 'CT Scan - Abdomen',
                    reportDate: DateTime.now(),
                    documentSize: '2T',
                    documentType: 'PDF',
                    document: null,
                  ),
                );
                setState(() {});
              });
            },
            child: Row(
              children: [
                CustomText(
                  text: 'Add ',
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
      );

  Future<void> _showButtonSheet(
      BuildContext context, Function() onTapSubmit) async {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      //  showDragHandle: true,

      // backgroundColor: Color(0xffF3F7FF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: UploadImageBottomSheet(
              files: files,
              nameController: fileNameController,
              descriptionController: fileDescriptionController,
              onChooseFromGallery: () async {
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
                    files.add({file: type});
                  });
                }
              },
              onChooseFile: () async {
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
                    files.add({file: type});
                  });
                }
              },
              onTakePhoto: () async {
                final pickedFiles = await Utils.takePhoto();
                if (pickedFiles != null && pickedFiles.isNotEmpty) {
                  setState(() {
                    files.add({pickedFiles.first: BottomSheetFileTypes.image});
                  });
                }
              },
              onTapSubmit: () {
                Navigator.pop(context);
                onTapSubmit();
              },
            ),
          );
        });
      },
    );
  }
}
