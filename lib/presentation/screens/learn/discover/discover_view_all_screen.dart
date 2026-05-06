import 'package:somi/content_sheet/content_sheet.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_shimmer_card.dart';
import 'package:somi/core/widgets/empty_list_widget.dart';
import 'package:somi/core/widgets/network_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'discover_cubit.dart';
import 'discover_state.dart';

class DiscoverViewAllScreen extends StatefulWidget {
  final DiscoverState state;
  final String navigationTitle;
  const DiscoverViewAllScreen(
      {super.key, required this.state, this.navigationTitle = ''});

  @override
  State<DiscoverViewAllScreen> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverViewAllScreen>
    with AutomaticKeepAliveClientMixin {
  final cubit = locator<DiscoverCubit>();
  OrgSettings? orgSettings;
  @override
  bool get wantKeepAlive => true;

  void update(Function(DiscoverScreenState it) block) =>
      setState(() => block(this));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.navigationTitle)),
      body: _buildBody(context, widget.state),
    );
  }

  Widget _buildBody(BuildContext context, DiscoverState state) {
    if (state.continueLearningItems.isNotEmpty) {
      return _list(state);
    } else if (state.loading) {
      return _loading();
    } else if (state.error != null) {
      return NetworkErrorWidget(onRetry: () => cubit.fetchData());
    } else {
      return _empty();
    }
  }

  Widget _list(DiscoverState state) {
    if (widget.navigationTitle ==
        AppLocalizations.of(context)!.recentlyViewed) {
      return buildSection(context, AppLocalizations.of(context)!.recentlyViewed,
          state.continueLearningItems,
          dgCardFormat: DGCardFormat.large);
    } else if (widget.navigationTitle ==
        AppLocalizations.of(context)!.continueLearning) {
      return buildSection(
          context,
          AppLocalizations.of(context)!.continueLearning,
          state.continueLearningItems,
          dgCardFormat: DGCardFormat.large);
    } else if (widget.navigationTitle == 'Agile Software Development') {
      return buildSection(context, AppLocalizations.of(context)!.recentlyViewed,
          state.continueLearningItems,
          dgCardFormat: DGCardFormat.large);
    } else {
      return _empty();
    }
  }

  Widget buildSection(
    BuildContext context,
    String title,
    List<Input> items, {
    DGCardFormat? dgCardFormat,
    String? subTitle,
  }) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: items.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            enableDrag: false,
            builder: (BuildContext context) {
              return DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 1.0,
                minChildSize: 0.5,
                expand: false,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return ContentSheet(
                      input: items[index], scrollController: scrollController);
                },
              );
            },
          );
        },
        child: InputCard(input: items[index]),
      ),
    );
  }

  Widget _loading() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) =>
          const InputShimmerCard(),
    );
  }

  Widget _empty() {
    return EmptyListWidget(
      imageAssetPath: 'images/illustrations/completed.png',
      message: AppLocalizations.of(context)!.emptyTodayMessage,
      title: AppLocalizations.of(context)!.emptyTodayTitle,
      onRefresh: () async => cubit.fetchData(refresh: true),
    );
  }
}
