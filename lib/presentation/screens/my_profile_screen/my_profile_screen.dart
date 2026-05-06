import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/widgets/profile_row.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/widgets/profile_text_tilte.dart';
import '../../../core/theme/colors.dart';
import '../../common/widgets/custom_app_bar.dart';

@RoutePage()
class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
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
          ),
          ProfileRow(
            title: 'Saved Address',
            image: SvgImages.locationNewIcon,
            divider: true,
          ),
          ProfileRow(title: 'Notification', image: SvgImages.notificationIcon),
          const SizedBox(
            height: 12,
          ),
          const ProfileTextTitle(
            title: 'Documents',
          ),
          ProfileRow(
              title: 'Personal Information', image: SvgImages.documentsIcon),
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
              //  locator
            },
          ),
          ProfileRow(title: 'Cards and accounts', image: SvgImages.cardIcon),
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
            title: 'Location',
          ),
          ProfileRow(
              title: 'Current Location', image: SvgImages.locationNewIcon),
        ]),
      ),
    );
  }
}
