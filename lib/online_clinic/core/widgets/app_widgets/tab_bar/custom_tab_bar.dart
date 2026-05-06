import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';

class CustomTabbar extends StatelessWidget {
  const CustomTabbar(
      {super.key,
      required this.height,
      required this.onTap,
      required this.tabController,
      required this.tabs,
      required this.padding});
  final double height;
  final Function(int page) onTap;
  final TabController tabController;
  final List<Tab> tabs;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: padding,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: OnlineClinicColorStyle.lightColor3,
          ),
          child: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: OnlineClinicColorStyle.white,
            ),
            indicatorColor: Colors.transparent,
            labelColor: OnlineClinicColorStyle.dark,
            dividerColor: Colors.transparent,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
            onTap: (value) {
              onTap(value);
            },
            tabs: tabs,
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            labelPadding: EdgeInsets.zero,

          ),
        ),
      ),
    );
  }
}
