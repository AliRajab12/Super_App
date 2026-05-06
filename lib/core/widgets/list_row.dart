import 'package:somi/core/models/user.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/degreed_avatar.dart';
import 'package:flutter/material.dart';

class ListRow extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final GestureTapCallback? onTap;
  final String? subLabel;
  final String? secondaryLabel;
  final IconData? icon;
  final User? user;
  final Widget? leading;
  final Widget? trailing;
  final bool useNavIcon;
  final double userAvatarSize;
  final bool enabled;

  const ListRow({
    super.key,
    required this.label,
    this.labelStyle,
    this.onTap,
    this.subLabel,
    this.secondaryLabel,
    this.leading,
    this.trailing,
    this.useNavIcon = true,
    this.icon,
    this.user,
    this.userAvatarSize = 36,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // A vertical visual density of -2 will result in a height of 48px in most cases
      visualDensity: const VisualDensity(vertical: -2),
      textColor: enabled ? null : SomiColors.ebony25,
      contentPadding: icon != null
          ? const EdgeInsets.only(left: 10, right: 10)
          : const EdgeInsets.only(left: 16, right: 10),
      iconColor: AppColors.grayLight,
      title: Text(label, style: labelStyle),
      onTap: enabled ? onTap : null,
      subtitle: subLabel != null ? Text(subLabel!) : null,
      minLeadingWidth: 0,
      horizontalTitleGap: 0,
      leading: _buildLeading(),
      trailing: _buildTrailing(),
    );
  }

  Widget _buildLeading() {
    return SizedBox(
      height: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) leading!,
          if (icon != null) Icon(icon, size: 16),
          if (icon != null) const SizedBox(width: 8),
          if (user != null)
            DegreedAvatar.user(user: user!, size: userAvatarSize),
          if (user != null) const SizedBox(width: 18),
        ],
      ),
    );
  }

  Widget _buildTrailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (trailing != null) trailing!,
        if (secondaryLabel != null) Text(secondaryLabel!),
        if (secondaryLabel != null && useNavIcon) const SizedBox(width: 12),
        if (useNavIcon)
          const Padding(
            padding: EdgeInsets.only(left: 4, top: 2),
            child: Icon(Icons.navigate_next, size: 18),
          ),
      ],
    );
  }
}

class ListCard extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const ListCard({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(vertical: children.length > 1 ? 8 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
      ),
    );
  }
}

class ListRowForMenu extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final GestureTapCallback? onTap;
  final String? subLabel;
  final String? secondaryLabel;
  final String? icon;
  final User? user;
  final Widget? leading;
  final Widget? trailing;
  final bool useNavIcon;
  final double userAvatarSize;
  final bool enabled;

  const ListRowForMenu({
    super.key,
    required this.label,
    this.labelStyle,
    this.onTap,
    this.subLabel,
    this.secondaryLabel,
    this.leading,
    this.trailing,
    this.useNavIcon = true,
    this.icon,
    this.user,
    this.userAvatarSize = 36,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraint) {
            return Column(
              children: <Widget>[
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.topLeft,
                  child: Image(
                    image: AssetImage(
                      icon!,
                    ),
                    fit: BoxFit.cover,
                    height: 16,
                    width: 16,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: constraint.maxWidth,
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Color(0xff0057cc),
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: constraint.maxWidth,
                  child: Text(
                    subLabel!,
                    style: const TextStyle(
                      color: Color(0xff151b2c),
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class ListCardForMenu extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const ListCardForMenu({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: const Color(0xffd9e2ff),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(vertical: children.length > 1 ? 8 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ),
    );
  }
}

class ListCardForAvaterMenu extends StatelessWidget {
  final List<Widget> children;
  final EdgeInsets? padding;

  const ListCardForAvaterMenu({
    super.key,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      color: const Color(0xffeef0ff),
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(vertical: children.length > 1 ? 8 : 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ),
    );
  }
}
