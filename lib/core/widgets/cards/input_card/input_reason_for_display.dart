import 'package:somi/core/models/input.dart';
import 'package:somi/core/widgets/degreed_avatar.dart';
import 'package:somi/core/widgets/highlighted_text.dart';
import 'package:flutter/material.dart';

class InputReasonForDisplay extends StatelessWidget {
  final Input input;

  const InputReasonForDisplay(this.input, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        if (_shouldDisplayAvatar())
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DegreedAvatar.user(user: input.statistics!.topUser!),
          ),
        Expanded(child: _reasonForDisplayText(context)),
      ],
    );
  }

  bool _shouldDisplayAvatar() =>
      input.statistics?.topUser !=
      null; // && input.source?.contains('Trending') == true;

  Widget _reasonForDisplayText(BuildContext context) {
    if (input.reasonForDisplay == null) return Container();
    final detail = input.suggestionDetail;
    String? highlight;

    if (detail != null) {
      if (detail.source?.contains('pathway') == true &&
          detail.pathwayName != null) {
        highlight = detail.pathwayName!;
      } else if (_shouldDisplayAvatar()) {
        highlight = input.statistics!.topUser!.name;
      } else {
        highlight = detail.name;
      }
    }

    return HighlightedText(
      text: input.reasonForDisplay!,
      textToHighlight: highlight,
      textStyle: Theme.of(context).textTheme.bodySmall,
      highlightStyle: Theme.of(context).textTheme.labelMedium!,
    );
  }
}
