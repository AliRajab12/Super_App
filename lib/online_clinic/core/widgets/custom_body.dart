import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rename/platform_file_editors/abs_platform_file_editor.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/large_app_bar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_overlay/create_overlay.dart';

class CustomBody extends StatelessWidget {
  const CustomBody(
      {required this.child,
      this.showAppAppbar,
      super.key,
      this.contentLargeAppBar,
        this.bottomNavigationBar,
        this.backColor,
      this.onTapBack});

  final Widget child;
  final bool? showAppAppbar;

  final Widget? contentLargeAppBar;
  final Widget? bottomNavigationBar;
  final GestureTapCallback? onTapBack;
  final Color? backColor;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor:  Theme.of(context).brightness == Brightness.light
            ? OnlineClinicColorStyle.backgroundColor
            : OnlineClinicColorStyle.backgroundColorDark,
        bottomNavigationBar: bottomNavigationBar,
        body: PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            CreateOverLay.removeOverlay();
            Navigator.pop(context);
          },
          child: Container(
            width: 1.sw,
            height: 1.sh,

            child: Column(
              children: [
                if (showAppAppbar == true)
                  CustomAppBar(
                    onTapBack: onTapBack,
                  ),
                if (contentLargeAppBar != null)
                  LargeAppBar(
                    content: contentLargeAppBar!,
                    backColor: backColor,
                  ),
                Expanded(child: child),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
