import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_event.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/map_state.dart';
import 'package:somi/online_clinic/features/map/presentation/manager/status/get_permission_status.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState(permissionStatus: PermissionInit())) {
    on<CheckLocationPermissionEvent>((event, emit) {
      Permission.location.onDeniedCallback(() {
        emit(MapState(permissionStatus: PermissionDenied()));
        return;
      }).onGrantedCallback(() {
        emit(MapState(permissionStatus: PermissionGranted()));
        return;
      }).onPermanentlyDeniedCallback(() {
        emit(MapState(permissionStatus: PermissionDenied()));
        return;
      }).onRestrictedCallback(() {
        emit(MapState(permissionStatus: PermissionDenied()));
        return;
      }).onLimitedCallback(() {
        emit(MapState(permissionStatus: PermissionDenied()));
        return;
      }).onProvisionalCallback(() {});
      emit(MapState(permissionStatus: PermissionDenied()));
    });
    on<RequestLocationPermissionEvent>((event, emit) async {
      await Permission.location
          .onDeniedCallback(() {
            emit(MapState(permissionStatus: PermissionDenied()));
            return;
          })
          .onGrantedCallback(() {
            emit(MapState(permissionStatus: PermissionGranted()));
            return;
          })
          .onPermanentlyDeniedCallback(() {
            emit(MapState(permissionStatus: PermissionDenied()));
            return;
          })
          .onRestrictedCallback(() {
            emit(MapState(permissionStatus: PermissionDenied()));
            return;
          })
          .onLimitedCallback(() {
            emit(MapState(permissionStatus: PermissionDenied()));
            return;
          })
          .onProvisionalCallback(() {})
          .request();
    });
  }
}
