import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/models/drop_down_model.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class AppDropDown extends StatefulWidget {
   AppDropDown({
    super.key,
    required this.itemList,
    this.initValue,
    required this.onSelected,
    this.fixedLabel,
    this.selectedTextColor,
    this.optional,
    this.showSearch,
    this.isLoading,
    this.useMultiSelect,
    this.onSelectedMultiSelect,
    this.selectedWidget,
    this.multiSelectItems,
  });

  final List<DropDownModel> itemList;
  final List<DropDownModel>? multiSelectItems;
  final Function(DropDownModel) onSelected;
  DropDownModel? initValue;
  final String? fixedLabel;
  final bool? optional;
  final bool? showSearch;
  final bool? isLoading;
  final bool? useMultiSelect;
  final Color? selectedTextColor;
  final Widget? selectedWidget;
  final Function(List<DropDownModel> userListSelected)? onSelectedMultiSelect;

  @override
  State<AppDropDown> createState() => _SimpleDropDownState();
}

class _SimpleDropDownState extends State<AppDropDown> {
  DropDownModel? dropDownValue;

  TextEditingController searchController = TextEditingController();
  List<DropDownModel> selectedItems = [];
  bool isInit = false;

  @override
  void initState() {
    if (widget.initValue != null) {
      selectedItems = [widget.initValue!];
    }

    if (widget.multiSelectItems != null) {
      selectedItems = widget.multiSelectItems!;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.itemList.isNotEmpty && widget.initValue != null) {
      dropDownValue = widget.initValue ?? widget.itemList[0];
      if (!isInit) {
        isInit = true;
        selectedItems = [widget.initValue!];
        if (widget.multiSelectItems != null) {
          selectedItems = widget.multiSelectItems!;
        }
      }
    } else if (widget.itemList.isEmpty) {
      selectedItems.clear();
      dropDownValue = null;
    }
    return Container(
      height: 45.h,
      constraints: BoxConstraints(minWidth: 90.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<DropDownModel>(
            iconStyleData: IconStyleData(
                icon: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      size: 20.r,
                      color: widget.selectedTextColor,
                    )),
                iconSize: 17.r),
            isExpanded: false,
            dropdownStyleData: DropdownStyleData(
              offset: Offset(0, -5.h),
              maxHeight: 360.h,
              scrollbarTheme: ScrollbarThemeData(
                thumbVisibility: MaterialStateProperty.all(true),
                trackColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                thumbColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 9.h),
              decoration: BoxDecoration(
                  color: OnlineClinicColorStyle.white,
                  borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  boxShadow: [
                    OnlineClinicColorStyle.noneBoxShadow,
                    // BoxShadow(
                    //     color: Theme.of(context).colorScheme.primary,
                    //     spreadRadius: 0.1,
                    //     offset: const Offset(0, 4))
                  ]),
              elevation: 8,
            ),
            menuItemStyleData: MenuItemStyleData(
                height: 40.h,
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                selectedMenuItemBuilder: (context, child) {
                  return Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                        color: OnlineClinicColorStyle.lightColor3,
                        borderRadius: BorderRadius.all(Radius.circular(5.r))),
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    padding: EdgeInsets.only(left: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: dropDownValue?.title ?? '',
                          textStyle: Theme.of(context).textTheme.bodySmall,
                          textFontWight: TextFontWight.medium,
                          // textColor: Theme.of(context).primaryColor,
                          textColor: OnlineClinicColorStyle.dark,
                        ),
                        if (dropDownValue?.subTitle != null)
                          CustomText(
                            text: dropDownValue!.subTitle!,
                            textStyle: Theme.of(context).textTheme.bodyMedium,
                            textFontWight: TextFontWight.regular,
                            // textColor: Theme.of(context).primaryColor,
                          ),
                      ],
                    ),
                  );
                }),
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              setState(() {
                dropDownValue = value!;
                widget.initValue = value;
              });
              widget.onSelected(value!);
            },
            value: dropDownValue,
            underline: const SizedBox(),

            /// title selected
            selectedItemBuilder: (context) {
              return widget.itemList.map(
                (item) {
                  return widget.selectedWidget ?? Container(
                    alignment: AlignmentDirectional.centerStart,
                    padding: EdgeInsets.only(left: 5.w),
                    child: CustomText(
                        text: item.title,
                        textFontWight: TextFontWight.medium,
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        textColor: widget.selectedTextColor ?? OnlineClinicColorStyle.dark2),
                  );
                },
              ).toList();
            },
            items: widget.itemList
                .map((DropDownModel item) => DropdownMenuItem<DropDownModel>(
                    value: item,
                    child: Container(
                      height: 26.h,
                      margin: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: item.title,
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            textFontWight: TextFontWight.medium,
                          ),
                          if (item.subTitle != null)
                            CustomText(
                              text: item.subTitle!,
                              textStyle: Theme.of(context).textTheme.bodyMedium,
                              textFontWight: TextFontWight.regular,
                              // textColor: Theme.of(context).primaryColor,
                            ),
                        ],
                      ),
                    )))
                .toList()),
      ),
    );
  }
}
