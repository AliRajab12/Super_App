import 'dart:async';
import 'dart:math';
import 'package:gap/gap.dart';
import 'package:geocoding/geocoding.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:somi/online_clinic/core/style/online_clinic_color_style.dart';
import 'package:somi/online_clinic/core/utils/utils.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_button/app_button.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/custom_image.dart';
import 'package:somi/online_clinic/core/widgets/custom_container.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_bloc.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_event.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_state.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/status/get_permission_status.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({super.key, this.onViewAppointmentsTap});

  final Function()? onViewAppointmentsTap;

  @override
  GoogleMapWidgetState createState() => GoogleMapWidgetState();
}

class GoogleMapWidgetState extends State<GoogleMapWidget> {
  // ignore: prefer_final_fields

  //var myMarkers = HashSet<Marker>();
  late LatLng currentPosition;
  late LatLng _center;
  late Position currentLocation;

  final searchController = TextEditingController();
  BitmapDescriptor? blackIcon;
  BitmapDescriptor? redIcon;
  int? markerFlag;

  @override
  void initState() {
    super.initState();
    currentLocation = Position.fromMap({'latitude': 25.27, 'longitude': 55.29});
    createBitmapIcon();
    context.read<MapBloc>().add(CheckLocationPermissionEvent());
    animateToCurrentLocation();
  }

