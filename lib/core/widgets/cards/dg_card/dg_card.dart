import 'package:somi/core/widgets/dg_badge.dart';
import 'package:somi/core/widgets/margin.dart';
import 'package:somi/core/widgets/menu_sheet.dart';
import 'package:flutter/material.dart';

/// An enumeration defining the visual format properties of DGCard instances
enum DGCardFormat {
  /// Large format card, variable width and height, designed for single-column vertical lists
  large(
    titleLines: 2,
    summaryLines: 4,
    sizeConstraints: BoxConstraints(minWidth: 390, maxWidth: 390),
  ),

  /// Small format card, fixed width and height, designed for single-row horizontal lists
  small(
    margin: EdgeInsets.only(right: 16),
    sizeConstraints: BoxConstraints(
      minWidth: 160,
      maxWidth: 160,
      minHeight: 280,
      maxHeight: 280,
    ),
  ),

  /// Grid-format card, fixed aspect ratio, designed for multi-column vertical lists
  grid;

  /// Maximum number of lines that the title can use. The actual number of lines may be lower depending
  /// on title length and vertical constraints.
  final int titleLines;

  /// Maximum number of lines that the summary can use. The actual number of lines may be lower depending
  /// on summary length and vertical constraints.
  final int summaryLines;

  /// Outside margin of the card, used for card spacing in horizontal and vertical lists
  final EdgeInsets margin;

  /// Size constraints of the card, excluding any [margin]. Vertical lists should use a large maximum width
  /// and no vertical constraint, while horizontal lists should use a fixed width and height. Grid lists should not
  /// have any constraints as the card size will be determined by the grid column count and a fixed aspect ratio.
  final BoxConstraints sizeConstraints;

  const DGCardFormat({
    this.titleLines = 3,
    this.summaryLines = 9,
    this.margin = EdgeInsets.zero,
    this.sizeConstraints = const BoxConstraints(),
  });

  bool get isLarge => this == large;

  bool get isSmall => this == small;

  bool get isGrid => this == grid;
}

/// A menu option to be displayed when the user taps the menu overflow button on DGCards
class DGCardMenuItem {
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  DGCardMenuItem(this.label, this.onTap, {this.isDestructive = false});
}

/// An [InheritedWidget] that applies configuration and style settings to descendant DGCards
class DGCardConfig extends InheritedWidget {
  const DGCardConfig({
    super.key,
    this.format = DGCardFormat.large,
    this.margin,
    this.sizeConstraints,
    required super.child,
  });

  final DGCardFormat format;

  final EdgeInsets? margin;

  final BoxConstraints? sizeConstraints;

  static const DGCardConfig defaultConfig =
      DGCardConfig(child: SizedBox.shrink());

  static DGCardConfig of(BuildContext context) {
    final DGCardConfig? result =
        context.dependOnInheritedWidgetOfExactType<DGCardConfig>();
    return result ?? defaultConfig;
  }

  @override
  bool updateShouldNotify(covariant DGCardConfig oldWidget) {
    return oldWidget.format != format;
  }
}

class DGCard extends StatelessWidget {
  /// The display format for this card. Default inherits from nearest [DGCardConfig].
  final DGCardFormat? format;

  /// The widget displayed at the very top of the card, typically a 'reason for display'
  /// with accompanying user avatar. Only displayed for the [DGCardFormat.large] format.
  final Widget? header;

  /// Image thumbnail that will be displayed in a 16:9 aspect ratio using the full width of the card,
  /// placed at the top of the card but below the header (if any).
  final Widget? thumbnail;

  /// A custom body, placed between the thumbnail and the textual area with no additional spacing or margin
  final Widget? body;

  /// A text badge, recommended to use [DGBadge]. Located at the top of the textual area. Only displayed for the large format.
  final Widget? badge;

  /// Textual metadata, located near the top of the textual area just below the [badge], if any.
  /// Recommended to use [DGCardMetadata].
  final Widget? metadata;

  /// Title text, located in the textual area. Implicitly styled with [TextTheme.titleSmall].
  final Widget? title;

  /// Summary text, located in the textual area below the title. Implicitly styled with [TextTheme.bodySmall].
  final Widget? summary;

  /// A custom footer the be displayed near the bottom of the card, below the textual area and above the button bar.
  final Widget? footer;

  /// A list of widgets to be displayed in a row inside the button bar at the bottom of the card.
  final List<Widget>? buttons;

  /// A list of menu options to be displayed when the user taps the overflow menu button. If this list is null
  /// or empty, the menu button will not be shown.
  final List<DGCardMenuItem>? menuItems;

  /// A custom margin around this card
  final EdgeInsets? margin;

  /// A builder than can be used to intercept and wrap the card contents (child)
  final Widget Function(BuildContext context, Widget child)? contentBuilder;

  /// Whether to enforce padding around textual content (metadata, title, summary, etc)
  final bool enforceTextPadding;

  /// Overrides the padding around the textual content area (metadata, title, summary, etc). Honors [enforceTextPadding].
  final EdgeInsets? overrideTextPadding;

  /// The header is normally only shown in the large format. Setting this to true will cause the header (if any) to always be shown.
  final bool alwaysShowHeader;

  /// The footer is normally only shown in the large format. Setting this to true will cause the footer (if any) to always be shown.
  final bool alwaysShowFooter;

  /// The badge is normally only shown in the large format. Setting this to true will cause the badge (if any) to always be shown.
  final bool alwaysShowBadge;

