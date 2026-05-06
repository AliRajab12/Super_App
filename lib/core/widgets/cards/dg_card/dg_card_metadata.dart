import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class DGCardMetadata extends StatelessWidget {
  final List<String?>? metadata;
  final TextStyle? style;

  const DGCardMetadata(
    this.metadata, {
    super.key,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    List<String>? data = metadata?.whereNotNull().toList();
    if (data == null || data.isEmpty) return const SizedBox.shrink();
    return Text(
      data.join(' • '),
      style: Theme.of(context).textTheme.bodySmall!.merge(style),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}
