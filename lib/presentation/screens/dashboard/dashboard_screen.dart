import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_screen.dart';
import 'package:somi/presentation/screens/menu_new/menu_screen.dart';
import 'package:somi/presentation/screens/self_profile/profile_settings/profile_settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_indexed_stack/lazy_load_indexed_stack.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedTab = 0;
  //bool showSearch = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: DashboardSearchBar(
        onTap: () {
          QuickNav.push(context, const DashBoardSearchScreen());
        },
      ),
      body: LazyLoadIndexedStack(
        index: _selectedTab,
        children: const [
          ProfileSettingsScreen(),
          ProfileMenuScreenNew(),
        ],
      ),
      bottomNavigationBar: DashboardNavBar(
        selectedTab: _selectedTab,
        onTabSelected: (int index) {
          setState(() {
            if (index == 0) {
              //showSearch = false;
            }
            _selectedTab = index;
          });
        },
      ),
    );
  }
}

Widget _buildIconWithBadge(
    BuildContext context, IconData icon, int count, bool showCount) {
  return Badge(
    backgroundColor: Theme.of(context).colorScheme.error,
    isLabelVisible: count > 0,
    label: showCount ? Text(count.toString()) : null,
    child: Icon(icon),
  );
}

class DashboardSearchBar extends StatelessWidget
    implements PreferredSizeWidget {
  final Function() onTap;
  const DashboardSearchBar({
    super.key,
    required this.onTap,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 16,
      leading: Stack(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 13, horizontal: 9),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey.shade400)),
              child: IconButton(
                icon: SvgPicture.asset(
                  SvgImages.notificationIcon,
                ),
                onPressed: () {
                  locator<MainRouter>().navigateNamed('/notifications');
                },
              )),
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: Container(
              width: 13,
              height: 13,
              margin: const EdgeInsets.only(top: 17, right: 6),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                  border: Border.all(color: Colors.white)),
            ),
          ),
        ],
      ),
      titleSpacing: 0,
      title: SearchBar(
        constraints: const BoxConstraints(
            minWidth: 160.0, maxWidth: 800.0, minHeight: 43.0),
        hintText: AppLocalizations.of(context)!.search,
        textStyle: MaterialStateTextStyle.resolveWith((states) {
          return const TextStyle(color: Colors.grey, fontSize: 14);
        }),
        elevation: MaterialStateProperty.all(0),
        side: MaterialStateBorderSide.resolveWith((states) {
          if (states.contains(MaterialState.focused)) {
            return const BorderSide(
              color: kPrimaryColor,
              width: 2.0,
            );
          } else {
            return const BorderSide(
              color: Colors.grey,
              width: 1.0,
            );
          }
        }),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
        trailing: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(
              Icons.search,
              color: Colors.grey,
            ),
          )
        ],
        onTap: onTap,
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.account_circle,
            color: Colors.grey[600],
            size: 50.v,
          ),
          onPressed: () {
            locator<MainRouter>().navigate(const MyProfileScreenRoute());
          },
        )
      ],
    );
  }
}

class DashboardNavBar extends StatelessWidget {
  final int selectedTab;
  final ValueChanged<int> onTabSelected;

  const DashboardNavBar(
      {super.key, required this.selectedTab, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: selectedTab,
      onDestinationSelected: onTabSelected,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: AppLocalizations.of(context)!.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.language),
          label: AppLocalizations.of(context)!.groups,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: AppLocalizations.of(context)!.profile,
        ),
        NavigationDestination(
          icon: const Icon(Icons.menu),
          label: AppLocalizations.of(context)!.menu,
        ),
      ],
    );
  }
}
