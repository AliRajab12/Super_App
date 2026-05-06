import 'package:auto_route/auto_route.dart';
import 'package:somi/core/init.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/widgets/list_row.dart';
import 'package:somi/core/widgets/no_app_bar.dart';
import 'package:somi/presentation/screens/notification/presentation/screens/notification_list_screen.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_cubit.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ProfileMenuScreenNew extends StatefulWidget {
  const ProfileMenuScreenNew({Key? key}) : super(key: key);

  @override
  State<ProfileMenuScreenNew> createState() => _ProfileMenuScreenStateNew();
}

class _ProfileMenuScreenStateNew extends State<ProfileMenuScreenNew> {
  final cubit = locator<ProfileMenuCubit>();
  final user = locator<UserRepo>();
  Future<String>? appVersion;

  @override
  void initState() {
    cubit.init();
    super.initState();
    appVersion = getVersion();
  }

  Future<String> getVersion() async {
    WidgetsFlutterBinding.ensureInitialized();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = '${packageInfo.version} (${packageInfo.buildNumber})';
    return version;
  }

  @override
  void dispose() {
    cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NoAppBar(),
      body: BlocBuilder<ProfileMenuCubit, ProfileMenuState>(
        bloc: cubit,
        builder: (context, state) => buildBody(context, state),
      ),
      backgroundColor: const Color(0xffeef0ff),
    );
  }

  Widget buildBody(BuildContext context, ProfileMenuState state) {
    return Container(
      color: const Color(0xffeef0ff),
      child: CustomScrollView(
        key: const Key('profile menu list'),
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  height: 255,
                  constraints: const BoxConstraints(maxHeight: 255),
                  color: const Color(0xffeef0ff),
                  child: Container(),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            key: const Key('profile menu _notifications'),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () =>
                      QuickNav.push(context, const NotificationListScreen()),
                  child: Card(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 140,
                      color: const Color(0xffeef0ff),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                        right: 16,
                        bottom: 0,
                      ),
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: _notifications(context),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            key: const Key('profile menu _knowledgeCenter'),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => launchUrl(
                    Uri.parse(Env.knowledgeCenterUrl),
                    mode: LaunchMode.externalApplication,
                  ),
                  child: Card(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 140,
                      color: const Color(0xffeef0ff),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                        right: 16,
                        bottom: 0,
                      ),
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: _knowledgeCenter(context),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 300.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.3,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index == 0) {
                  return GestureDetector(
                    onTap: () => launchUrl(
                      Uri.parse(
                        'https://prod.degreedcdn.com/content/privacy-policy/degreed-privacy-policy-en-us.pdf?v=10869840969166135',
                      ),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        color: const Color(0xffeef0ff),
                        height: 130,
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 8,
                          right: 0,
                          bottom: 0,
                        ),
                        child: _privacyPolicy(context),
                      ),
                    ),
                  );
                } else {
                  return GestureDetector(
                    onTap: () => launchUrl(
                      Uri.parse('https://degreed.com/api/about/cookienotice'),
                      mode: LaunchMode.externalApplication,
                    ),
                    child: Card(
                      child: Container(
                        alignment: Alignment.center,
                        color: const Color(0xffeef0ff),
                        height: 130,
                        padding: const EdgeInsets.only(
                          left: 0,
                          top: 8,
                          right: 16,
                          bottom: 0,
                        ),
                        child: _cookieNotice(context),
                      ),
                    ),
                  );
                }
              },
              childCount: 2,
            ),
          ),
          SliverList(
            key: const Key('profile menu _signOut'),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => cubit.performSignOut(),
                  child: Card(
                    child: Container(
                      alignment: Alignment.topCenter,
                      height: 150,
                      color: const Color(0xffeef0ff),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 8,
                        right: 16,
                        bottom: 16,
                      ),
                      constraints: const BoxConstraints(maxHeight: 150),
                      child: _signOut(context),
                    ),
                  ),
                );
              },
              childCount: 1,
            ),
          ),
          SliverList(
            key: const Key('profile menu _version'),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  alignment: Alignment.topCenter,
                  height: 130,
                  padding: const EdgeInsets.only(
                    left: 16,
                    top: 0,
                    right: 16,
                    bottom: 16,
                  ),
                  constraints: const BoxConstraints(maxHeight: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FutureBuilder(
                        future: appVersion,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              '${snapshot.data}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error.toString());
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _signOut(BuildContext context) {
    return ListCardForMenu(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      children: [
        ListRowForMenu(
          key: const Key('sign out button'),
          label: AppLocalizations.of(context)!.signOut,
          onTap: () => cubit.performSignOut(),
          subLabel:
              'Sign out and return to login page.                                                       ',
          icon: 'images/MenuItems/iconSignOut.png',
        ),
      ],
    );
  }

  Widget _notifications(BuildContext context) {
    return ListCardForMenu(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      children: [
        ListRowForMenu(
          key: const Key('sign out button'),
          label: 'Notifications',
          onTap: () => QuickNav.push(context, const NotificationListScreen()),
          subLabel:
              'View and action your Degreed notifications.                               ',
          icon: 'images/MenuItems/iconNotification.png',
        ),
      ],
    );
  }

  Widget _knowledgeCenter(BuildContext context) {
    return ListCardForMenu(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      children: [
        ListRowForMenu(
          key: const Key('sign out button'),
          label: 'Knowledge center',
          onTap: () {
            launchUrl(
              Uri.parse(Env.knowledgeCenterUrl),
              mode: LaunchMode.externalApplication,
            );
          },
          subLabel:
              'Feedback is vital to make the Degreed eco system even better.                                                     ',
          icon: 'images/MenuItems/iconKnowledge.png',
        ),
      ],
    );
  }

  Widget _privacyPolicy(BuildContext context) {
    return ListCardForMenu(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      children: [
        ListRowForMenu(
          key: const Key('sign out button'),
          label: 'Privacy Policy',
          onTap: () {
            launchUrl(
              Uri.parse(
                'https://prod.degreedcdn.com/content/privacy-policy/degreed-privacy-policy-en-us.pdf?v=10869840969166135',
              ),
              mode: LaunchMode.externalApplication,
            );
          },
          subLabel: 'Learn more about your privacy policy.',
          icon: 'images/MenuItems/iconPrivacy.png',
        ),
      ],
    );
  }

  Widget _cookieNotice(BuildContext context) {
    return ListCardForMenu(
      padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
      children: [
        ListRowForMenu(
          key: const Key('sign out button'),
          label: 'Cookie Notice',
          onTap: () {
            launchUrl(
              Uri.parse('https://degreed.com/api/about/cookienotice'),
              mode: LaunchMode.externalApplication,
            );
          },
          subLabel: 'Learn more about our cookies.',
          icon: 'images/MenuItems/iconCookie.png',
        ),
      ],
    );
  }
}
