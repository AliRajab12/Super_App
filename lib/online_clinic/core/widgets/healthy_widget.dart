import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/enums/blood_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay_row.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/dropDown/app_drop_down.dart';
import 'package:somi/online_clinic/core/widgets/blood_healthy_widget.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/widgets/editDialog.dart';
import 'package:somi/online_clinic/features/patientProfile/domain/entities/healthy_entity.dart';

class HealthyWidget extends StatelessWidget {
  HealthyWidget({
    super.key,
    required this.healthyEntity,
    required this.userType,
  });

  final HealthyEntity healthyEntity;
  final UserTypeEnum userType;
  final List<DropDownModel> bloodModelList = [];
  DropDownModel? selectedBlood;

  @override
  Widget build(BuildContext context) {
    if (healthyEntity.title == 'Blood') {
      for (var i = 0; i < BloodEnum.values.length; ++i) {
        bloodModelList.add(
          DropDownModel(
            id: BloodEnum.values[i].id,
            title: BloodEnum.values[i].value,
          ),
        );
      }
      selectedBlood = bloodModelList
          .firstWhere((element) => element.title == healthyEntity.value);
    }
    return GestureDetector(
      onTap: () {
        if (userType != UserTypeEnum.doctor) {
          if (healthyEntity.title == 'Blood') {
            return;
          }
          if (healthyEntity.title != 'Age') {
            Utils.openDialog(
                context: context,
                cancelText: 'Cancel',
                submitText: 'Save',
                dialogTitle: healthyEntity.title,
                showSubmit: true,
                onSubmit: () {
                  Navigator.pop(context);
                },
                body: EditDialog(
                  initValue: healthyEntity.value,
                  title: healthyEntity.title,
                ));
          } else {
            Utils.pickDate(context);
          }
        }
      },
      child: healthyEntity.title == 'Blood'
          ? StateFullHealthyWidget(
              userType: userType,
              healthyEntity: healthyEntity,
              bloodOnTap: (blood) {
                healthyEntity.value = blood.value;
                selectedBlood = DropDownModel(
                  id: blood.id,
                  title: blood.value,
                );
              },
            )
          : healthyEntity.title == 'Gender'
              ? StateFullHealthyWidget(
                  userType: userType,
                  healthyEntity: healthyEntity,
                  genderOnTap: (gender) {
                    healthyEntity.value = gender.gender;
                    selectedBlood = DropDownModel(
                      id: gender.id,
                      title: gender.gender,
                    );
                  },
                )
              : CustomContainer(
                  width: 54.w,
                  height: 40.h,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  border: Border.all(
                      color: OnlineClinicColorStyle.lightGray4, width: 1),
                  borderRadius: BorderRadius.all(Radius.circular(8.r)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: healthyEntity.title,
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        textColor: OnlineClinicColorStyle.lightGray4,
                      ),
                      Gap(4.h),
                      CustomText(
                        text: healthyEntity.value,
                        textStyle: Theme.of(context).textTheme.labelLarge,
                        textColor: OnlineClinicColorStyle.white,
                        textFontWight: TextFontWight.bold,
                      )
                    ],
                  ),
                ),
    );
  }
}
