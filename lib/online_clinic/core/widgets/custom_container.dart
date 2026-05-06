import 'package:flutter/material.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    this.borderRadius,
    this.shape,
    this.margin,
    this.padding,
    this.border,
     this.child,
     this.width,
    this.height,
    this.gradient,
    this.color,
    this.boxShadow,
    this.boxConstraints,
    this.backgroundBlendMode,
    this.decorationImage,
    this.elevationType
  });

  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final double? width;
  final double? height;
  final Widget? child;
  final BoxBorder? border;
  final BoxShape? shape;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final BoxConstraints? boxConstraints;
  final BlendMode? backgroundBlendMode;
  final DecorationImage? decorationImage;
  final ElevationType ? elevationType;

  BoxShadow getElevation(){
    switch(elevationType){

      case null:
      case ElevationType.noElevation:
       return OnlineClinicColorStyle.noneBoxShadow;

      case ElevationType.lowElevation:
        return OnlineClinicColorStyle.lowBoxShadow;
      case ElevationType.mediumElevation:
        return OnlineClinicColorStyle.mediumBoxShadow;
      case ElevationType.highElevation:
        return OnlineClinicColorStyle.highBoxShadow;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      margin: margin,
      constraints: boxConstraints,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        boxShadow: boxShadow ??( elevationType != null ? [ getElevation() ]: null),
        border: border,
        image: decorationImage,
        color: color,
        gradient: gradient,
        shape: shape ?? BoxShape.rectangle,
        backgroundBlendMode: backgroundBlendMode
      ),
      child: child,
    );
  }
}

enum ElevationType{
  noElevation,
  lowElevation,
  mediumElevation,
  highElevation,
}
