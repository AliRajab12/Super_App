import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/widgets/linear_loading_indicator.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_cubit.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_state.dart';
import 'package:somi/presentation/screens/dashboard/search/search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashBoardSearchScreen extends StatefulWidget {
  const DashBoardSearchScreen({super.key});

  @override
  State<DashBoardSearchScreen> createState() => _DashBoardSearchScreenState();
}

class _DashBoardSearchScreenState extends State<DashBoardSearchScreen> {
  TextEditingController searchController = TextEditingController();
  DashboardSearchCubit cubit = locator<DashboardSearchCubit>();
  final scrollController = ScrollController();
  final FocusNode focusNode = FocusNode();
  @override
  void initState() {
    cubit.searchSkills('');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocBuilder<DashboardSearchCubit, DashboardSearchState>(
        bloc: cubit,
        builder: (context, state) {
          return Scaffold(
            appBar: buildSearchInput(context, focusNode, searchController),
            body: buildBody(context, state),
          );
        },
      ),
    );
  }

  AppBar buildSearchInput(BuildContext context, FocusNode focusNode,
      TextEditingController textEditingController) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 44,
      centerTitle: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: focusNode,
              autofocus: true,
              onChanged: (value) {
                cubit.searchSkills(value);
              },
              // onSubmitted: (value) {
              //   cubit.searchSkills(value);
              // },
              decoration: InputDecoration(
                  suffix: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      searchController.clear();
                    },
                  ),
                  border: InputBorder.none,
                  hintText: AppLocalizations.of(context)!.searchInput,
                  fillColor: const Color(0xFFE9E7EC)),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 16,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: SearchBar(
              constraints: const BoxConstraints(
                  minWidth: 180.0, maxWidth: 800.0, minHeight: 56.0),
              hintText: AppLocalizations.of(context)!.search,
              elevation: MaterialStateProperty.all(0),
              backgroundColor:
                  MaterialStateProperty.all(const Color(0xFFE9E7EC)),
              leading: const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Icon(Icons.search),
              ),
              trailing: [
                Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.close),
                    )),
              ],
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBody(BuildContext context, DashboardSearchState state) {
    /// TODO: Added for initial test purpose with hard coded text values.
    List<String> modelSuggestion = [
      'Video marketing',
      'Customer relationship management (CRM)',
      'Analytics'
    ];

    return Column(
      children: [
        /// Search suggestion widget
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          height: 75,
          child: ListView.builder(
            itemCount: modelSuggestion.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              String suggestion = modelSuggestion[index];
              final TextPainter textPainter = TextPainter(
                text: TextSpan(text: suggestion),
                textDirection: TextDirection.ltr,
              )..layout();
              final double width = textPainter.size.width;
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: width + 100,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  border: Border.all(
                    color: const Color(0xFF757780),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: SomiColors.blue),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      modelSuggestion[index],
                      style: const TextStyle(
                          color: SomiColors.blue, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        // Your List Title and Subtitle
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.results,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '1 - 20 of 230',
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24, top: 12),
            children: buildChildren(context, state),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LinearLoadingIndicator(state.searching),
          ),
        ),
      ],
    );
  }

  Widget searchEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 326,
            height: 231,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        'images/illustrations/glasses-balloons.png'))),
          ),
          const SizedBox(height: 24),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!,
            child: Text(AppLocalizations.of(context)!.noSearchResult),
          ),
          const SizedBox(height: 16),
          DefaultTextStyle(
            style: Theme.of(context).textTheme.bodyMedium!,
            child: Text(AppLocalizations.of(context)!.emptySearchDescription),
          ),
        ],
      ),
    );
  }

  List<Widget> buildChildren(BuildContext context, DashboardSearchState state) {
    if (state.searching) {
      return [
        const ShimmerSearchSection(),
        const ShimmerSearchSection(),
      ];
    } else if (state.searchResult.isEmpty) {
      return [
        searchEmptyState(context)
      ]; // Display empty state if search results are empty
    } else {
      return state.searchResult
          .map((s) => SearchItem(searchResult: s))
          .toList();
    }
  }
}
