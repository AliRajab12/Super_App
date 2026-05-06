import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/global.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_rounded_button.dart';

import '../../../../../core/widgets/adaptive_alert_dialog.dart';
import '../widgets/upload_documents_licence.dart';

@RoutePage()
class IdentifyScreen extends StatefulWidget {
  const IdentifyScreen({super.key});

  @override
  State<IdentifyScreen> createState() => _IdentifyScreenState();
}

class _IdentifyScreenState extends State<IdentifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Car Rental',
        homeButton: true,
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () =>
            locator<MainRouter>().popUntilRouteWithPath('/home'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const UploadDocumentsLicence(),
            const Spacer(),
            CustomRoundedButton(
              text: 'Continue',
              pressed: () {
                if (GlobalBloc.carBloc.state.documentsUploaded) {
                  locator<MainRouter>().navigate(const PaymentScreenRoute());
                } else {
                  showDegreedAdaptiveDialog(
                    context,
                    (context) => AdaptiveAlertDialog(
                      title: const Text('Please upload the required documents'),
                      actions: [
                        DialogAction(
                          label: 'Ok',
                          isDefaultAction: true,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
