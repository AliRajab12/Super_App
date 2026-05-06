
import 'package:auto_route/auto_route.dart';
import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/new_custom_calendar/new_custom_calendar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/widgets/doctor_profile_header.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/widgets/doctor_profile_tabbar.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/widgets/user_comment.dart';
@RoutePage()
class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key});
  static const route = '/doctorProfilePage';

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBody(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            // const CustomAppBar(
            //
            // ),
            const DoctorProfileHeader(),
            DoctorProfileTabBar(
                height: 80.h,
                onTap: (page) {
                  _pageController.jumpToPage(page);
                },
                tabController: _tabController),
            Gap(16.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(16.r),
              ),
              clipBehavior: Clip.none,
              child: ExpandablePageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.topCenter,
                    child: CustomContainer(
                      padding: EdgeInsets.all(12.r),
                      color: OnlineClinicColorStyle.white,
                      margin:
                          EdgeInsets.only(bottom: 16.h, right: 16, left: 16),
                      borderRadius: BorderRadius.circular(16.r),
                      width: 1.sw,
                      // height: 160.h,
                      //  elevationType: ElevationType.mediumElevation,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: 'About',
                            textStyle: Theme.of(context).textTheme.titleSmall,
                            textFontWight: TextFontWight.bold,
                          ),
                          Gap(8.h),
                          CustomText(
                            multiLine: true,
                            text:
                                'Dr. aaCharlotte th o of experience, Dr. [Your Name] has a deep understanding of diagnosing and treating a wide range of cardiovascular conditions. ',
                            textStyle: Theme.of(context).textTheme.bodySmall,
                            textFontWight: TextFontWight.regular,
                          ),
                          Gap(8.h)
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 188.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return UserComment(
                            name: 'Joseph Kim $index',
                            comment:
                                'I recently started seeing Dr. Charlotte Lewis after experiencing chest pain, a family history of heart disease. From the very beginning, I was impressed by the professionalism and care of the entire staff.',
                            date: 'Oct 10 2023',
                            rate: index.toDouble());
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: SizedBox(
                width: 1.sw,
                child: NewCustomCalendar(
                  selectedDate: ({
                    required startDate,
                    required endDate,
                  }) {
                    debugPrint(startDate.toString());
                    debugPrint(endDate.toString());
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