  Future<void> animateToCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    if (_controller != null) {
      _controller!.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(position.latitude, position.longitude), 16));
    }

    if (redIcon == null) {
      return;
    }
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    setState(() {
      final address = placeMarks.firstOrNull;
      searchController.text = '${address?.locality} - ${address?.street}';

      _marker.add(
        Marker(
            markerId: const MarkerId('currentLocation'),
            infoWindow: const InfoWindow(title: 'Current Position'),
            position: LatLng(position.latitude, position.longitude),
            icon: redIcon!),
      );
      if (blackIcon == null) {
        return;
      }
      generateFakeLocation(position);
    });
  }

  void generateFakeLocation(Position position) {
    for (int i = 0; i < 5; i++) {
      final rand = Random().nextDouble() * 0.011;
      final rand2 = Random().nextDouble() * 0.001;
      _marker.add(
        Marker(
            markerId: MarkerId('patientLocation$i'),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  barrierColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(0.0)),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: 186.h,
                      child: Padding(
                        // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (widget.onViewAppointmentsTap != null) {
                                  widget.onViewAppointmentsTap!();
                                }
                              },
                              child: CustomContainer(
                                height: 40.h,
                                margin: EdgeInsets.symmetric(horizontal: 64.h),
                                borderRadius: BorderRadius.circular(50),
                                color: OnlineClinicColorStyle.dark,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'View appointments in a list',
                                      textStyle:
                                          Theme.of(context).textTheme.bodyLarge,
                                      textFontWight: TextFontWight.medium,
                                      textColor: OnlineClinicColorStyle.white,
                                    ),
                                    Gap(16.w),
                                    const CustomImage(
                                      imageSvgPath:
                                          'images/svg/arrow_right.svg',
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Gap(16.h),
                            Expanded(
                              child: CustomContainer(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 4),
                                color: OnlineClinicColorStyle.white,
                                child: Row(
                                  children: [
                                    CustomImage(
                                      imageHeight: 80.h,
                                      imageWidth: 60.w,
                                      imagePngOrJpgPath: 'images/doctor.png',
                                    ),
                                    Gap(8.w),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: 'Emma Johnson',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                          textFontWight: TextFontWight.bold,
                                          textColor:
                                              OnlineClinicColorStyle.dark,
                                        ),
                                        Gap(8.h),
                                        Row(
                                          children: [
                                            CustomImage(
                                              imageWidth: 15.w,
                                              imageHeight: 15.h,
                                              imageSvgPath:
                                                  'images/svg/archive_book.svg',
                                            ),
                                            CustomText(
                                              text: 'Dr. John William',
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textColor: OnlineClinicColorStyle
                                                  .lightGray,
                                            )
                                          ],
                                        ),
                                        Gap(8.h),
                                        Row(
                                          children: [
                                            CustomImage(
                                              imageWidth: 15.w,
                                              imageHeight: 15.h,
                                              imageSvgPath:
                                                  'images/svg/calendar-tick.svg',
                                            ),
                                            CustomText(
                                              text: ' March 13, 2024, 10:00 AM',
                                              textStyle: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                              textColor: OnlineClinicColorStyle
                                                  .lightGray,
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: '1 day ago',
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                          textColor:
                                              OnlineClinicColorStyle.lightGray,
                                        ),
                                        Gap(24.h),
                                        AppButton(
                                          label: 'Accept',
                                          height: 32.h,
                                          backgroundColor:
                                              OnlineClinicColorStyle.primary,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            CustomContainer(
                              height: 8.h,
                              color: OnlineClinicColorStyle.white,
                            ),
                            CustomContainer(
                              color: OnlineClinicColorStyle.white,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Row(
                                children: [
                                  const CustomImage(
                                    imageWidth: 15,
                                    imageHeight: 15,
                                    imageSvgPath: 'images/svg/location.svg',
                                  ),
                                  Gap(4.w),
                                  CustomText(
                                    text:
                                        'Villa 123, Street 24m, Community A Dubai, United Arab Emirates',
                                    textStyle:
                                        Theme.of(context).textTheme.labelLarge,
                                    textFontWight: TextFontWight.regular,
                                    textColor: OnlineClinicColorStyle.lightGray,
                                  ),
                                ],
                              ),
                            ),
                            CustomContainer(
                              height: 8.h,
                              color: OnlineClinicColorStyle.white,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            position:
                LatLng(position.latitude + rand, position.longitude + rand2),
            icon: blackIcon!),
      );
    }
  }

  Future<void> createBitmapIcon() async {
    blackIcon = await Utils.getBitmapDescriptorFromSvgAsset(
        'images/svg/location.svg', const Size(25, 25));
    redIcon = await Utils.getBitmapDescriptorFromSvgAsset(
      'images/svg/patient_location.svg',
      const Size(50, 50),
    );
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
    debugPrint('center: $_center');
  }

  GoogleMapController? _controller;
  final Set<Marker> _marker = {};

  @override
  Widget build(BuildContext context) {
    // var myMarkers;
    return CustomContainer(
      borderRadius: BorderRadius.circular(16),
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
            return Stack(clipBehavior: Clip.hardEdge, children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation.latitude, currentLocation.longitude),
                  zoom: 17,
                ),
                zoomControlsEnabled: false,
                compassEnabled: true,
                trafficEnabled: true,
                onTap: (position) async {
                  if (redIcon == null) {
                    return;
                  }

                  List<Placemark> placeMarks = await placemarkFromCoordinates(
                      position.latitude, position.longitude);

                  setState(() {
                    final address = placeMarks.firstOrNull;
                    searchController.text =
                        '${address?.locality} - ${address?.street}';
                    _marker.add(
                      Marker(
                        markerId: const MarkerId(
                          'currentLocation',
                        ),
                        infoWindow: const InfoWindow(
                          title: 'Current Position',
                        ),
                        position: LatLng(position.latitude, position.longitude),
                        icon: redIcon!,
                      ),
                    );
                  });
                },
                onMapCreated: (GoogleMapController mapController) async {
                  _controller = mapController;
                  if (redIcon != null) {
                    setState(() {
                      _marker.add(
                        Marker(
                          markerId: const MarkerId('currentLocation'),
                          infoWindow:
                              const InfoWindow(title: 'Current Position'),
                          position: LatLng(
                            currentLocation.latitude,
                            currentLocation.longitude,
                          ),
                          icon: redIcon!,
                        ),
                      );
                    });
                  }
                },
                markers: _marker,
              ),
              const Positioned(
                right: 8,
                left: 8,
                top: 16,
                child: Column(
                  children: [],
                ),
              ),
              Positioned(
                right: 16.w,
                bottom: 170.h,
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: FloatingActionButton(
                    backgroundColor: OnlineClinicColorStyle.gray2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.r)),
                    child: CustomImage(
                      imageWidth: 30.w,
                      imageHeight: 30.h,
                      svgColor: OnlineClinicColorStyle.white,
                      imageSvgPath: 'images/svg/gps.svg',
                    ),
                    onPressed: () async {
                      final position = await Geolocator.getCurrentPosition();
                      if (_controller == null) {
                        return;
                      }
                      _controller!.animateCamera(
                        CameraUpdate.newLatLngZoom(
                          LatLng(position.latitude, position.longitude),
                          16,
                        ),
                      );
                      if (redIcon == null) {
                        return;
                      }
                      List<Placemark> placeMarks =
                          await placemarkFromCoordinates(
                        position.latitude,
                        position.longitude,
                      );

                      setState(() {
                        final address = placeMarks.firstOrNull;
                        searchController.text =
                            '${address?.locality} - ${address?.street}';
                        _marker.add(
                          Marker(
                            markerId: const MarkerId('currentLocation'),
                            infoWindow:
                                const InfoWindow(title: 'Current Position'),
                            position: LatLng(
                              currentLocation.latitude,
                              currentLocation.longitude,
                            ),
                            icon: redIcon!,
                          ),
                        );
                      });
                    },
                  ),
                ),
              ),
            ]);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
