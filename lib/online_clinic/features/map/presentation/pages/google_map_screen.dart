import 'dart:async';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_bloc.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_event.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_state.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/status/get_permission_status.dart';
import 'package:somi/online_clinic/features/map/presentation/widgets/auto_complete_field.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  GoogleMapPageState createState() => GoogleMapPageState();
}

class GoogleMapPageState extends State<GoogleMapPage> {
  // ignore: prefer_final_fields

  //var myMarkers = HashSet<Marker>();
  late LatLng currentPosition;
  late LatLng _center;
  late Position currentLocation;

  final searchController = TextEditingController();
  late BitmapDescriptor icon;

  @override
  void initState() {
    super.initState();
    currentLocation = Position.fromMap({'latitude': 25.27, 'longitude': 55.29});
    createBitmapIcon();
    context.read<MapBloc>().add(CheckLocationPermissionEvent());
  }

  Future<void> createBitmapIcon() async {
    icon =
        await Utils.getBitmapDescriptorFromSvgAsset('images/svg/location.svg');
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getUserLocation() async {
    currentLocation = await locateUser();
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
    // ignore: avoid_print
    print('center: $_center');
  }

  late GoogleMapController _controller;
  final Set<Marker> _marker = {};

  @override
  Widget build(BuildContext context) {
    // var myMarkers;
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<MapBloc, MapState>(
          listener: (context, state) {
            if (state.permissionStatus is PermissionDenied) {
              context.read<MapBloc>().add(RequestLocationPermissionEvent());
            }
            if (state.permissionStatus is PermissionGranted) {
              getUserLocation();
            }
          },
          builder: (context, state) {
            if (state.permissionStatus is PermissionGranted) {
              return Stack(children: [
                GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(
                          currentLocation.latitude, currentLocation.longitude),
                      zoom: 17),
                  //target: LatLng(33.729832079212564, 73.03719651292022), zoom: 8),
                  //   myLocationButtonEnabled: true,
                  // myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  compassEnabled: true,
                  trafficEnabled: true,
                  onTap: (position) async {
                    List<Placemark> placeMarks = await placemarkFromCoordinates(
                        position.latitude, position.longitude);

                    setState(() {
                      final address = placeMarks.firstOrNull;
                      searchController.text =
                          '${address?.locality} - ${address?.street}';
                      _marker.add(
                        Marker(
                            markerId: const MarkerId('currentLocation'),
                            infoWindow:
                                const InfoWindow(title: 'Current Position'),
                            position:
                                LatLng(position.latitude, position.longitude),
                            icon: icon),
                      );
                    });
                  },
                  onMapCreated: (GoogleMapController mapController) async {
                    _controller = mapController;
                    setState(() {
                      _marker.add(
                        Marker(
                            markerId: const MarkerId('currentLocation'),
                            infoWindow:
                                const InfoWindow(title: 'Current Position'),
                            position: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            icon: icon),
                      );
                    });
                  },
                  markers: _marker,
                ),
                Positioned(
                  right: 8,
                  left: 8,
                  top: 16,
                  child: Column(
                    children: [
                      AutocompleteField(
                          controller: searchController,
                          lat: currentLocation.latitude,
                          lng: currentLocation.longitude,
                          onSelected: (selected) async {
                            FocusScopeNode currentFocus =
                                FocusScope.of(context);
                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }
                            List<Location> locations =
                                await locationFromAddress(selected.description);

                            setState(() {
                              _controller.animateCamera(
                                  CameraUpdate.newLatLngZoom(
                                      LatLng(locations[0].latitude,
                                          locations[0].longitude),
                                      16));
                            });
                          }),
                    ],
                  ),
                ),
              ]);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      //  floatingActionButtonLocation: FloatingActionButtonLocation.,
      floatingActionButton: FloatingActionButton(
        backgroundColor: OnlineClinicColorStyle.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.r)),
        child: CustomImage(
          imageWidth: 24.w,
          imageHeight: 24.h,
          imageSvgPath: 'images/svg/gps.svg',
        ),
        onPressed: () async {
          final position = await Geolocator.getCurrentPosition();
          _controller.animateCamera(
            CameraUpdate.newLatLngZoom(
              LatLng(position.latitude, position.longitude),
              16,
            ),
          );
          List<Placemark> placeMarks = await placemarkFromCoordinates(
              position.latitude, position.longitude);

          setState(() {
            final address = placeMarks.firstOrNull;
            searchController.text = '${address?.locality} - ${address?.street}';
            _marker.add(
              Marker(
                  markerId: const MarkerId('currentLocation'),
                  infoWindow: const InfoWindow(title: 'Current Position'),
                  position: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  icon: icon),
            );
          });
        },
      ),
    );
  }
}
