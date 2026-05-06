import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:math' as math;

import 'package:intl/intl.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

class Utils {
  static Future<T?> openDialog<T>({
    required final BuildContext context,
    required final Widget body,
    final String? submitText,
    final String? cancelText,
    final String? dialogTitle,
    final IconData? icon,
    final EdgeInsetsGeometry? contentPadding,
    final bool showSubmit = false,
    final bool showBackButton = false,
    final Function()? onSubmit,
    final VoidCallback? onClose,
    final double? width,
    final double? height,
    final bool barrierDismissible = true,
  }) =>
      showDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: contentPadding,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            icon: icon != null ? Icon(icon, size: 48) : null,
            iconColor: Colors.deepPurple,
            title: dialogTitle != null
                ? CustomText(text: dialogTitle, textStyle: Theme.of(context).textTheme.titleMedium , textFontWight: TextFontWight.bold,)
                : null,
            scrollable: true,
            content: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: width ?? 1000,
                minWidth: width ?? 0,
                minHeight: height ?? 0,
                maxHeight: height ?? MediaQuery.of(context).size.height * 0.6,
              ),
              child: body,
            ),
            actions: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CustomText(
                  text:cancelText??'close' ,
                  textStyle: Theme.of(context).textTheme.bodyLarge,
                  textFontWight: TextFontWight.bold,
                  textColor: OnlineClinicColorStyle.lightGray,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),

              if (onSubmit != null)
                GestureDetector(
                  onTap: () { onSubmit(); },
                  child: CustomText(
                    text:submitText??'submit' ,
                    textStyle: Theme.of(context).textTheme.bodyLarge,
                    textFontWight: TextFontWight.bold,
                    textColor: OnlineClinicColorStyle.dark,
                  ),
                ),



            ],
          );
        },
      ).then(
        (value) {
          onClose?.call();
          return value;
        },
      );

  static Future<BitmapDescriptor> getBitmapDescriptorFromSvgAsset(
      String assetName, [
        Size size = const Size(50, 50),
      ]) async {
    final pictureInfo = await vg.loadPicture(SvgAssetLoader(assetName), null);

    double devicePixelRatio = ui.window.devicePixelRatio;
    int width = (size.width * devicePixelRatio).toInt();
    int height = (size.height * devicePixelRatio).toInt();

    final scaleFactor = math.min(
      width / pictureInfo.size.width,
      height / pictureInfo.size.height,
    );

    final recorder = ui.PictureRecorder();

    ui.Canvas(recorder)
      ..scale(scaleFactor)
      ..drawPicture(pictureInfo.picture);

    final rasterPicture = recorder.endRecording();

    final image = rasterPicture.toImageSync(width, height);
    final bytes = (await image.toByteData(format: ui.ImageByteFormat.png))!;

    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  static Future<DateTime?> pickDate(BuildContext context,
      {int? dateRange}) async {
    DateTime now = DateTime.now();
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: now,
      lastDate: now.add(
        Duration(days: dateRange ?? 365 * 20),
      ),
      firstDate: now.subtract(
        Duration(days: dateRange ?? 365 * 50),
      ),
      cancelText: 'cancel',
      confirmText: 'ok',
      builder: (_, child) {
        return Theme(
          data:ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.green,

            useMaterial3: false,
            fontFamily: 'Poppins',
            datePickerTheme: DatePickerThemeData(
              backgroundColor: OnlineClinicColorStyle.white,
              headerBackgroundColor: OnlineClinicColorStyle.dark,
              headerForegroundColor:  OnlineClinicColorStyle.white,

              dayStyle: Theme.of(context).textTheme.bodyLarge,
              yearStyle: Theme.of(context).textTheme.bodyLarge,

              dayForegroundColor: MaterialStateProperty.all(OnlineClinicColorStyle.gray),
              cancelButtonStyle: ButtonStyle(
                  textStyle:

                  MaterialStateProperty.all(
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                      )
                  ),
                  foregroundColor: MaterialStateProperty.all(OnlineClinicColorStyle.lightGray,)
              ),
              confirmButtonStyle:ButtonStyle(
                  textStyle:

                  MaterialStateProperty.all(
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w900,
                      )
                  ),
                  foregroundColor: MaterialStateProperty.all(OnlineClinicColorStyle.dark,)
              ),
              weekdayStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: OnlineClinicColorStyle.lightGray5
              ),

              dayOverlayColor: const MaterialStatePropertyAll(
                  OnlineClinicColorStyle.primary
              ),
            ),

            colorScheme: const ColorScheme.light(
              primary: OnlineClinicColorStyle.primary,
            ),
          ) ,
          child: child!,
        );
      },
    );
    return date;
  }

  static Future<List<XFile>?> takePhoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      return [photo];
    } else {
      return null;
    }
  }

  static Future<List<XFile>?> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'pdf', 'doc', 'aac', 'jpg', 'mp4'],
    );
    if (result != null) {
      List<XFile> xFiles = result.xFiles;
      return xFiles;
    } else {
      return null;
    }
  }

  static String getFileExtension(String fileName) {
    return ".${fileName.split('.').last}".toLowerCase();
  }

  static List<String> formattedDate(DateTime date) {
    final DateFormat dayFormatter = DateFormat('E');  // E for weekday
    final DateFormat monthFormatter = DateFormat('MMM');  // MMM for short month
    final DateFormat dayNumFormatter = DateFormat('d');  // d for day
    String weekday = dayFormatter.format(date);
    String month = monthFormatter.format(date);
    int day = int.parse(dayNumFormatter.format(date));

    String suffix = getOrdinalSuffix(day);  // Optional: Function to get ordinal suffix (st, nd, rd, th)

    return [weekday , month,'$day$suffix']   ;
  }

  static String getOrdinalSuffix(int day) {
    if (day == 1) return 'st';
    if (day == 2) return 'nd';
    if (day == 3) return 'rd';
    return 'th';
  }
}
