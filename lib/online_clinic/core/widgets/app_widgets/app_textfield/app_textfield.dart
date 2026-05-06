import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';



enum AppTextFieldType {
  phoneNumber,
  email,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    this.hintText,
    this.inputType,
    this.validator,
    this.labelText,
    this.textInputAction,
    this.svgSuffixIcon,
    this.obscureText = false,
    this.maxLength,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.maxLines,
    this.minLines,
    this.inputFormatters,
    this.suffixText,
    this.onTap,
    this.labelStyle,
    this.hintStyle,
    this.style,
    this.decoration,
    this.enabledBorder,
    this.enabledBorderSide,
    this.enabledBorderColor,
    this.border,
    this.borderSide,
    this.borderColor,
    this.disabledBorder,
    this.disabledBorderSide,
    this.disabledBorderColor,
    this.enabled,
    this.errorBorder,
    this.errorBorderSide,
    this.errorBorderColor,
    this.contentPadding,
    this.onChanged,
    this.cursorHeight,
    this.cursorWidth,
    this.cursorColor,
    this.focusedBorder,
    this.focusedBorderSide,
    this.focusedBorderSideColor,
    this.floatingLabelStyle,
    this.errorStyle,
    this.svgPrefixIcon,
    this.onFieldSubmitted,
    this.onTapSuffix,
    this.boxColor,
    this.initialValue,
    this.width,
    this.height,
    this.paddingSize,
    this.onTapPrefix,
    this.borderRadius,
    this.appTextFieldType,
    this.showPrefix = true,
    this.showSuffix = true
  });

  final String? hintText;
  final double? paddingSize;
  final String? labelText;
  final TextInputType? inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final AutovalidateMode autoValidateMode;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final String? svgSuffixIcon;
  final Function()? onTapSuffix;
  final String? svgPrefixIcon;
  final Function()? onTapPrefix;
  final bool? enabled;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? errorStyle;
  final TextStyle? hintStyle;
  final List<TextInputFormatter>? inputFormatters;
  final String? suffixText;
  final AppTextFieldType? appTextFieldType;
  final Function(String)? onFieldSubmitted;

  final TextStyle? style;
  final InputDecoration? decoration;
  final void Function()? onTap;
  final InputBorder? enabledBorder;
  final BorderSide? enabledBorderSide;
  final Color? enabledBorderColor;
  final InputBorder? border;
  final BorderSide? borderSide;
  final Color? borderColor;
  final InputBorder? errorBorder;
  final BorderSide? errorBorderSide;
  final Color? errorBorderColor;
  final InputBorder? disabledBorder;
  final InputBorder? focusedBorder;
  final BorderSide? disabledBorderSide;
  final BorderSide? focusedBorderSide;
  final Color? disabledBorderColor;
  final Color? focusedBorderSideColor;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onChanged;
  final double? cursorHeight;
  final double? cursorWidth;
  final Color? cursorColor;
  final double? borderRadius;

  final Color? boxColor;
  final String? initialValue;
  final double? width;
  final double? height;
  final bool showPrefix;
  final bool showSuffix;

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) {
      controller.text = initialValue!;
    }
    return SizedBox(
      child: CustomContainer(
        margin: EdgeInsets.only(top: paddingSize ?? 5),
        width: width ?? 398.w,
        height: height ?? 50.h,
        borderRadius:
        BorderRadius.all(Radius.circular(borderRadius ?? 50.r)),
        color: boxColor ?? OnlineClinicColorStyle.white,
        elevationType: ElevationType.noElevation,
        child: TextFormField(
          autovalidateMode: autoValidateMode,
          onTap: () {
            if (onTap != null) onTap!();
          },

          onChanged: onChanged,
          enabled: enabled ?? true,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          minLines: minLines,
          maxLength: maxLength,
          // validator: (input) =>
          //     validator?.call(input) ??
          //     _validator(
          //       input: input,
          //       type: appTextFieldType!,
          //     ),
          obscureText: obscureText,
          controller: controller,
          style: style ?? Theme.of(context).textTheme.bodySmall,
          keyboardType: inputType,
          textInputAction: textInputAction,
          cursorHeight: cursorHeight,
          cursorColor: cursorColor,
          cursorWidth: cursorWidth ?? 2,
          onFieldSubmitted: onFieldSubmitted,
          decoration: decoration ??
              InputDecoration(
                floatingLabelStyle: floatingLabelStyle,
                errorStyle: errorStyle,
                contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 5.h),
                hintText: hintText,
                suffixIcon: showSuffix ?  Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      color: OnlineClinicColorStyle.gray,
                      width: 1.r,
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 16.r,
                        left: 8.r,
                        top: 12.r,
                        bottom: 12.r,
                      ),
                      child: InkWell(
                        onTap: onTapSuffix,
                        child: SvgPicture.asset(
                          svgSuffixIcon ?? 'images/svg/microphone.svg',
                        ),
                      ),
                    ),
                  ],
                ): null,
                prefixIcon: showPrefix? Padding(
                  padding: EdgeInsets.only(
                    right: 8.r,
                    left: 16.r,
                    top: 13.r,
                    bottom: 13.r,
                  ),
                  child: InkWell(
                    onTap: onTapPrefix,
                    child: SvgPicture.asset(
                      svgPrefixIcon ?? 'images/svg/search-normal.svg',
                    ),
                  ),
                ):null,
                labelText: labelText,
                suffixText: suffixText,
                labelStyle: labelStyle,
                hintStyle: hintStyle ??
                    TextStyle(
                      fontSize: 12.sp,
                      // height: 5,
                      fontWeight: FontWeight.w400,
                      color: OnlineClinicColorStyle.gray,
                    ),
                isDense: true,
                enabledBorder: enabledBorder ??
                    OutlineInputBorder(
                      borderSide: enabledBorderSide ??
                          BorderSide(
                            color: enabledBorderColor ?? OnlineClinicColorStyle.white,
                            width: 2,
                          ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius ?? 50.r)),
                    ),
                border: border ??
                    OutlineInputBorder(
                      borderSide: borderSide ??
                          BorderSide(
                            color: borderColor ?? OnlineClinicColorStyle.white,
                            width: 2,
                          ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius ?? 50.r)),
                    ),
                errorBorder: errorBorder ??
                    OutlineInputBorder(
                      borderSide: errorBorderSide ??
                          BorderSide(
                            color: errorBorderColor ??
                                borderColor ??
                                OnlineClinicColorStyle.white,
                            width: 2,
                          ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius ?? 50.r)),
                    ),
                disabledBorder: disabledBorder ??
                    OutlineInputBorder(
                      borderSide: disabledBorderSide ??
                          BorderSide(
                            color: disabledBorderColor ??
                                Theme.of(context).disabledColor,
                            width: 2,
                          ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius ?? 50.r)),
                    ),
                focusedBorder: focusedBorder ??
                    OutlineInputBorder(
                      borderSide: focusedBorderSide ??
                          BorderSide(
                            color: focusedBorderSideColor ?? OnlineClinicColorStyle.white,
                            width: 2,
                          ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(borderRadius ?? 50.r)),
                    ),
              ),
        ),
      ),
    );
  }

// String? _validator({
//   required String? input,
//   required AppTextFieldType type,
// }) {
//   switch (type) {
//     case AppTextFieldType.phoneNumber:
//       return (!ValidationFunctions.isValidPhoneNumber(input!))
//           ? 'Please Enter Valid Phone Number'
//           : null;
//     case AppTextFieldType.email:
//       return (!ValidationFunctions.isValidEmail(input!))
//           ? 'Please Enter Valid Email'
//           : null;
//     default:
//       return null;
//   }
// }
}
