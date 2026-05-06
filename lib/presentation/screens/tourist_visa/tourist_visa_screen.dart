import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'widgets/visa_service_container.dart';

@RoutePage()
class TouristVisaScreen extends StatelessWidget {
  const TouristVisaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainRouter = locator<MainRouter>();
    return Scaffold(
        appBar: CustomAppBar(
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () => Navigator.of(context).pop(),
          title: 'Tourist Visa',
          backgroundColor: SomiColors.background,
        ),
        backgroundColor: SomiColors.background,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Image.asset('images/visa_banner.png')),
              SizedBox(
                height: 50.v,
              ),
              Wrap(
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 20,
                runSpacing: 25,
                runAlignment: WrapAlignment.center,
                children: [
                  VisaServiceContainer(
                    color: AppColors.primary.withOpacity(0.6),
                    imagePath: 'images/visa_new.svg',
                    text: 'New\nApplication',
                    textColor: Colors.white,
                    onTap: () => _mainRouter.navigateNamed('/visa-app'),
                  ),
                  VisaServiceContainer(
                      color: Colors.white,
                      imagePath: 'images/visa_renew.svg',
                      text: 'Renewal',
                      textColor: Colors.black,
                      onTap: () => _mainRouter.navigateNamed('/visa-renewal')),
                  VisaServiceContainer(
                    color: Colors.white,
                    imagePath: 'images/visa_ext.svg',
                    text: 'Extension',
                    textColor: Colors.black,
                    onTap: () => _mainRouter.navigateNamed('/visa-extension'),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: PrimaryButton.large(
              expand: true,
              onPressed: () {},
              child: const Text(
                'Call',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
