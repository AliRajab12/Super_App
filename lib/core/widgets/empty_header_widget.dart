import 'package:somi/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class EmptyHeaderWidget extends StatelessWidget {
  final String? headerTitle;
  final String? headerMessage;
  const EmptyHeaderWidget({super.key, this.headerTitle, this.headerMessage});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 36),
        Text(
          headerTitle!,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        if (headerMessage!.isBlank == false)
          Text(headerMessage!, textAlign: TextAlign.left),
      ],
    );
  }
}
