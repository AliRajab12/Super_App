import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';

import '../../../../../core/main_router.dart';
import '../../../../../core/service_locator.dart';
import '../../../../../core/theme/app_images.dart';
import '../../../../common/widgets/custom_rounded_button.dart';
import '../widgets/wallet_card.dart';

@RoutePage()
class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Wallet',
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(AppImages.card),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRoundedButton(
                    height: 45,
                    width: (MediaQuery.of(context).size.width / 2) - 24,
                    text: 'Pay',
                    textColor: Colors.white,
                    backgroundColor: SomiColors.blue,
                    pressed: () {},
                  ),
                  CustomRoundedButton(
                    height: 45,
                    width: (MediaQuery.of(context).size.width / 2) - 24,
                    text: 'Receive',
                    textColor: Colors.black,
                    backgroundColor: Colors.white,
                    pressed: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaction',
                    style: kSectionTitle,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      'View all',
                      style: kViewAll,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Text(
                    'Today',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: SomiColors.greySecondary),
                  ),
                ],
              ),
              ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const WalletCard();
                  }),
              const SizedBox(
                height: 12,
              ),
              const Row(
                children: [
                  Text(
                    'Yesterday',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: SomiColors.greySecondary),
                  ),
                ],
              ),
              ListView.builder(
                  itemCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return const WalletCard();
                  }),
              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
