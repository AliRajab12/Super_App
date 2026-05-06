import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_state.dart';

@RoutePage()
class NotificationListScreen extends StatelessWidget {
  const NotificationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () => Navigator.of(context).pop(),
          title: 'Notifications',
        ),
        body: BlocBuilder<SavedAddressesBloc, SavedAddressesState>(
            bloc: locator(),
            builder: (context, state) {
              if (state.loading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state.savedAddresses.isNotEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Text('There is data')],
                );
              } else if (state.savedAddresses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset('images/lottie/no_notification.json'),
                        Text(
                          'You have no notifications',
                          style: kSectionTitle.copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomButton(
              height: 50,
              borderRadius: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Go back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
