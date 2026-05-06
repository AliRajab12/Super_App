import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';


class LargeAppBar extends StatelessWidget {
  LargeAppBar({super.key, required this.content , this.backColor});

  final Widget content;
  final Color? backColor;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // AppLocalizations appLocalizations = AppLocalizations.of(context);
    return Stack(
      children: [
            CustomContainer(
            width: 1.sw,
            decorationImage: const DecorationImage(
              image: AssetImage('images/line_back.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.elliptical(32.r, 20.r),
                bottomRight: Radius.elliptical(32.r, 20.r)),
            color: Theme.of(context).brightness == Brightness.light
                ? OnlineClinicColorStyle.dark2
                : OnlineClinicColorStyle.dark,
            child: content),
        Container(
          width: 1.sw,

          color: backColor,

        )
          ],
    );
  }
}
