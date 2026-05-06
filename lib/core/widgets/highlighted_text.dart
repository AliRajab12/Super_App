import 'package:diff_match_patch/diff_match_patch.dart';
import 'package:flutter/material.dart';

class HighlightedText extends StatelessWidget {
  final String text;
  final String? textToHighlight;
  final String? highlightDifferenceFrom;
  final TextStyle? textStyle;
  final TextStyle highlightStyle;
  final TextAlign? textAlign;
  final InlineSpan Function(String text)? spanBuilder;

  const HighlightedText({
    Key? key,
    required this.text,
    this.textToHighlight,
    this.highlightDifferenceFrom,
    required this.highlightStyle,
    this.textStyle,
    this.textAlign,
    this.spanBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (highlightDifferenceFrom != null) {
      return buildFromDifference(context);
    } else if (textToHighlight != null && textToHighlight!.isNotEmpty) {
      return buildFromText(context);
    } else {
      return Text(text,
          style: textStyle ?? DefaultTextStyle.of(context).style,
          textAlign: textAlign);
    }
  }

  Widget buildFromText(BuildContext context) {
    List<InlineSpan> spans = [];
    int start = 0;
    while (true) {
      final String? highlight = RegExp(RegExp.escape(textToHighlight!))
          .stringMatch(text.substring(start));
      if (highlight == null) {
        spans.add(TextSpan(text: text.substring(start)));
        break;
      }

      final int indexOfHighlight = text.indexOf(highlight, start);

      if (indexOfHighlight == start) {
        if (spanBuilder != null) {
          spans.add(spanBuilder!(highlight));
        } else {
          spans.add(TextSpan(text: highlight, style: highlightStyle));
        }
        start += highlight.length;
      } else {
        spans.add(TextSpan(text: text.substring(start, indexOfHighlight)));
        if (spanBuilder != null) {
          spans.add(spanBuilder!(highlight));
        } else {
          spans.add(TextSpan(text: highlight, style: highlightStyle));
        }
        start = indexOfHighlight + highlight.length;
      }
    }

    return Text.rich(
      TextSpan(children: spans),
      style: textStyle,
      textAlign: textAlign,
    );
  }

  Widget buildFromDifference(BuildContext context) {
    List<InlineSpan> spans =
        DiffMatchPatch().diff(highlightDifferenceFrom!, text).map((diff) {
      if (diff.operation == DIFF_INSERT) {
        if (spanBuilder != null) return spanBuilder!(diff.text);
        return TextSpan(text: diff.text, style: highlightStyle);
      } else {
        return TextSpan(text: diff.text);
      }
    }).toList();

    return Text.rich(
      TextSpan(children: spans),
      style: textStyle,
      textAlign: textAlign,
    );
  }
}
