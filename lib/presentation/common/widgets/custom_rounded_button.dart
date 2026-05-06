import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';

class CustomRoundedButton extends StatelessWidget {
  final String? text;
  final Function? pressed;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final Icon? icon;
  final double? width;
  final double? height;
  final double? border;
  final bool? iconLeft;
  final bool? load;
  final double? fontSize;
  final bool? springButton;
  const CustomRoundedButton(
      {Key? key,
      this.pressed,
      this.text,
      this.border,
      this.backgroundColor,
      this.borderColor,
      this.icon,
      this.textColor,
      this.width,
      this.iconLeft = false,
      this.height,
      this.fontSize,
      this.springButton,
      this.load})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (pressed != null) pressed!();
      },
      child: Container(
        width: width ?? MediaQuery.of(context).size.width,
        height: height ?? 50,
        decoration: BoxDecoration(
          color: backgroundColor ?? SomiColors.blue,
          borderRadius: BorderRadius.circular(border ?? 25),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: load == true
            ? Container(
                alignment: AlignmentDirectional.center,
                width: MediaQuery.of(context).size.width - 24,
                height: 48,
                child: const SizedBox(
                  width: 36,
                  height: 36,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : iconLeft == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (icon == null) ? Container() : icon!,
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        text!,
                        style: TextStyle(
                            color: textColor ?? Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      text!,
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                        fontWeight: FontWeight.w400,
                        fontSize: fontSize ?? 16,
                      ),
                    ),
                  ),
      ),
    );
  }
}
