import 'package:somi/core/models/input.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/dg_network_image.dart';
import 'package:somi/core/widgets/shimmer_elements.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DashboardViewAllTileCard extends StatefulWidget {
  final Input input;
  final VoidCallback onTap;
  final Widget? trailing;

  const DashboardViewAllTileCard({
    super.key,
    required this.input,
    required this.onTap,
    this.trailing,
  });

  @override
  State<DashboardViewAllTileCard> createState() =>
      _DashboardViewAllTileCardState();
}

class _DashboardViewAllTileCardState extends State<DashboardViewAllTileCard> {
  @override
  Widget build(BuildContext context) {
    String? title = widget.input.title ?? widget.input.reference?.title;
    String? providerName = widget.input.providerName ??
        widget.input.reference?.providerName ??
        'Provider';
    String? inputType =
        widget.input.inputType ?? widget.input.reference?.resourceType ?? '';
    String? duration = widget.input.durationDisplay ?? '0';

    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: context.colorScheme.surfaceTint,
        ),
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: DGNetworkImage(
                    imageUrl: widget.input.imageUrl,
                    width: 56,
                    height: 56,
                    fit: BoxFit.fill,
                    errorWidget: (_, __, ___) => const _NoItemsImage(),
                    placeholder: (_, __) => const _NoItemsImage(),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${'$inputType \u2022 $duration '} \u2022 '
                        '$providerName',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(fontWeight: FontWeight.w400),
                      ),
                      if (title?.isBlank == false)
                        Text(
                          title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoItemsImage extends StatelessWidget {
  const _NoItemsImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFDCE2F9),
      ),
      child: SvgPicture.asset(
        'images/placeholders/content/icon_patterns/plan_icon.svg',
        fit: BoxFit.cover,
        height: 64,
        width: 64,
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
                    ShimmerBlock(width: 100, height: 14),
                    const SizedBox(height: 4),
                    ShimmerBlock(width: 140, height: 16),
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
