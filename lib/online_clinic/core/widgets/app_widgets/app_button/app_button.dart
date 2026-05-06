import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/button_type.dart';
import 'package:somi/online_clinic/core/enums/enums.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';


// A widget that displays a styled button.
class AppButton extends StatelessWidget {
  // Controls the size of the widget.
  final AppWidgetSize size;

  // Method that is called when user presses the button. Button will become disabled if `null` is passed;
  final GestureTapCallback? onTap;

  // String to display inside of the button.
  final String? label;

  // A Widget . Will be placed on the start.
  final Widget? startIcon;

  // A Widget. Will be placed on the end.
  final Widget? endIcon;

  // Padding to use inside the button.
  final EdgeInsetsGeometry? padding;

  // Color to use for the background.
  final Color? backgroundColor;

  //? Color for border.
  final Color? borderColor;

  // disable button
  final bool isDisabled;

  // Loading button
  final bool isLoading;

  // Height button
  final double? height;

  // show custom child widget instead label
  final Widget? customChild;

  //Button Type from the types in app.
  final AppButtonType buttonType;
  final TextStyle? labelStyle;

  final double? borderRadius;
  final Color? labelColor;
  final double? widthp;
  final bool textButton;
  final bool hasElevation;

  const AppButton(
      {super.key,
      this.label,
      this.onTap,
      this.size = AppWidgetSize.medium,
      this.startIcon,
      this.endIcon,
      this.padding,
      this.backgroundColor,
      this.isDisabled = false,
      this.customChild,
      this.borderColor,
      this.isLoading = false,
      this.height,
      this.labelStyle,
      this.borderRadius,
      this.labelColor,
      this.widthp,
        this.hasElevation = true,
      this.textButton = false})
      : buttonType = AppButtonType.filled;

  const AppButton.filled({
    super.key,
    required this.label,
    required this.onTap,
    required this.backgroundColor,
    this.size = AppWidgetSize.small,
    this.isDisabled = false,
    this.isLoading = false,
    this.textButton = false,
    this.startIcon,
    this.endIcon,
    this.padding,
    this.borderColor,
    this.customChild,
    this.height,
    this.labelStyle,
    this.borderRadius,
    this.labelColor,
    this.widthp,
    this.hasElevation = true,
  }) : buttonType = AppButtonType.filled;

  const AppButton.disabled({
    super.key,
    required this.label,
    required this.onTap,
    this.size = AppWidgetSize.small,
    this.isDisabled = true,
    this.isLoading = false,
    this.startIcon,
    this.endIcon,
    this.padding,
    this.customChild,
    this.height,
    this.borderColor,
    this.labelStyle,
    this.borderRadius,
    this.labelColor,
    this.widthp,
    this.hasElevation = true,
    this.textButton = false,
  })  : buttonType = AppButtonType.disabled,
        backgroundColor = Colors.grey; //Theme.of(context).primaryColor.withOpacity(0.2);

  const AppButton.text({
    super.key,
    required this.label,
    required this.onTap,
    this.size = AppWidgetSize.small,
    this.isDisabled = false,
    this.isLoading = false,
    this.startIcon,
    this.endIcon,
    this.padding,
    this.customChild,
    this.height,
    this.borderColor,
    this.labelStyle,
    this.borderRadius,
    this.labelColor,
    this.widthp,
    this.hasElevation = false,
    this.textButton = true,
  })  : buttonType = AppButtonType.text,
        backgroundColor = null; //Theme.of(context).primaryColor.withOpacity(0.2);

  // double width(AppWidgetSize buttonSize, BuildContext context) {
  //   if (buttonSize == AppWidgetSize.giant) {
  //     return MediaQuery.of(context).size.width * 0.9;
  //   } else if (buttonSize == AppWidgetSize.large) {
  //     return MediaQuery.of(context).size.width * 0.7;
  //   } else if (buttonSize == AppWidgetSize.medium) {
  //     return MediaQuery.of(context).size.width * 0.4;
  //   } else if (buttonSize == AppWidgetSize.small) {
  //     return MediaQuery.of(context).size.width * 0.3;
  //   } else {
  //     return MediaQuery.of(context).size.width * 0.2;
  //   }
  // }

  const AppButton.outLined({
    super.key,
    required this.onTap,
    this.label,
    this.size = AppWidgetSize.small,
    this.isDisabled = false,
    this.isLoading = false,
    this.startIcon,
    this.endIcon,
    this.padding,
    this.customChild,
    this.height,
    this.borderColor,
    this.labelStyle,
    this.borderRadius,
    this.labelColor,
    this.widthp,
    this.hasElevation = false,
    this.textButton = true,
  })  : buttonType = AppButtonType.text,
        backgroundColor = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: hasElevation
          ? BoxDecoration(boxShadow: [OnlineClinicColorStyle.noneBoxShadow])
          : null,
      child: GestureDetector(
        onTap: (isLoading || isDisabled) ? null : onTap,
        // borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
        child: Container(
          margin: padding,
          height: textButton ? null : (height ?? 32.h),
          width: widthp,
          decoration: BoxDecoration(
              color: textButton ? null : _buttonColor(context),
              borderRadius: BorderRadius.circular(borderRadius ?? 50.r),
              border: borderColor != null ? Border.all(color: borderColor!) : null),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : customChild ??
                  Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      // width: widthLabel(size, context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          startIcon ?? const SizedBox(),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                            child: CustomText(
                              text: label ?? 'label',
                              textColor: labelColor ??
                                  (Theme.of(context).brightness == Brightness.light
                                      ? OnlineClinicColorStyle.white
                                      : OnlineClinicColorStyle.white),
                              textStyle: labelStyle ?? Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          endIcon ?? const SizedBox(),
                        ],
                      ),
                    ),
                  ),
        ),
      ),
    );
  }

  Color _buttonColor(BuildContext context) {
    if (buttonType == AppButtonType.text) {
      return Colors.white;
    } else if (isDisabled) {
      return (backgroundColor?.withOpacity(.2) ?? Theme.of(context).primaryColor.withOpacity(.2));
    } else {
      return backgroundColor ?? Theme.of(context).primaryColor;
    }
  }
}
