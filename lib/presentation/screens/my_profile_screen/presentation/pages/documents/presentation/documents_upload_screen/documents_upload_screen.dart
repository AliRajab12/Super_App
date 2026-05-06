import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';

import 'widgets/document_upload_widget.dart';

@RoutePage()
class DocumentsUploadScreen extends StatelessWidget {
  const DocumentsUploadScreen({Key? key}) : super(key: key);

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
          child: ListView(
              children: const [SizedBox(height: 25), DocumentsUploadWidget()]),
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
