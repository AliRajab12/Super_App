import 'package:auto_route/auto_route.dart';
import 'package:flexi_image_slider/flexi_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/common/widgets/custom_app_bar.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_state.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/CustomButton.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/CustomTextFormField.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/Details.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/Options.dart';
import '../../../../../core/widgets/adaptive_alert_dialog.dart';

@RoutePage()
class CarBookScreen extends StatelessWidget {
  final Car? car;
  const CarBookScreen({Key? key, this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final carBloc = locator<CarBloc>();
    return Scaffold(
        backgroundColor: HexColor('#F3F7FF'),
        extendBodyBehindAppBar: true,
        appBar: CustomAppBar(
          title: 'Car Details',
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () =>
              locator<MainRouter>().popUntilRouteWithPath('/home'),
        ),
        body: SafeArea(
            child: BlocBuilder<CarBloc, CarState>(
                bloc: carBloc,
                builder: (context, state) {
                  // BlocProvider.of<Car_Details>(context).Rental_Car(car!);
                  return SingleChildScrollView(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Divider(height: 5, color: Colors.transparent),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text('  ${carBloc.state.car!.name} ',
                            style: kCarTitle)),
                    state.car!.imageUrl.contains('http')
                        ? flexi_image_slider(
                            context: context,
                            aspectRatio: 20 / 14,
                            arrayImages: [carBloc.state.car!.imageUrl],
                            autoScroll: false,
                            viewportFraction: 0.8,
                            boxFit: BoxFit.fill,
                            indicatorPosition: IndicatorPosition.overImage,
                            indicatorAlignment: IndicatorAlignment.center,
                            duration: const Duration(seconds: 4),
                            indicatorActiveColor: kPrimaryColor,
                            indicatorDeactiveColor: kPrimaryColor,
                            borderRadius: 0,
                            onTap: (int index) {})
                        : Container(
                            width: size.width,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        carBloc.state.car!.imageUrl))),
                          ),
                    const Divider(height: 5, color: Colors.transparent),
                    Options(name: 'Delivery Options', list: Delivery_Options),
                    const Divider(height: 5, color: Colors.transparent),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Delivery', style: kPrice))),
                    Details(type: 'Delivery', context2: context),
                    const Divider(height: 5, color: Colors.transparent),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Return', style: kPrice))),
                    Details(type: 'Return', context2: context),
                    Options(name: 'Driver', list: Driver_Options),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Cost Breakdown', style: kPrice))),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: ListTile(
                          title: const Text('Rental Period', style: kPrice),
                          trailing:
                              Text(carBloc.state.car!.price, style: kDelivery),
                          subtitle:
                              Text(carBloc.state.car!.price, style: kRate),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                          title: Text(
                              'Delivery ${Delivery_Options.elementAt(state.deliveryOption!)[0]}',
                              style: kPrice),
                          trailing: Text(
                              '${Delivery_Options.elementAt(state.deliveryOption!)[2]} AED',
                              style: kDelivery),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(children: [
                          CustomTextFormField(
                              required: false,
                              isborder: false,
                              labelText: 'Promo Code'),
                          Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                      decoration: const BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(25),
                                              bottomRight:
                                                  Radius.circular(25))),
                                      height: size.height * 0.08,
                                      width: 75,
                                      child: const Center(
                                          child: Text('Send',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              textAlign: TextAlign.center)))))
                        ])),
                    const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: ListTile(
                            title: Text('Total', style: kPrice),
                            trailing: Text('160 AED', style: kDelivery))),
                    BlocBuilder<CarBloc, CarState>(
                        bloc: carBloc,
                        builder: (context, state) {
                          if (state.loading) {
                            return CustomButton(
                                height: size.height * 0.07,
                                title: '',
                                tap: () {});
                          }
                          return CustomButton(
                              height: size.height * 0.07,
                              title: 'Book Now',
                              tap: () {
                                if (state.firstDate != null &&
                                    state.endDate != null &&
                                    state.returnAddress?.title != null &&
                                    state.deliveryAddress?.title != null) {
                                  locator<MainRouter>()
                                      .navigate(const IdentifyScreenRoute());
                                } else {
                                  showDegreedAdaptiveDialog(
                                    context,
                                    (context) => AdaptiveAlertDialog(
                                      title: const Text(
                                          'Please Complete Delivery And Return Details'),
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
                              });
                        }),
                    const Divider(height: 10, color: Colors.transparent)
                  ]));
                })));
  }
}
