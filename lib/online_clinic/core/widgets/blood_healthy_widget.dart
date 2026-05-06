import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/enums/blood_enum.dart';
import 'package:somi/online_clinic/core/enums/gender_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/dropDown/app_drop_down.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/editDialog.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/healthy_entity.dart';

class StateFullHealthyWidget extends StatefulWidget {
  const StateFullHealthyWidget({
    super.key,
    this.bloodOnTap,
    this.genderOnTap,
    required this.healthyEntity,
    required this.userType,
  });

  final HealthyEntity healthyEntity;
  final UserTypeEnum userType;
  final void Function(BloodEnum)? bloodOnTap;
  final void Function(GenderEnum)? genderOnTap;

  @override
  State<StateFullHealthyWidget> createState() => _StateFullHealthyWidgetState();
}

class _StateFullHealthyWidgetState extends State<StateFullHealthyWidget> {
  final List<DropDownModel> bloodModelList = [];
  final List<DropDownModel> genderModelList = [];

  DropDownModel? selectedBlood;
  DropDownModel? selectedGender;

  @override
  Widget build(BuildContext context) {
    if (widget.healthyEntity.title == 'Blood') {
      for (var i = 0; i < BloodEnum.values.length; ++i) {
        bloodModelList.add(
          DropDownModel(
            id: BloodEnum.values[i].id,
            title: BloodEnum.values[i].value,
          ),
        );
      }
      selectedBlood = bloodModelList
          .firstWhere((element) => element.title == widget.healthyEntity.value);
    }
    if (widget.healthyEntity.title == 'Gender') {
      for (var i = 0; i < GenderEnum.values.length; ++i) {
        genderModelList.add(
          DropDownModel(
            id: GenderEnum.values[i].id,
            title: GenderEnum.values[i].gender,
          ),
        );
      }
      selectedGender = genderModelList
          .firstWhere((element) => element.title == widget.healthyEntity.value);
    }
    GlobalKey<_StateFullHealthyWidgetState> uniqueKey =
        GlobalKey<_StateFullHealthyWidgetState>();
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.userType != UserTypeEnum.doctor) {
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
              left: widget.healthyEntity.title == 'Gender'
                  ? position.dx + 5.w
                  : position.dx + 10.w,
              top: position.dy + 50.h,
              width: widget.healthyEntity.title == 'Gender' ? 60.w : 50.w,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.r))),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.healthyEntity.title == 'Gender') ...genderList(),
                    if (widget.healthyEntity.title == 'Blood') ...bloodList(),
                  ],
                ),
              ),
            );
          }
        });
      },
      child: CustomContainer(
        key: uniqueKey,
        width: 54.w,
        height: 40.h,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        border: Border.all(color: OnlineClinicColorStyle.lightGray4, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(8.r)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: widget.healthyEntity.title,
              textStyle: Theme.of(context).textTheme.labelLarge,
              textColor: OnlineClinicColorStyle.lightGray4,
            ),
            Gap(4.h),
            CustomText(
              text: widget.healthyEntity.value,
              textStyle: Theme.of(context).textTheme.labelLarge,
              textColor: OnlineClinicColorStyle.white,
              textFontWight: TextFontWight.bold,
            )
          ],
        ),
      ),
    );
  }

  List<CreateOverLayRow> bloodList() {
    List<CreateOverLayRow> list = [];
    for (var i = 0; i < BloodEnum.values.length; ++i) {
      list.add(
        CreateOverLayRow(
          text: BloodEnum.values[i].value,
          isShowDivider: i != 8,
          width: 30.w,
          onTap: () {
            setState(() {
              widget.healthyEntity.value = BloodEnum.values[i].value;
              selectedBlood = DropDownModel(
                title: BloodEnum.values[i].value,
                id: BloodEnum.values[i].id,
              );
              widget.bloodOnTap!
                  .call(BloodEnum.fromValue(widget.healthyEntity.value));
              CreateOverLay.removeOverlay();
            });
          },
        ),
      );
    }
    return list;
  }

  List<CreateOverLayRow> genderList() {
    List<CreateOverLayRow> list = [];
    for (var i = 0; i < GenderEnum.values.length; ++i) {
      list.add(
        CreateOverLayRow(
          text: GenderEnum.values[i].gender,
          isShowDivider: i != 1,
          width: 40.w,
          onTap: () {
            setState(() {
              widget.healthyEntity.value = GenderEnum.values[i].gender;
              selectedBlood = DropDownModel(
                title: GenderEnum.values[i].gender,
                id: GenderEnum.values[i].id,
              );
              widget.genderOnTap!
                  .call(GenderEnum.fromValue(widget.healthyEntity.value));
              CreateOverLay.removeOverlay();
            });
          },
        ),
      );
    }
    return list;
  }
}
