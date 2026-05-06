import 'package:somi/content_sheet/content_sheet.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/org_settings.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_shimmer_card.dart';
import 'package:somi/core/widgets/empty_list_widget.dart';
import 'package:somi/core/widgets/margin.dart';
import 'package:somi/core/widgets/network_error_widget.dart';
import 'package:somi/core/widgets/paginated_list_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'discover_cubit.dart';
import 'discover_state.dart';
import 'discover_view_all_screen.dart';
import 'somi_banner_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => DiscoverScreenState();
}

class DiscoverScreenState extends State<DiscoverScreen>
    with AutomaticKeepAliveClientMixin {
  final cubit = locator<DiscoverCubit>();
  OrgSettings? orgSettings;
  @override
  bool get wantKeepAlive => true;

  void update(Function(DiscoverScreenState it) block) =>
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

    return BlocBuilder<DiscoverCubit, DiscoverState>(
      bloc: cubit,
      builder: (context, state) {
        return _buildBody(context, state);
      },
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
          buildSection(
              state,
              context,
              AppLocalizations.of(context)!.continueLearning,
              state.continueLearningItems),
          buildSection(
              state,
              context,
              AppLocalizations.of(context)!.recentlyViewed,
              state.continueLearningItems,
              dgCardFormat: DGCardFormat.large),
          // TODO: To Discuss the title need to be added on app_localization
          buildSection(state, context, 'Agile Software Development',
              state.continueLearningItems,
              subTitle: AppLocalizations.of(context)!.focusSkills),
        ],
      ),
    );
  }

  Widget buildSection(
    DiscoverState state,
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
              TextButton(
                onPressed: () {
                  QuickNav.push(
                      context,
                      DiscoverViewAllScreen(
                          state: state, navigationTitle: title));
                },
                child: Text(AppLocalizations.of(context)!.viewAll),
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
        Margin(
          margin: const EdgeInsets.symmetric(horizontal: -16),
          child: DGCardConfig(
            format: dgCardFormat ?? DGCardFormat.small,
            child: SizedBox(
              height: 280,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
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
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return ContentSheet(
                                input: items[index],
                                scrollController: scrollController);
                          },
                        );
                      },
                    );
                  },
                  child: InputCard(input: items[index]),
                ),
              ),
            ),
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
