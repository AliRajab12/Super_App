import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:somi/online_clinic/core/models/appointment.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/dropDown/app_drop_down.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class SelectAppoitmentDialog extends StatefulWidget {
  const SelectAppoitmentDialog(
      {super.key,
      required this.years,
      required this.appointments,
      required this.onSelectDate});

  final List<DropDownModel> years;
  final List<Appointment> appointments;
  final Function(DateTime selected) onSelectDate;

  @override
  State<SelectAppoitmentDialog> createState() => _SelectAppoitmentDialogState();
}

class _SelectAppoitmentDialogState extends State<SelectAppoitmentDialog> {
  Map<Month, int>? selectedDate;
  DropDownModel? selectedYear;
  final List<DropDownModel> yearsModel = [
    DropDownModel(
      title: '2024',
      id: 2024,
    ),
    DropDownModel(
      title: '2025',
      id: 2025,
    ),
  ];
  DateTime initialDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 286.h,
      width: 398.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomContainer(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.h),
            color: OnlineClinicColorStyle.dark1,
            // height: 286.h,
            width: 398.w,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Appointments in',
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  textFontWight: TextFontWight.bold,
                  textColor: OnlineClinicColorStyle.white,
                ),
                // CustomText(
                //   text: ' 2024',
                //   textStyle: Theme.of(context).textTheme.bodyMedium ,
                //   textFontWight: TextFontWight.bold,
                //   textColor: OnlineClinicColorStyle.white,
                // ),
                //
                // const Icon(Icons.keyboard_arrow_down , color: OnlineClinicColorStyle.white),
                Material(
                  color: Colors.transparent,
                  child: _getYear(context),
                ),
              ],
            ),
          ),
          CustomContainer(
            border: const Border(
                bottom: BorderSide(
                    color: OnlineClinicColorStyle.lightColor3, width: 1)),
            width: 398.w,
            child: ColoredBox(
              color: OnlineClinicColorStyle.white,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 9.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...Month.values.map((e) => Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 9.h),
                              child: CustomText(
                                  text: toBeginningOfSentenceCase(e.name)!,
                                  textStyle:
                                      Theme.of(context).textTheme.labelMedium,
                                  textColor: OnlineClinicColorStyle.dark,
                                  textFontWight: TextFontWight.bold),
                            ),
                            ...widget.appointments
                                    .firstWhereOrNull(
                                        (element) => element.month == e)
                                    ?.visitDays
                                    .map(
                                      (day) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selectedDate = {e: day};
                                          });
                                          final dateTime = DateTime(
                                              int.tryParse(
                                                      selectedYear?.title ??
                                                          '2024') ??
                                                  2024,
                                              e.index + 1,
                                              day);
                                          widget.onSelectDate(dateTime);
                                        },
                                        child: CustomContainer(
                                          width: 25.w,
                                          margin: EdgeInsets.only(top: 4.h),
                                          height: 25.h,
                                          color: selectedDate?.keys.first ==
                                                      e &&
                                                  selectedDate?.values.first ==
                                                      day
                                              ? OnlineClinicColorStyle
                                                  .primaryLight1
                                              : OnlineClinicColorStyle
                                                  .lightColor2,
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          child: Center(
                                            child: CustomText(
                                              text: day.toString(),
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .labelMedium,
                                              textFontWight: TextFontWight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ) ??
                                []
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getYear(final BuildContext context) => AppDropDown(
        selectedTextColor: OnlineClinicColorStyle.white,
        initValue: yearsModel.firstWhere(
          (element) => element.id == initialDate.year,
        ),
        itemList: yearsModel,
        onSelected: (value) {
          int year = value.id!;
          DateTime tempDate = initialDate;
          initialDate = DateTime(
            year,
            tempDate.month,
            tempDate.day,
            tempDate.hour,
            tempDate.minute,
          );
        },
      );
}
