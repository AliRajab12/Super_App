import 'package:somi/core/widgets/markdown/degreed_markdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class CollapsibleHeader extends StatefulWidget {
  final String title;
  final String description;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;

  const CollapsibleHeader({
    super.key,
    required this.description,
    required this.title,
    this.titleStyle,
    this.descriptionStyle,
  });

  @override
  State<CollapsibleHeader> createState() => _CollapsibleHeaderState();
}

class _CollapsibleHeaderState extends State<CollapsibleHeader> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(left: 0),
        title: Text(
          widget.title,
          maxLines: 2,
          style: widget.titleStyle ?? Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: !isExpanded
            ? LimitedBox(
                maxHeight: 60,
                child: DegreedMarkdown(
                  data: widget.description,
                  styleSheet: MarkdownStyleSheet(
                    a: widget.descriptionStyle,
                  ),
                ),
              )
            : const SizedBox(),
        trailing: Icon(
          isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
          size: 24,
        ),
        childrenPadding: const EdgeInsets.only(left: 0, top: 0),
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: DegreedMarkdown(
              data: widget.description,
              styleSheet: MarkdownStyleSheet(
                a: widget.descriptionStyle,
              ),
            ),
          ),
        ],
        onExpansionChanged: (bool expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
      ),
    );
  }
}
