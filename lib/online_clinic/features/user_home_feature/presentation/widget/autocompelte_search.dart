import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';

class AutocompleteSearch extends StatefulWidget {
  const AutocompleteSearch({
    super.key,
    required this.onSelected,
    required this.controller,
    required this.enteries,
  });

  final Function(String) onSelected;
  final TextEditingController controller;
  final List<String> enteries;

  @override
  State<AutocompleteSearch> createState() => _AutocompleteSearchState();
}

class _AutocompleteSearchState extends State<AutocompleteSearch> {
  final FocusNode focusNode = FocusNode();

  //static const List<String> _options = <String>[];

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
            child: RawAutocomplete<String>(
              textEditingController: widget.controller,
              focusNode: focusNode,

              //      optionsViewOpenDirection: OptionsViewOpenDirection.up,
              // initialValue: controller.value,
              fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                return TextFormField(
                  controller: textEditingController,
                  focusNode: focusNode,
                  onFieldSubmitted: (value) => onFieldSubmitted,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
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
                    padding: EdgeInsets.all(8.r),
                    borderRadius: BorderRadius.circular(16.r),
                    color: OnlineClinicColorStyle.white,
                    child: Scrollbar(
                      thumbVisibility: true,
                      trackVisibility: true,
                      // thickness: 3,

                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ...options.map(
                              (e) => Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // selected = e;
                                      onSelected(e);
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 4.h),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: RichText(
                                              softWrap: false,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                  style: const TextStyle(overflow: TextOverflow.fade),
                                                  children:
                                                      _getHighlightedTextSpans(widget.controller.text, e, context)),
                                            ),
                                          ),
                                        ],
                                      ),
                                      // child: CustomText(
                                      //     text: suggestion, textStyle: Theme.of(context).textTheme.bodySmall),
                                    ),
                                  ),
                                  Gap(4.h),
                                  const Divider(
                                    color: OnlineClinicColorStyle.lightColor2,
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
                  return const Iterable<String>.empty();
                }
                await Future.delayed(const Duration(milliseconds: 1500));
                return widget.enteries
                    .where((element) => element.toLowerCase().contains(textEditingValue.text.toLowerCase()));
              },
              onSelected: (option) {
                widget.controller.text = option;
                widget.onSelected(option);
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

  List<TextSpan> _getHighlightedTextSpans(String searchQuery, String text, BuildContext context) {
    List<TextSpan> spans = [];
    String lowerCaseText = text.toLowerCase();
    String lowerCaseSearchQuery = searchQuery.toLowerCase();

    int start = 0;
    int index = lowerCaseText.indexOf(lowerCaseSearchQuery);

    if (searchQuery.isEmpty) {
      spans.add(TextSpan(text: text, style: TextStyle(color: Theme.of(context).primaryColor)));
      return spans;
    }

    while (index != -1) {
      // Add the preceding non-matching text
      if (index > start) {
        spans.add(
          TextSpan(
              text: text.substring(start, index),
              style: TextStyle(
                fontSize: 13,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.fade,
              )),
        );
      }

      // Add the matching text with highlighting
      spans.add(
        TextSpan(
            text: text.substring(index, index + searchQuery.length),
            style: const TextStyle(
              color: Colors.orange,
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
        spans.add(TextSpan(
            text: text.substring(start, text.length),
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.fade,
            )));
      }
    }
    return spans;
  }
}
