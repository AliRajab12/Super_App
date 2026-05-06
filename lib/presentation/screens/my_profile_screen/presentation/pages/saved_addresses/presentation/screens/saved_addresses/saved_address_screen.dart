import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_state.dart';

@RoutePage()
class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainRouter = locator<MainRouter>();
    return Scaffold(
        appBar: CustomAppBar(
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () => Navigator.of(context).pop(),
          title: 'Saved Addresses',
          backgroundColor: SomiColors.background,
        ),
        backgroundColor: SomiColors.background,
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(SvgImages.noDataImage),
                      Text(
                        'There are no saved addresses on record',
                        style: kSectionTitle.copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      const Text('Save address to use in future')
                    ],
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
                _mainRouter.navigateNamed('/address/add');
              },
              child: const Text(
                'Add new address',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
