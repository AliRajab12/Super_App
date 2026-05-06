import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {super.key,
      this.url,
      this.showFullScreen = false,
      this.imageSvgPath,
      this.imageFile,
      this.imageSvgSource,
      this.imageHeight,
      this.imageWidth,
      this.boxFit,
      this.showAge,
      this.age,
      this.imagePngOrJpgPath,
      this.borderRadius,
      this.svgColor,
        this.onTap,
      this.rotateDegree});

  final String? url;
  final BoxFit? boxFit;
  final bool? showAge;
  final bool showFullScreen;
  final num? age;
  final double? imageWidth;
  final double? imageHeight;
  final File? imageFile;
  final String? imageSvgPath;
  final String? imageSvgSource;
  final String? imagePngOrJpgPath;
  final double? borderRadius;
  final Color? svgColor;
  final double? rotateDegree;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return url != null ||
            imageFile != null ||
            imageSvgPath != null ||
            imagePngOrJpgPath != null
        ? RotationTransition(
            turns: AlwaysStoppedAnimation((rotateDegree ?? 0) / 360),
            child: SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: onTap != null ? GestureDetector(
                onTap: ()  {
                  if(showFullScreen && imageSvgPath == null){
                    locator<MainRouter>().push(
                      FullScreenPhotoPageRoute(
                        pngUrl: imagePngOrJpgPath!,
                      ),
                    );
                  }
                  if(onTap!=null){
                    onTap!();
                  }



                },
                child: ClipRRect(
                    borderRadius:
                        BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                    child: _buildPicture()),
              ) : ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(borderRadius ?? 0)),
                  child: _buildPicture()),
            ),
          )
        : const Center(
            child: Icon(Icons.error_outline),
          );
  }

  Widget _buildPicture() {
    if (imageFile != null) {
      return SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: Image.file(
            imageFile!,
            fit: boxFit ?? BoxFit.cover,
          ));
    }
    if (imageSvgPath != null) {
      return SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: SvgPicture.asset(
            imageSvgPath!,
            colorFilter: svgColor != null
                ? ColorFilter.mode(svgColor!, BlendMode.srcIn)
                : null,
          ));
    }
    if (imageSvgSource != null) {
      return SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: SvgPicture.string(imageSvgSource!));
    }
    if (imagePngOrJpgPath != null) {
      return SizedBox(
          height: imageHeight,
          width: imageWidth,
          child: Image.asset(imagePngOrJpgPath!));
    }
    if (url != null && imageFile == null && url?.trim() != '') {
      return Image.network(
        url!,
        cacheWidth: 200,
        cacheHeight: 200,
        height: imageHeight,
        width: imageWidth,
        fit: boxFit ?? BoxFit.cover,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return SizedBox(
            height: imageHeight,
            width: imageWidth,
            child: const Center(
              child: Icon(Icons.error_outline),
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }
}
