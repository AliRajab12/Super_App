import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_shimmer_card.dart';
import 'package:somi/core/widgets/empty_list_widget.dart';
import 'package:somi/core/widgets/network_error_widget.dart';
import 'package:somi/core/widgets/paginated_list_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/presentation/screens/learn/discover/somi_banner_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'discover_cubit_new.dart';
import 'discover_state_new.dart';

class DiscoverScreenNew extends StatefulWidget {
  const DiscoverScreenNew({Key? key}) : super(key: key);

  @override
  State<DiscoverScreenNew> createState() => DiscoverScreenNewState();
}

class DiscoverScreenNewState extends State<DiscoverScreenNew>
    with AutomaticKeepAliveClientMixin {
  final cubit = locator<DiscoverCubitNew>();
  OrgSettings? orgSettings;
  @override
  bool get wantKeepAlive => true;

  void update(Function(DiscoverScreenNewState it) block) =>
      setState(() => block(this));

  @override
  void initState() {
    cubit.fetchData();
    refreshBrandColors();
    super.initState();
  }

  void refreshBrandColors({bool updateState = true}) {
    if (locator.isRegistered<UserRepo>()) {
      orgSettings = locator<UserRepo>().orgSettings;
    }

    if (updateState) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<DiscoverCubitNew, DiscoverStateNew>(
      bloc: cubit,
      builder: (context, state) {
        return _buildBody(context, state);
      },
    );
  }

  Widget _buildBody(BuildContext context, DiscoverStateNew state) {
    if (state.discoverItems.discoverItems.isNotEmpty) {
      return _list(state);
    } else if (state.loading) {
      return _loading();
    } else if (state.error != null) {
      return NetworkErrorWidget(onRetry: () => cubit.fetchData());
    } else {
      return _empty();
    }
  }

  Widget _list(DiscoverStateNew state) {
    return PaginatedListWrapper(
      canRefresh: !state.loading,
      onRefresh: () => cubit.fetchData(refresh: true),
      hasMorePages: false,
      onNextPageRequested: () {},
      child: ListView(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 32, bottom: 64),
        children: [
          SomiBannerCard(orgAnnouncement: orgSettings?.orgAnnouncement),
          if (state.todayFeedItems.isNotEmpty) ...[
            buildSection(state, context,
                AppLocalizations.of(context)!.todayfeed, state.todayFeedItems)
          ],
          if (state.discoverItems.discoverItems.isNotEmpty) ...[
            buildSection(
                state,
                context,
                AppLocalizations.of(context)!.continueLearning,
                state.discoverItems.discoverItems)
          ],
          if (state.recentlyViewedItems.discoverItems.isNotEmpty) ...[
            buildSection(
                state,
                context,
                AppLocalizations.of(context)!.recentlyViewed,
                state.recentlyViewedItems.discoverItems,
                dgCardFormat: DGCardFormat.large)
          ],
          if (state.trendingItems.discoverItems.isNotEmpty) ...[
            buildSection(state, context, AppLocalizations.of(context)!.trending,
                state.trendingItems.discoverItems)
          ],
        ],
      ),
    );
  }

  Widget buildSection(
    DiscoverStateNew state,
    BuildContext context,
    String title,
    List<Input> items, {
    DGCardFormat? dgCardFormat,
    String? subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 48),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
        if (subTitle != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              subTitle,
            ),
          ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget containerView(Color containerColor) {
    return Container(
      height: 100,
      color: containerColor,
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
