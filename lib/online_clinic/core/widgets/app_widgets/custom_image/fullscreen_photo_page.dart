import 'package:auto_route/auto_route.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';

@RoutePage()
class FullScreenPhotoPage extends StatefulWidget {
  static const route = '/fullScreenPhotoPage';

  const FullScreenPhotoPage({
    required this.pngUrl,
    super.key,
  });

  final String pngUrl;

  @override
  State<FullScreenPhotoPage> createState() => _FullScreenPhotoPageState();
}

class _FullScreenPhotoPageState extends State<FullScreenPhotoPage> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
        overlays: [SystemUiOverlay.top]);
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    checkOrientation();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values); // to re-show bars
    super.dispose();
    NativeDeviceOrientationCommunicator().pause();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  bool _isShowDetail = false;

  @override
  Widget build(BuildContext context) {
    if (_isShowDetail) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values); // to re-show bars
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
          overlays: [SystemUiOverlay.top]);
    }
    return Scaffold(
      // showAppAppbar: false,

      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isShowDetail = !_isShowDetail;
              });
            },
            child: EasyImageView(
              imageProvider: AssetImage(widget.pngUrl),
              doubleTapZoomable: true,
            ),
          ),
          if (_isShowDetail)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: OnlineClinicColorStyle.white,
              height:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 30.w
                      : 80.h,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 24,
                      color: OnlineClinicColorStyle.dark,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Head CT Scan',
                        textStyle: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? Theme.of(context).textTheme.labelMedium
                            : Theme.of(context).textTheme.bodyMedium,
                        textFontWight: TextFontWight.bold,
                        textColor: OnlineClinicColorStyle.dark,
                      ),
                      Gap(4.h),
                      CustomText(
                        text: 'Feb 24. 2023',
                        textStyle: MediaQuery.of(context).orientation ==
                                Orientation.landscape
                            ? Theme.of(context).textTheme.labelSmall
                            : Theme.of(context).textTheme.bodySmall,
                        textFontWight: TextFontWight.regular,
                        textColor: OnlineClinicColorStyle.gray,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const InkWell(
                    child: CustomImage(
                      imageSvgPath: 'images/svg/trash.svg',
                    ),
                  )
                ],
              ),
            )
        ],
      ),
    );
  }
}

void checkOrientation() async {
  // final orientation = await NativeDeviceOrientationCommunicator().orientation(useSensor: true);
  // logger.w(orientation);

  await NativeDeviceOrientationCommunicator().resume();

  NativeDeviceOrientationCommunicator()
      .onOrientationChanged(useSensor: true)
      .listen((event) {
    if (event == NativeDeviceOrientation.portraitUp ||
        event == NativeDeviceOrientation.portraitDown) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } else if (event == NativeDeviceOrientation.landscapeLeft) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
      ]);
    } else if (event == NativeDeviceOrientation.landscapeRight) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
      ]);
    }

    // setState(() {
    //
    // });

    // BlocProvider.of<CameraBloc>(context).add(CameraInitializeEvent(
    //   deviceOrientation: deviceOrientation
    // ));
  });
}