  /// Custom size constraints. Overrides any constraints specified by the the [format] or the inherited DGCardConfig
  final BoxConstraints? sizeConstraints;

  /// Callback invoked when the user taps on the card
  final VoidCallback? onTap;

  final bool showMenuIcon;

  const DGCard({
    super.key,
    this.format = DGCardFormat.large,
    this.header,
    this.thumbnail,
    this.body,
    this.badge,
    this.metadata,
    this.title,
    this.summary,
    this.buttons,
    this.menuItems,
    this.footer,
    this.margin,
    this.contentBuilder,
    this.enforceTextPadding = false,
    this.overrideTextPadding,
    this.alwaysShowHeader = false,
    this.alwaysShowFooter = false,
    this.alwaysShowBadge = false,
    this.showMenuIcon = true,
    this.sizeConstraints,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    DGCardConfig config = DGCardConfig.of(context);
    return _buildConstraints(
      context,
      config,
      _buildCard(context, config),
    );
  }

  Widget _buildConstraints(
      BuildContext context, DGCardConfig config, Widget child) {
    return Center(
      child: Padding(
        padding: margin ?? config.margin ?? config.format.margin,
        child: ConstrainedBox(
          constraints: sizeConstraints ??
              config.sizeConstraints ??
              config.format.sizeConstraints,
          child: child,
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, DGCardConfig config) {
    if (contentBuilder != null) {
      return Card(
          child: contentBuilder!(context, _buildCardContent(context, config)));
    } else {
      return Card(child: _buildCardContent(context, config));
    }
  }

  Widget _buildCardContent(BuildContext context, DGCardConfig config) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Thumbnail
          if (thumbnail != null)
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                    constraints: const BoxConstraints.expand(height: 144),
                    child: thumbnail!),

                /// Badge
                Positioned(
                  bottom: 5,
                  right: 0,
                  child: (badge != null && (alwaysShowBadge))
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: badge!,
                        )
                      : const SizedBox(),
                ),

                /// Button bar
              ],
            ),

          /// Custom body
          if (body != null) body!,

          /// Textual content
          _buildTextualContent(context, config),

          /// Footer
          if (footer != null && (config.format.isLarge || alwaysShowFooter))
            Padding(
              padding: const EdgeInsets.only(bottom: 8, top: 8),
              child: footer!,
            ),

          /// Reverted removing the widget and added it in false case in order to pass the existing test cases
          /// TODO: To update the position or usage based on design of skills in future.

          if (thumbnail == null) _buildButtonBar(context, config),
        ],
      ),
    );
  }

  Widget _buildTextualContent(BuildContext context, DGCardConfig config) {
    // Return nothing if there is no content in the textual area
    if (badge == null && metadata == null && title == null && summary == null) {
      return const SizedBox.shrink();
    }
    final format = config.format;
    EdgeInsets padding;
    switch (format) {
      case DGCardFormat.large:
        padding =
            const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8);
        break;
      case DGCardFormat.small:
        padding = const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 8);
        break;
      case DGCardFormat.grid:
        padding = const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8);
        break;
    }
    bool addPadding = enforceTextPadding ||
        thumbnail != null ||
        (header != null && format.isLarge);

    // Reduce top padding if there are no elements above this
    if (header == null && thumbnail == null && body == null) {
      padding = padding.copyWith(top: 8);
    }

    return Expanded(
      flex: format.isLarge ? 0 : 1,
      child: Padding(
        padding: addPadding
            ? (overrideTextPadding ?? padding)
            : const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Metadata - Does not display for grid format
            if (metadata != null && !format.isGrid)
              SizedBox(height: 25, child: _buildMetaData(context, metadata!)),

            /// Title - Uses a variable maxLines value for bounded heights to work around a text overflow issue
            if (title != null)
              Flexible(
                  flex: format.isLarge ? 0 : 1,
                  child: title == null
                      ? Container()
                      : SizedBox(
                          height: 44,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.titleSmall!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              child: title!,
                            ),
                          ),
                        )),

            /// Summary - Uses a variable maxLines value for bounded heights to work around a text overflow issue
            if (summary != null)
              Flexible(
                  flex: format.isLarge ? 0 : 1,
                  child: summary == null
                      ? Container()
                      : ConstrainedBox(
                          constraints: const BoxConstraints(minHeight: 38),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: DefaultTextStyle(
                              style: Theme.of(context).textTheme.bodySmall!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              child: summary!,
                            ),
                          ),
                        ))
          ],
        ),
      ),
    );
  }

  Widget _buildMetaData(BuildContext context, Widget metadata) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: metadata,
    );
  }

  Widget _buildButtonBar(BuildContext context, DGCardConfig config) {
    bool hasButtons = buttons != null && buttons!.isNotEmpty;
    bool hasMenuItems = menuItems != null && menuItems!.isNotEmpty;
    if (!hasButtons && !hasMenuItems) return const SizedBox(height: 8);
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          hasButtons
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Wrap(spacing: 8, children: buttons!),
                )
              : const SizedBox.shrink(),
          if (hasMenuItems)
            Positioned(
              right: 0,
              child: Margin(
                margin: const EdgeInsets.only(right: -8),
                child: IconButton(
                  onPressed: () {
                    showMenuSheet(
                      context,
                      menuItems!
                          .map((item) => MenuSheetOption(
                                item.label,
                                item.onTap,
                                isDestructive: item.isDestructive,
                              ))
                          .toList(),
                    );
                  },
                  icon: const Icon(Icons.more_vert, size: 16),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
