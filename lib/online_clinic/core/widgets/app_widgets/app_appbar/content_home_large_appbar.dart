import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/custom_appbar.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/online_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/user_home_feature/domain/entity/search.dart';
import 'package:somi/online_clinic/features/user_home_feature/presentation/widget/autocompelete_search_category.dart';

class ContentHomeLargeAppBar extends StatelessWidget {
  ContentHomeLargeAppBar(
      {super.key,
      this.title,
      this.subtitle,
      this.hintSearch,
      this.showActionAppbar = true,
      this.showProfileImage = false,
      this.showOnlineButton = false,
        this.showSearch,
        this.date,
      this.changeStatus});

  final String? title;
  final String? subtitle;
  final String? hintSearch;
  final bool showActionAppbar;
  final bool showProfileImage;
  final bool showOnlineButton;
  final bool? showSearch;
  final String? date;
  final Function(bool isOnline)? changeStatus;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomAppBar(
            hasPadding: false,
            showActionProfile: showActionAppbar,
            iconBackColor: OnlineClinicColorStyle.white,
          ),
          if(date != null)
          Gap(32.h),

          if(date != null)
            Row(
              children: [
                CustomText(
                    text: date!,
                    textStyle: Theme.of(context).textTheme.labelMedium,
                  textColor: OnlineClinicColorStyle.white,
                ),
              ],
            ),
          if(date != null)
          Gap(8.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title ?? 'Online clinic',
                      textStyle: Theme.of(context).textTheme.titleLarge,
                      textFontWight: TextFontWight.bold,
                      textColor:
                          Theme.of(context).brightness == Brightness.light
                              ? OnlineClinicColorStyle.white
                              : OnlineClinicColorStyle.white,
                    ),
                    Gap(4.h),
                    CustomText(
                      text: subtitle ?? 'Healthcare and prescription',
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                      textFontWight: TextFontWight.regular,
                      textColor:
                          Theme.of(context).brightness == Brightness.light
                              ? OnlineClinicColorStyle.white
                              : OnlineClinicColorStyle.white,
                    ),
                  ],
                ),
              ),
              if (!showActionAppbar)
                CustomImage(
                  imagePngOrJpgPath: 'images/onine_clinic_png/profile.png',
                  imageWidth: 40.w,
                  imageHeight: 40.h,
                ),
            ],
          ),
          // if(showSearch?? true)
          Gap(32.h),
          if(showSearch?? true)
          AutocompleteSearchWithCategory(
            controller: searchController,
            entries: [
              Search(
                title: 'Diseases',
                suggestions: const [
                  'title1',
                  'title2',
                  'title3',
                  'title4',
                  'title5',
                  'title6',
                  'title7',
                  'title8',
                  'title9',
                  'title10',
                ],
                searchType: SearchTypeEnum.other,
                isExpanded: false,
              ),
              Search(
                title: 'Specialist',
                suggestions: const [
                  'suggest1',
                  'suggest2',
                  'suggest3',
                  'suggest4',
                  'suggest5',
                  'suggest6',
                  'suggest7',
                  'suggest8',
                  'suggest9',
                  'suggest10',
                ],
                searchType: SearchTypeEnum.other,
                isExpanded: false,
              ),
              Search(
                title: 'Doctors',
                suggestions: const [
                  'suggest1',
                  'suggest2',
                  'suggest3',
                  'suggest4',
                  'suggest5',
                  'suggest6',
                  'suggest7',
                  'suggest8',
                  'suggest9',
                  'suggest10',
                  'suggest11',
                ],
                searchType: SearchTypeEnum.doctor,
                isExpanded: false,
              ),
            ],
            onSelected: (p0) {
              searchController.text = p0;
            },
            // hintText: hintSearch ?? 'Search a doctor or medical condition',
          ),
          if (showOnlineButton)
            OnlineButton(
              onTapOnlineButton: (bool isOnline) {
                if (changeStatus != null) {
                  changeStatus!(isOnline);
                }
              },
            ),
          Gap(24.h),
        ],
      ),
    );
  }
}
