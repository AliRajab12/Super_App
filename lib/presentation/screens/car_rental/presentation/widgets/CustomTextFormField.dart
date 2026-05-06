import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const Color textColor = Color(0xff290657);

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    Key? key,
    this.controller,
    this.labelText,
    this.hintText,
    this.hintStyle,
    this.icon,
    this.onSaved,
    this.keyboardType,
    this.iconPaddingLeft,
    this.iconPaddingRight,
    this.iconPaddingTop,
    this.iconPaddingbottom,
    this.textPaddingLeft,
    this.textPaddingRight,
    this.textPaddingTop,
    this.textPaddingbottom,
    this.isborder = false,
    this.prefixIcon = false,
    this.hasFill = true,
    this.suffixIcon = false,
    this.inputFormatters,
    this.dropDownIconPaddingLeft,
    this.dropDownIconPaddingRight,
    this.dropDownIconPaddingTop,
    this.dropDownIconPaddingbottom,
    this.maxLines,
    this.obscureText = false,
    this.validate,
    this.onChanged,
    this.onTap,
    this.closeKeyBoard = false,
    this.autofocus = false,
    this.color,
    this.enabled = true,
    required this.required,
    this.length,
    this.isRRadius = true,
  }) : super(key: key);

  final TextEditingController? controller;

  final String? labelText;
  final String? hintText;

  final Widget? icon;
  final bool? prefixIcon;
  final TextStyle? hintStyle;

  final double? iconPaddingLeft;
  final double? iconPaddingRight;
  final double? iconPaddingTop;
  final double? iconPaddingbottom;

  final double? textPaddingLeft;
  final double? textPaddingRight;
  final double? textPaddingTop;
  final double? textPaddingbottom;

  final bool? isborder;
  final bool hasFill;

  final int? maxLines;

  final Color? color;
  final int? length;
  final bool suffixIcon;
  final double? dropDownIconPaddingLeft;
  final double? dropDownIconPaddingRight;
  final double? dropDownIconPaddingTop;
  final double? dropDownIconPaddingbottom;

  final TextInputType? keyboardType;
  List<TextInputFormatter>? inputFormatters;
  final bool required;
  final bool obscureText;

  final bool closeKeyBoard;
  final bool isRRadius;
  final bool autofocus;
  final bool enabled;
  final String? Function(String?)? validate;

  final Function()? onTap;
  final Function(String?)? onSaved;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (required)
            const Text(" *",
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.red, fontSize: 20)),
          if (required) const Divider(height: 2, color: Colors.transparent),
          SizedBox(
            width: double.infinity,
            child: TextFormField(
              inputFormatters: inputFormatters,
              onChanged: onChanged,
              onTap: onTap,
              enabled: enabled,
              onSaved: onSaved,
              controller: controller,
              validator: controller == null
                  ? null
                  : validate ??
                      (i) {
                        if (i!.isEmpty) {
                          return "this field is needed";
                        }
                        return null;
                      },
              keyboardType: keyboardType,
              readOnly: closeKeyBoard,
              autofocus: autofocus,
              maxLength: length,
              obscureText: obscureText,
              textAlignVertical: TextAlignVertical.center,
              maxLines: maxLines ?? 1,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintStyle: hintStyle ??
                    const TextStyle(color: Colors.red, fontSize: 20),
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                isDense: true,
                filled: hasFill,
                fillColor: color ?? Colors.white,
                isCollapsed: true,
                suffixIcon: suffixIcon == true
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: iconPaddingLeft ?? 20,
                          right: iconPaddingRight ?? 20,
                          top: iconPaddingTop ?? 20,
                          bottom: iconPaddingbottom ?? 20,
                        ),
                        child: icon,
                      )
                    : null,
                prefixIcon: prefixIcon == true
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: dropDownIconPaddingLeft ?? 20,
                          right: dropDownIconPaddingRight ?? 20,
                          top: dropDownIconPaddingTop ?? 20,
                          bottom: dropDownIconPaddingbottom ?? 20,
                        ),
                        child: icon,
                      )
                    : null,
                labelText: labelText,
                hintText: hintText ?? '',
                alignLabelWithHint: true,
                labelStyle: Theme.of(context).textTheme.labelMedium,
                counterStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding: EdgeInsets.only(
                  left: textPaddingLeft ?? 20,
                  right: textPaddingRight ?? 20,
                  top: textPaddingTop ?? 20,
                  bottom: textPaddingbottom ?? 20,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: isborder == true
                      ? const BorderSide(color: Colors.grey, width: 1.0)
                      : const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: !isRRadius
                      ? BorderRadius.circular(10)
                      : BorderRadius.all(maxLines == null
                          ? const Radius.circular(50.0)
                          : const Radius.circular(10.0)),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: isborder == true
                      ? const BorderSide(color: Colors.red, width: 1.0)
                      : const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: !isRRadius
                      ? BorderRadius.circular(10)
                      : BorderRadius.all(maxLines == null
                          ? const Radius.circular(50.0)
                          : const Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: isborder == true
                      ? const BorderSide(color: Colors.black, width: 1.0)
                      : const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: !isRRadius
                      ? BorderRadius.circular(10)
                      : BorderRadius.all(maxLines == null
                          ? const Radius.circular(50.0)
                          : const Radius.circular(10.0)),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: isborder == true
                      ? const BorderSide(color: Colors.red, width: 1.0)
                      : const BorderSide(color: Colors.transparent, width: 0.0),
                  borderRadius: !isRRadius
                      ? BorderRadius.circular(10)
                      : BorderRadius.all(maxLines == null
                          ? const Radius.circular(50.0)
                          : const Radius.circular(10.0)),
                ),
              ),
            ),
          )
        ]);
  }
}
