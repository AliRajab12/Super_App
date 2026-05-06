import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_rounded_button.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../core/theme/app_images.dart';
import '../../../../common/widgets/add_new_credit_card_form.dart';

@RoutePage()
class AddCardScreen extends StatelessWidget {
  const AddCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add new card',
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image.asset(
                      AppImages.card1,
                    ),
                    Image.asset(AppImages.card2),
                    Image.asset(AppImages.card1),
                  ],
                ),
              ),
              const Text(
                'Add new card',
                style: TextStyle(
                    color: SomiColors.greySecondary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 12,
              ),
              const AddNewCreditCardForm(
                fromAddCardScreen: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16.0),
        child: CustomRoundedButton(
          height: 45,
          text: 'Add new card',
        ),
      ),
    );
  }
}
