import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/markdown/markdown_blockquote_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:url_launcher/url_launcher.dart';

class DegreedMarkdown extends StatelessWidget {
  const DegreedMarkdown({
    super.key,
    required this.data,
    this.shrinkWrap = true,
    this.shrinkWrapAllowScroll = false,
    this.controller,
    this.styleSheet,
  });

  /// The Markdown string to render
  final String? data;

  /// The [ScrollController] to use for scrolling the rendered Markdown
  final ScrollController? controller;

  /// Whether the height of the scrollable view should be determined by the contents being viewed.
  ///
  /// See also: [ScrollView.shrinkWrap]
  final bool shrinkWrap;

  /// Whether to prevent scrolling when [shrinkWrap] is true
  final bool shrinkWrapAllowScroll;

  final MarkdownStyleSheet? styleSheet;

  /// Background color of inline code and code blocks
  static const _codeBackgroundColor = Color(0xFFF8F8F8);

  @override
  Widget build(BuildContext context) {
    if (data == null) return Container();
    return Markdown(
      data: data!,
      controller: controller,
      physics: (shrinkWrap && !shrinkWrapAllowScroll)
          ? const NeverScrollableScrollPhysics()
          : null,
      shrinkWrap: shrinkWrap,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
          .merge(buildStyleSheet())
          .merge(styleSheet),
      onTapLink: (text, href, title) {
        launchUrl(
          Uri.parse(href ?? ''),
          mode: LaunchMode.externalApplication,
        );
      },
    );
  }

  MarkdownStyleSheet buildStyleSheet() {
    return MarkdownStyleSheet(
      blockquoteDecoration:
          const MarkdownBlockquoteDecoration(AppColors.primary),
      blockquotePadding: const EdgeInsets.only(left: 16, top: 8, bottom: 12),
      pPadding: const EdgeInsets.only(top: 8),
      horizontalRuleDecoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppColors.grayLight,
          ),
        ),
      ),
      codeblockDecoration: BoxDecoration(
        color: _codeBackgroundColor,
        borderRadius: BorderRadius.circular(2.0),
      ),
      code: const TextStyle(backgroundColor: _codeBackgroundColor),
      h1Padding: const EdgeInsets.only(top: 16),
      h2Padding: const EdgeInsets.only(top: 16),
      h3Padding: const EdgeInsets.only(top: 16),
      h4Padding: const EdgeInsets.only(top: 16),
      h5Padding: const EdgeInsets.only(top: 16),
      h6Padding: const EdgeInsets.only(top: 16),
    );
  }
}

class StrippedMarkdown extends MarkdownWidget {
  const StrippedMarkdown({super.key, required super.data});

  List<String> extractText(List<Widget>? list) {
    if (list == null) return [];
    List<String> lines = [];
    for (final Widget item in list) {
      if (item is RichText) {
        lines.add(item.text.toPlainText());
      } else if (item is Column) {
        lines.addAll(extractText(item.children));
      } else if (item is Wrap) {
        lines.addAll(extractText(item.children));
      }
    }
    return lines;
  }

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    final lines = extractText(children);
    return Text(lines.join('\n'));
  }
}
