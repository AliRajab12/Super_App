import 'package:somi/core/theme/colors.dart';
import 'package:flutter/material.dart';

class DegreedTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> labels;
  final Color backgroundColor;
  final EdgeInsets? padding;
  final TabController? controller;

  const DegreedTabBar({
    Key? key,
    required this.labels,
    this.backgroundColor = Colors.white,
    this.padding,
    this.controller,
  }) : super(key: key);

  static const barBackgroundColor = SomiColors.ebony8;

  Color unselectedLabelColor() {
    // Compute background luminance including bar background overlay
    double backgroundLuminance =
        Color.alphaBlend(barBackgroundColor, backgroundColor)
            .computeLuminance();

    // Use dark text against a light background and white text against a dark background
    Color color = backgroundLuminance < 0.5 ? Colors.white : AppColors.gray;

    // Compute color opacity. Colors closer mid luminance (0.5) require more opacity for improved contrast, while
    // colors near luminance extremes (0.0 and 1.0) require less opacity
    const minOpacity = 0.8;
    final additionalOpacity =
        (1.0 - minOpacity) * (0.5 - (backgroundLuminance - 0.5).abs()) / 0.5;
    return color.withOpacity(minOpacity + additionalOpacity);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding:
            padding ?? const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: barBackgroundColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: TabBar(
              controller: controller,
              padding: const EdgeInsets.all(4),
              labelPadding: const EdgeInsets.symmetric(horizontal: 24),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 0),
              labelStyle: Theme.of(context).textTheme.labelMedium,
              isScrollable: true,
              unselectedLabelColor: unselectedLabelColor(),
              tabs: labels.map((e) => Tab(text: e, height: 28)).toList(),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
