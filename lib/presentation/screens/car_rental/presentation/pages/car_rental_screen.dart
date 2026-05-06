import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';

import '../widgets/brand_list_widget.dart';
import '../widgets/car_list_widget.dart';
import '../widgets/filter_button_widget.dart';
import '../widgets/rental_date_widget.dart';

@RoutePage()
class CarRentalScreen extends StatefulWidget {
  const CarRentalScreen({Key? key}) : super(key: key);

  @override
  State<CarRentalScreen> createState() => _CarRentalScreenState();
}

class _CarRentalScreenState extends State<CarRentalScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onBackButtonPressed: () => Navigator.of(context).pop(),
        onHomeButtonPressed: () => Navigator.of(context).pop(),
        title: 'Car Rental',
      ),
      body: const SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RentalDateWidget(),
            Padding(
              padding: EdgeInsetsDirectional.only(start: 16.0, top: 16),
              child: Text(
                'Top brand',
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
              ),
            ),
            BrandListWidget(),
            FilterButtonWidget(),
            CarListWidget()
          ],
        ),
      ),
    );
  }
}
