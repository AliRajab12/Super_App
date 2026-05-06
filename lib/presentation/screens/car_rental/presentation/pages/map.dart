import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart'
    as Lat;
import 'package:somi/core/models/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';
import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_event.dart';
import 'package:somi/presentation/screens/car_rental/presentation/widgets/CustomButton.dart';
import 'package:somi/core/service_locator.dart';
import '../widgets/Navigator.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import 'package:somi/core/main_router.dart';

class map extends StatefulWidget {
  final String title;
  final BuildContext context2;
  final LatLng? llg2;
  const map(
      {super.key, required this.title, required this.context2, this.llg2});

  @override
  State<map> createState() => mapState();
}

class mapState extends State<map> {
  final textController = TextEditingController();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(25.2048, 55.2708),
    zoom: 12,
  );

  TextEditingController llg = TextEditingController();
  bool visible = true;

  @override
  void initState() {
    super.initState();
    llg.addListener(() {});
  }

  @override
  void dispose() {
    llg.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final carBloc = locator<CarBloc>();
    if (widget.llg2 != null) {
      _kGooglePlex = CameraPosition(target: widget.llg2!, zoom: 12);
    }
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: CustomAppBar(
          title: 'Car Details',
          onBackButtonPressed: () => Navigator.of(context).pop(),
          onHomeButtonPressed: () =>
              locator<MainRouter>().popUntilRouteWithPath('/home'),
        ),
        body: Column(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('  ${widget.title}  ', style: kCarTitle),
                  Text(
                      widget.title == 'Delivery'
                          ? '  Where To deliver the car ?  '
                          : '  Where Will you return The car ?  ',
                      style: kCarDetails),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Stack(children: [
                        SearchLocation(
                          llg: llg,
                          controller: textController,
                          placeholder: 'Type Location',
                          country: 'ARE',
                          hasClearButton: false,
                          apiKey: 'AIzaSyAPHCD6R3NzPBhaO3yFn5N-63N8puzbupQ',
                          language: 'en',
                          initvalue: '',
                          onSelected: () async {
                            List<String> latlan = llg.text
                                .replaceAll('LatLng(', '')
                                .replaceAll(' ', '')
                                .replaceAll(')', '')
                                .split(',');
                            _kGooglePlex = CameraPosition(
                                target: LatLng(double.parse(latlan[0]),
                                    double.parse(latlan[1])),
                                zoom: 12);
                            final c = await _controller.future;
                            c.animateCamera(CameraUpdate.newLatLngZoom(
                                LatLng(double.parse(latlan[0]),
                                    double.parse(latlan[1])),
                                12));
                            setState(() {});
                          },
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Divider(
                                      height: size.height * 0.02,
                                      color: Colors.transparent),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              textController.clear();
                                              setState(() {});
                                            },
                                            icon: const Icon(Icons.cancel,
                                                color: kTextColor)),
                                        IconButton(
                                            onPressed: () async {
                                              if (llg.text.isNotEmpty) {
                                                List<String> latlan = llg.text
                                                    .replaceAll('LatLng(', '')
                                                    .replaceAll(' ', '')
                                                    .replaceAll(')', '')
                                                    .split(',');
                                                _kGooglePlex = CameraPosition(
                                                    target: LatLng(
                                                        double.parse(latlan[0]),
                                                        double.parse(
                                                            latlan[1])),
                                                    zoom: 12);
                                                final c =
                                                    await _controller.future;
                                                c.animateCamera(
                                                    CameraUpdate.newLatLngZoom(
                                                        LatLng(
                                                            double.parse(
                                                                latlan[0]),
                                                            double.parse(
                                                                latlan[1])),
                                                        12));
                                                setState(() {});
                                              }
                                            },
                                            icon: const Icon(Icons.my_location,
                                                color: kPrimaryColor)),
                                        SizedBox(width: size.width * 0.03)
                                      ])
                                ]))
                      ])),
                  const Divider(height: 10, color: Colors.transparent)
                ]),
            Expanded(
              child: Stack(children: [
                SizedBox(
                    height: size.height,
                    width: size.width,
                    child: GoogleMap(
                        mapType: MapType.normal,
                        mapToolbarEnabled: true,
                        initialCameraPosition: _kGooglePlex,
                        onCameraMove: (i) {
                          setState(() {
                            visible = false;
                          });
                        },
                        onCameraIdle: () {
                          setState(() {
                            visible = true;
                          });
                        },
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                          print(_controller.isCompleted);
                        })),
                const Center(
                    child:
                        Icon(Icons.location_on, color: kPrimaryColor, size: 50))
              ]),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: visible && !isKeyboardVisible
            ? CustomButton(
                height: size.height * 0.075,
                title: 'Confirm Address',
                tap: () async {
                  await getCenter().then((value) async {
                    String add = await getAddress(value);
                    List<String> latlan = textController.text.isNotEmpty
                        ? llg.text
                            .replaceAll('LatLng(', '')
                            .replaceAll(' ', '')
                            .replaceAll(')', '')
                            .split(',')
                        : [];
                    LatLng ll = textController.text.isNotEmpty
                        ? LatLng(
                            double.parse(latlan[0]), double.parse(latlan[1]))
                        : await getCenter();
                    if (add.isNotEmpty) {
                      if (widget.title == 'Delivery') {
                        carBloc.add(SetDeliveryAddressEvent(
                            index: textController.text.isNotEmpty
                                ? Location(
                                    title: textController.text,
                                    lat: ll.latitude,
                                    lng: ll.longitude)
                                : Location(
                                    title: add,
                                    lat: ll.latitude,
                                    lng: ll.longitude)));

                        pop(context);
                      } else {
                        carBloc.add(SetReturnAddressEvent(
                            index: textController.text.isNotEmpty
                                ? Location(
                                    title: textController.text,
                                    lat: ll.latitude,
                                    lng: ll.longitude)
                                : Location(
                                    title: add,
                                    lat: ll.latitude,
                                    lng: ll.longitude)));
                        pop(context);
                      }
                    }
                  });
                })
            : const Text(''),
      );
    });
  }

  Future<LatLng> getCenter() async {
    final GoogleMapController controller = await _controller.future;
    LatLngBounds visibleRegion = await controller.getVisibleRegion();
    LatLng centerLatLng = LatLng(
      (visibleRegion.northeast.latitude + visibleRegion.southwest.latitude) / 2,
      (visibleRegion.northeast.longitude + visibleRegion.southwest.longitude) /
          2,
    );
    return centerLatLng;
  }

  Future<String> getAddress(LatLng latLng) async {
    return await Lat.FlutterAddressFromLatLng().getFormattedAddress(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      googleApiKey: 'AIzaSyAPHCD6R3NzPBhaO3yFn5N-63N8puzbupQ',
    );
  }
}
