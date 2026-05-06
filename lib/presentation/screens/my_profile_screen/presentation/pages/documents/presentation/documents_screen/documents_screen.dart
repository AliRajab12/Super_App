import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/svg_images.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/bloc/documents_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/bloc/documents_event.dart';

@RoutePage()
class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainRouter = locator<MainRouter>();
    return Scaffold(
        appBar: CustomAppBar(
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () => Navigator.of(context).pop(),
          title: 'Documents',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(children: [
            const SizedBox(height: 25),
            InkWell(
              onTap: () {
                locator<DocumentsBloc>().add(const SetDocumentsType(index: 0));
                locator<MainRouter>().navigateNamed('/documents/upload');
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Car Rental',
                      style: kSectionTitle,
                    ),
                    SvgPicture.asset(SvgImages.arrowIcon)
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
              child: Divider(
                color: Colors.grey.shade300,
              ),
            ),
            InkWell(
              onTap: () {
                locator<DocumentsBloc>().add(const SetDocumentsType(index: 1));
                locator<MainRouter>().navigateNamed('/documents/upload');
              },
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tourist Visa',
                      style: kSectionTitle,
                    ),
                    SvgPicture.asset(SvgImages.arrowIcon)
                  ]),
            ),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: CustomButton(
              height: 50,
              borderRadius: 30,
              onPressed: () {
                _mainRouter.navigateNamed('/documents/upload');
              },
              child: const Text(
                'Continue',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400),
              )),
        ));
  }
}
