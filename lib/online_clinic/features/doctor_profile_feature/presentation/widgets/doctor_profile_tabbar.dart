import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';

class DoctorProfileTabBar extends StatelessWidget {
  const DoctorProfileTabBar(
      {super.key,
        required this.height,
        required this.onTap,
        required this.tabController});

  final double height;
  final Function(int page) onTap;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: EdgeInsets.only(left: 69.w, right: 69.w, top: 40.h),
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: OnlineClinicColorStyle.lightColor3,
          ),
          child: TabBar(
            //unselectedLabelColor: OnlineClinicColorStyle.dark,
            // /  overlayColor: MaterialStatePropertyAll(Colors.amber),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.white,
            ),
            indicatorColor: Colors.transparent,
            labelColor: OnlineClinicColorStyle.dark,
            dividerColor: Colors.transparent,
            labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
            onTap: (value) {
              onTap(value);
            },
            tabs: const [
              Tab(
                text: 'About',
              ),
              // VerticalDivider(),
              Tab(
                text: 'Reviews',
              )
            ],
            controller: tabController,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
        ),
      ),
    );
  }
}
