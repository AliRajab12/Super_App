import 'package:somi/core/models/input.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/cards/input_card/input_metadata.dart';
import 'package:somi/core/widgets/cards/input_card/input_metadata_pathway_item.dart';
import 'package:somi/core/widgets/cards/input_card/input_thumbnail.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:flutter/material.dart';

class InputListTileCardPathway extends StatelessWidget {
  final Input input;
  final VoidCallback onTap;
  final Widget? trailing;

  const InputListTileCardPathway({
    super.key,
    required this.input,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    String? title = input.title ?? input.reference?.title;
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colorScheme.surfaceTint,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              InputThumbnail(
                input,
                thumbnailSize: ThumbnailSize(
                  sizes: {
                    'book': const Size(-1, 48),
                    'episode': const Size(-1, 48),
                  },
                  fallback: const Size(56, 56),
                ),
                wrapper: (child) => ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(width: 56, height: 56),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: child,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (InputMetadata.hasData(input))
                        InputMetadataPathwayItem(
                          input,
                          style: context.textTheme.labelMedium,
                        ),
                      if (title?.isBlank == false)
                        Text(
                          title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyLarge,
                        ),
                    ],
                  ),
                ),
              ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class InputListTileShimmerCard extends StatelessWidget {
  const InputListTileShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: DGShimmer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              ShimmerBlock(width: 56, height: 56),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBlock(width: 120, height: 14),
                    const SizedBox(height: 4),
                    ShimmerBlock(width: 180, height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
