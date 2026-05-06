import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/user_home_feature/domain/entity/search.dart';

class AutocompleteSearchWithCategory extends StatefulWidget {
  const AutocompleteSearchWithCategory({
    super.key,
    required this.onSelected,
    required this.controller,
    required this.entries,
    this.label,
  });

  final Function(String) onSelected;
  final TextEditingController controller;
  final List<Search> entries;
  final String? label;

  @override
  State<AutocompleteSearchWithCategory> createState() =>
      _AutocompleteSearchWithCategoryState();
}

class _AutocompleteSearchWithCategoryState
    extends State<AutocompleteSearchWithCategory> {
  final FocusNode focusNode = FocusNode();

  //static const List<String> _options = <String>[];
  String selected = '';

  final ScrollController scrollController = ScrollController();

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
          Gap(16.w),
          Expanded(
            child: RawAutocomplete<Search>(
              textEditingController: widget.controller,
              focusNode: focusNode,

              //      optionsViewOpenDirection: OptionsViewOpenDirection.up,
              // initialValue: controller.value,
              fieldViewBuilder: (context, textEditingController, focusNode,
                  onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (value) => onFieldSubmitted,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText:
                        widget.label ?? 'Search a doctor or medical condition',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                    contentPadding: EdgeInsets.only(bottom: 8.h),
                  ),
                );
              },
              //  optionsMaxHeight: 333.h,
              optionsViewBuilder: (context, onSelected, options) {
                return SizedBox(
                  height: 333.h,
                  child: CustomContainer(
                    height: 333.h,
                    margin: EdgeInsets.only(top: 8.h, right: 48.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 8),
                    borderRadius: BorderRadius.circular(16.r),
                    color: OnlineClinicColorStyle.white,
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      // thickness: 3,
                      controller: scrollController,
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...options.map(
                              (e) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: e.title,
                                    textStyle:
                                        Theme.of(context).textTheme.bodyLarge,
                                    textFontWight: TextFontWight.medium,
                                  ),
                                  Gap(16.h),
                                  SizedBox(
                                    height: e.isExpanded ? 200.h : 100.h,
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                        runSpacing: 16,
                                        spacing: 8,
                                        direction: Axis.horizontal,
                                        children: [
                                          ...e.suggestions.map(
                                            (suggestion) => GestureDetector(
                                              onTap: () {
                                                selected = suggestion;
                                                onSelected(e);
                                              },
                                              child: e.searchType ==
                                                      SearchTypeEnum.other
                                                  ? _generalSuggestionCard(
                                                      suggestion, context)
                                                  : _doctorSuggestionCard(
                                                      suggestion, context),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Gap(16.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImage(
                                        imageSvgPath: !e.isExpanded
                                            ? 'images/svg/minus_cirlce.svg'
                                            : 'images/svg/add_circle_gray.svg',
                                        imageWidth: 24.w,
                                        imageHeight: 24.h,
                                        onTap: () {
                                          setState(() {
                                          e.isExpanded = !e.isExpanded;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Gap(MediaQuery.of(context).viewInsets.bottom * 2)
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
              optionsBuilder: (TextEditingValue textEditingValue) async {
                if (textEditingValue.text.trim().isEmpty) {
                  return const Iterable<Search>.empty();
                }

                await Future.delayed(
                  const Duration(
                    milliseconds: 1000,
                  ),
                );
                return widget.entries.where((element) => element.suggestions
                    .every((element) => element
                        .toLowerCase()
                        .contains(textEditingValue.text.toLowerCase())));
              },
              onSelected: (option) {
                widget.controller.text = selected;
                widget.onSelected(selected);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(
                'images/svg/search-normal.svg',
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomContainer _generalSuggestionCard(
          String suggestion, BuildContext context) =>
      CustomContainer(
        border: Border.all(
          color: OnlineClinicColorStyle.lightGray,
        ),
        borderRadius: BorderRadius.circular(50),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 4.h,
          ),
          child: RichText(
            softWrap: false,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              style: const TextStyle(
                overflow: TextOverflow.fade,
              ),
              children: _getHighlightedTextSpans(
                widget.controller.text,
                suggestion,
                context,
              ),
            ),
          ),
          // child: CustomText(
          //     text: suggestion, textStyle: Theme.of(context).textTheme.bodySmall),
        ),
      );

  CustomContainer _doctorSuggestionCard(
    String suggestion,
    BuildContext context,
  ) {
    Image img = Image.asset('images/onine_clinic_png/doctor_amelia.png');
    return CustomContainer(
      border: Border.all(
        color: OnlineClinicColorStyle.lightGray,
      ),
      borderRadius: BorderRadius.circular(50),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 6.h,
          vertical: 4.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: img.image,
                ),
              ),
              width: 35.w,
              height: 35.h,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                        overflow: TextOverflow.fade,
                        color: OnlineClinicColorStyle.gray),
                    children: _getHighlightedTextSpans(
                      widget.controller.text,
                      suggestion,
                      context,
                    ),
                  ),
                ),
                RichText(
                  softWrap: false,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: const TextStyle(
                      overflow: TextOverflow.fade,
                    ),
                    children: _getHighlightedTextSpans(
                      widget.controller.text,
                      'dentist',
                      context,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<TextSpan> _getHighlightedTextSpans(
      String searchQuery, String text, BuildContext context) {
    List<TextSpan> spans = [];
    String lowerCaseText = text.toLowerCase();
    String lowerCaseSearchQuery = searchQuery.toLowerCase();

    int start = 0;
    int index = lowerCaseText.indexOf(lowerCaseSearchQuery);

    if (searchQuery.isEmpty) {
      spans.add(TextSpan(
          text: text, style: TextStyle(color: Theme.of(context).primaryColor)));
      return spans;
    }

    while (index != -1) {
      // Add the preceding non-matching text
      if (index > start) {
        spans.add(
          TextSpan(
              text: text.substring(start, index),
              style: TextStyle(
                fontSize: 12.sp,
                color: OnlineClinicColorStyle.gray,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.fade,
              )),
        );
      }

      // Add the matching text with highlighting
      spans.add(
        TextSpan(
            text: text.substring(index, index + searchQuery.length),
            style: const TextStyle(
              color: OnlineClinicColorStyle.yellowRating,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.fade,
            )),
      );

      start = index + searchQuery.length;
      index = lowerCaseText.indexOf(lowerCaseSearchQuery, start);
    }

    // Add the remaining non-matching text
    if (start < text.length) {
      if (text.substring(start, text.length).trim() != '') {
        spans.add(
          TextSpan(
              text: text.substring(start, text.length),
              style: TextStyle(
                fontSize: 12.sp,
                color: OnlineClinicColorStyle.gray,
                fontWeight: FontWeight.w400,
                overflow: TextOverflow.fade,
              )),
        );
      }
    }
    return spans;
  }
}
