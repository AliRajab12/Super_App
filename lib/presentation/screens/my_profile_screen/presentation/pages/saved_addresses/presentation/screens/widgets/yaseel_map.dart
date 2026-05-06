import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart'
    as Lat;
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/widget/search_widget.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/presentation/common/widgets/custom_button.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/data/models/address.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_bloc.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/bloc/saved_addresses_event.dart';

class SuperAppMap extends StatefulWidget {
  final BuildContext context2;
  final LatLng? llg2;
  final String buttonText;
  final bool addAddressScreen;
  const SuperAppMap(
      {super.key,
      required this.context2,
      this.llg2,
      required this.buttonText,
      this.addAddressScreen = false});

  @override
  State<SuperAppMap> createState() => SuperAppMapState();
}

class SuperAppMapState extends State<SuperAppMap> {
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
    if (widget.llg2 != null) {
      _kGooglePlex = CameraPosition(target: widget.llg2!, zoom: 12);
    }
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        body: Column(
          children: [
            Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                            onSelected: () async {    List<String> latlan = llg
                                .text
                                .replaceAll(
                                'LatLng(', '')
                                .replaceAll(' ', '')
                                .replaceAll(')', '')
                                .split(',');
                            _kGooglePlex =
                                CameraPosition(
                                    target: LatLng(
                                        double.parse(
                                            latlan[0]),
                                        double.parse(
                                            latlan[1])),
                                    zoom: 12);
                            final c = await _controller
                                .future;
                            c.animateCamera(CameraUpdate
                                .newLatLngZoom(
                                LatLng(
                                    double.parse(
                                        latlan[0]),
                                    double.parse(
                                        latlan[1])),
                                12));
                            setState(() {});}),
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
            ? Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: CustomButton(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    borderRadius: 30,
                    onPressed: () async {
                      if (widget.addAddressScreen) {
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
                              ? LatLng(double.parse(latlan[0]),
                                  double.parse(latlan[1]))
                              : await getCenter();

                          if (add.isNotEmpty) {
                            locator<SavedAddressesBloc>().add(
                                SaveUserAddressFromMap(
                                    address: Address(name: add)));
                          }
                        });
                      }
                    },
                    child: Text(
                      widget.buttonText,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )),
              )
            : const SizedBox.shrink(),
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
