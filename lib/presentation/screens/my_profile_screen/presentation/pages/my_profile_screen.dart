import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/theme/colors.dart';

import '../../../../common/widgets/custom_app_bar.dart';

import '../widgets/profile_row.dart';
import '../widgets/profile_text_tilte.dart';

@RoutePage()
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final _mainRouter = locator<MainRouter>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'My Profile',
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () => Navigator.of(context).pop(),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const ProfileTextTitle(
            title: 'Account',
          ),
          ProfileRow(
            title: 'Personal Information',
            image: SvgImages.personIcon,
            divider: true,
            press: () {
              _mainRouter.navigateNamed('/personal-info');
            },
          ),
          ProfileRow(
              title: 'Saved Address',
              image: SvgImages.locationNewIcon,
              press: () {
                _mainRouter.navigateNamed('/saved-addresses');
              }),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Documents',
          ),
          ProfileRow(
              title: 'Driver license, Passport, Resident ID',
              image: SvgImages.documentsIcon,
              press: () {
                _mainRouter.navigateNamed('/documents');
              }),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Payment',
          ),
          ProfileRow(
            title: 'Wallet Balance',
            image: SvgImages.walletIcon,
            divider: true,
            press: () {
              _mainRouter.navigateNamed('/wallet');
            },
          ),
          ProfileRow(
            title: 'Cards and accounts',
            image: SvgImages.cardIcon,
            press: () {
              _mainRouter.navigateNamed('/my-cards');
            },
          ),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Medical',
          ),
          ProfileRow(title: 'Medical reports', image: SvgImages.medicalIcon),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'History',
          ),
          ProfileRow(title: 'Booking history', image: SvgImages.timeIcon),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Preference',
          ),
          ProfileRow(title: 'Current Location', image: SvgImages.langIcon),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Support',
          ),
          ProfileRow(title: 'Help', image: SvgImages.contactUsIcon),
          const SizedBox(
            height: 12,
          ),
          Divider(
            color: Colors.grey.shade300,
            height: 1,
          ),
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding:
                  const EdgeInsetsDirectional.symmetric(horizontal: 16),
              trailing: SvgPicture.asset(SvgImages.arrowIcon),
              childrenPadding: EdgeInsets.zero,
              title: Row(
                children: [
                  SvgPicture.asset(SvgImages.setting1Icon),
                  const SizedBox(
                    width: 12,
                  ),
                  const Text(
                    'Setting',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              children: <Widget>[
                Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.logoutIcon),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Logout',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.symmetric(
                          horizontal: 24, vertical: 12),
                      child: Divider(
                        color: Colors.grey.shade300,
                        height: 1,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.symmetric(horizontal: 32),
                      child: Row(
                        children: [
                          SvgPicture.asset(SvgImages.deleteIcon),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Delete Account',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.red,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
