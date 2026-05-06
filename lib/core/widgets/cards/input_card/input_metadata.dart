import 'package:somi/core/models/input.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card_metadata.dart';
import 'package:flutter/material.dart';

class InputMetadata extends StatelessWidget {
  final Input input;
  final TextStyle? style;

  const InputMetadata(this.input, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    List<String?> data = buildData(input);
    return DGCardMetadata(data, style: style);
  }

  static bool hasData(Input input) {
    return buildData(input).any((it) => it != null && it.isNotEmpty);
  }

  static List<String?> buildData(Input input) {
    return [
      input.reference?.type?.nameWithSpaces,
      input.hostname,
      input.durationDisplay ?? input.reference?.durationDisplay,
      input.reference?.locationName,
    ];
  }
}
