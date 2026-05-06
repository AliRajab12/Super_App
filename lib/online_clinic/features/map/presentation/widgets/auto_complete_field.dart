import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/location_feature/data/models/search_suggestion.dart';

class AutocompleteField extends StatelessWidget {
  AutocompleteField({
    super.key,
    required this.lat,
    required this.lng,
    required this.onSelected,
    required this.controller,
  });

  final double lat;
  final double lng;
  final Function(SearchSuggestion) onSelected;
  final TextEditingController controller;
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 5.h),
      borderRadius: BorderRadius.all(Radius.circular(50.r)),
      color: OnlineClinicColorStyle.white,
      elevationType: ElevationType.noElevation,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'images/svg/search-normal.svg',
              ),
            ),
          ),
          Expanded(
            child: RawAutocomplete<SearchSuggestion>(
              textEditingController: controller,
              focusNode: focusNode,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  style: Theme.of(context).textTheme.bodyMedium,
                  onFieldSubmitted: (value) => onFieldSubmitted,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                );
              },
              optionsViewBuilder: (context, onSelected, options) {
                return CustomContainer(
                  height: 333.h,
                  margin: EdgeInsets.only(top: 8.h, right: 48.w),
                  padding: EdgeInsets.all(8.r),
                  borderRadius: BorderRadius.circular(16.r),
                  color: OnlineClinicColorStyle.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: options
                        .map((e) => GestureDetector(
                              onTap: () => onSelected(e),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CustomImage(
                                        imageWidth: 20.w,
                                        imageHeight: 20.h,
                                        imageSvgPath: 'images/svg/location.svg',
                                      ),
                                      Gap(8.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              multiLine: true,
                                              text: e.description,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textFontWight:
                                                  TextFontWight.medium,
                                            ),
                                            Gap(4.h),
                                            CustomText(
                                              multiLine: true,
                                              text: e.secondaryText,
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textFontWight:
                                                  TextFontWight.medium,
                                              textColor: OnlineClinicColorStyle
                                                  .lightGray5,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  Gap(10.h),
                                  const Divider(
                                    color: OnlineClinicColorStyle.lightColor2,
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text.trim().isEmpty) {
                  return const Iterable<SearchSuggestion>.empty();
                }

                await Future.delayed(const Duration(milliseconds: 1500));
                final options = await getSuggestions(textEditingValue.text);
                return options;
              },
              onSelected: (option) {
                controller.text = option.description;
                onSelected(option);
              },
            ),
          ),
          Gap(8.w),
        ],
      ),
    );
  }

  Future<List<SearchSuggestion>> getSuggestions(String text) async {
    final Dio dio = Dio();
    final Map<String, dynamic> qParams = {
      'input': text,
      'location': "$lat+'%2C-'+$lng",
      'types': 'establishment',
      'key': 'AIzaSyAPHCD6R3NzPBhaO3yFn5N-63N8puzbupQ',
    };
    final response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: qParams);
    List<SearchSuggestion> suggestions = [];
    suggestions = response.data['predictions']
        ?.map<SearchSuggestion>((p) => SearchSuggestion(
            description: p['description'],
            secondaryText: p['structured_formatting']?['secondary_text'] ?? ''))
        .toList();
    return suggestions;
  }
}
