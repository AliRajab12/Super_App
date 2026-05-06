import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_event.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_state.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/widgets/SuperApp_map.dart';

import '../widgets/add_address_form.dart';

@RoutePage()
class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final addressBloc = locator<SavedAddressesBloc>();
    return BlocBuilder<SavedAddressesBloc, SavedAddressesState>(
        bloc: addressBloc,
        builder: (context, state) => WillPopScope(
              onWillPop: () async {
                if (state.addAddressStep == 0) {
                  Navigator.of(context).pop();
                } else {
                  addressBloc.add(const NavigateToChooseLocationFromMapStep());
                }
                return false;
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  onBackButtonPressed: () {
                    if (state.addAddressStep == 0) {
                      Navigator.of(context).pop();
                    }
                    addressBloc
                        .add(const NavigateToChooseLocationFromMapStep());
                  },
                  onHomeButtonPressed: () {
                    addressBloc.add(const ResetState());
                    locator<MainRouter>().popUntilRouteWithPath('/home');
                  },
                  title: 'Add new address',
                ),
                body: BlocBuilder<SavedAddressesBloc, SavedAddressesState>(
                    bloc: addressBloc,
                    builder: (context, state) {
                      if (state.addAddressStep == 1) {
                        return const AddNewAddressForm();
                      }
                      return SuperAppMap(
                        buttonText: 'Continue',
                        addAddressScreen: true,
                        context2: context,
                      );
                    }),
              ),
            ));
  }
}
