import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/size_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackButtonPressed;
  final VoidCallback onHomeButtonPressed;
  final Color backgroundColor;
  final bool? homeButton;
  final Widget? leading;
  final Widget? action;
  const CustomAppBar({
    Key? key,
    required this.title,
    this.action,
    required this.onBackButtonPressed,
    required this.onHomeButtonPressed,
    this.backgroundColor = SomiColors.background,
    this.homeButton,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      toolbarHeight: kToolbarHeight + 16,
      titleSpacing: 0,
      centerTitle: true,
      leading: leading ??
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 11, vertical: 16),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade600)),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new_sharp,
                color: Colors.grey.shade600,
                size: 16.v,
              ),
              onPressed: onBackButtonPressed,
            ),
          ),
      title: Text(
        title,
        style: kScreenTitle,
      ),
      actions: [
        action != null
            ? action!
            : homeButton != null && homeButton == false
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 18),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade600)),
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.home,
                        color: Colors.grey.shade600,
                        size: 20.v,
                      ),
                      onPressed: onHomeButtonPressed,
                    ),
                  ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);
}
