import 'package:auto_route/auto_route.dart';
import 'package:somi/core/init.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/widgets/list_row.dart';
import 'package:somi/core/widgets/no_app_bar.dart';
import 'package:somi/core/widgets/secret_gesture_detector.dart';
import 'package:somi/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_cubit.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class ProfileMenuScreen extends StatefulWidget {
  const ProfileMenuScreen({Key? key}) : super(key: key);

  @override
  State<ProfileMenuScreen> createState() => _ProfileMenuScreenState();
}

class _ProfileMenuScreenState extends State<ProfileMenuScreen> {
  final cubit = locator<ProfileMenuCubit>();

  @override
  void initState() {
    cubit.init();
    super.initState();
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
    );
  }

  Widget buildBody(BuildContext context, ProfileMenuState state) {
    return CustomScrollView(
      key: const Key('profile menu list'),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Profile settings, followers/following, and skills
                _followersAndSkills(context, state),

                // Saved, shared, groups, pathways, collections, etc.
                const SizedBox(height: 8),
                _contentAndCollections(context),

                // Knowledge center
                const SizedBox(height: 8),
                _knowledgeCenter(context),

                // Sign out button
                const SizedBox(height: 8),
                _signOut(context),

                // App version
                Flexible(
                  child: SecretGestureDetector(
                    onGesture: () =>
                        QuickNav.push(context, const DashboardScreen()),
                    child: Column(
                      children: [
                        const Spacer(flex: 1),
                        const SizedBox(height: 24),
                        state.appVersion == null
                            ? const SizedBox.shrink()
                            : Text(
                                AppLocalizations.of(context)!.appVersion +
                                    state.appVersion!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _followersAndSkills(BuildContext context, ProfileMenuState state) {
    final user = state.user;
    if (user == null) return Container();
    return ListCard(
      children: [
        ListRow(
          key: const Key('profile settings button'),
          label: user.name ?? '',
          user: user,
          userAvatarSize: 24,
          onTap: () => cubit.navigateToProfileSettings(),
        ),
        ListRow(
          key: const Key('following button'),
          label: AppLocalizations.of(context)!.following,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(user.followingCount.toString()),
          ),
          onTap: () => (),
        ),
        ListRow(
          key: const Key('followers button'),
          label: AppLocalizations.of(context)!.followers,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(user.followerCount.toString()),
          ),
          onTap: () => (),
        ),
      ],
    );
  }

  Widget _contentAndCollections(BuildContext context) {
    return ListCard(
      children: [
        ListRow(
          label: AppLocalizations.of(context)!.saved,
          icon: Icons.bookmark,
          onTap: () => (),
        ),
      ],
    );
  }

  Widget _knowledgeCenter(BuildContext context) {
    return ListCard(
      children: [
        ListRow(
          label: AppLocalizations.of(context)!.knowledgeCenter,
          icon: Icons.help,
          onTap: () {
            launchUrl(Uri.parse(Env.knowledgeCenterUrl),
                mode: LaunchMode.externalApplication);
          },
        ),
      ],
    );
  }

  Widget _signOut(BuildContext context) {
    return ListCard(
      children: [
        ListRow(
          key: const Key('sign out button'),
          label: AppLocalizations.of(context)!.signOut,
          onTap: () => cubit.performSignOut(),
        ),
      ],
    );
  }
}
