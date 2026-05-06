import 'package:somi/core/models/search_result.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/utils/content_launcher.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_shimmer_card.dart';
import 'package:flutter/material.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({
    Key? key,
    required this.searchResult,
  }) : super(key: key);

  final SearchResult searchResult;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 382,
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        decoration: BoxDecoration(
          color: const Color(0xfffcf8fd),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          onTap: () {
            locator<ContentLauncher>().launchResource(
              searchResult.reference?.inputType ?? '',
              searchResult.reference?.inputId ?? 0,
            );
          },
          leading: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                color: const Color(0xffdadce0),
                borderRadius: BorderRadius.circular(4),
                image: searchResult.reference?.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(searchResult.reference!.imageUrl!),
                        fit: BoxFit.cover)
                    : const DecorationImage(
                        image: AssetImage(
                            'images/illustrations/glasses-balloons.png'),
                        fit: BoxFit.cover)),
          ),
          title: Row(
            children: [
              Text(searchResult.reference?.inputType ?? 'Type',
                  style: Theme.of(context).textTheme.bodySmall),
              Text('・', style: Theme.of(context).textTheme.bodySmall),
              Text(searchResult.reference?.durationUnitType ?? 'Duration',
                  style: Theme.of(context).textTheme.bodySmall),
              Text('・', style: Theme.of(context).textTheme.bodySmall),
              SizedBox(
                  width: 70,
                  child: Text(
                      searchResult.reference?.providerName ?? 'Provider',
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall)),
            ],
          ),
          subtitle: Text(
            searchResult.reference?.title.toString() ?? 'Title',
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ));
  }
}

class ShimmerSearchSection extends StatelessWidget {
  const ShimmerSearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Search Shimmer Item Loader
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: DGCardConfig(
            format: DGCardFormat.large,
            child: SizedBox(
              height: DGCardFormat.small.sizeConstraints.maxHeight,
              child: const InputShimmerCard(),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
