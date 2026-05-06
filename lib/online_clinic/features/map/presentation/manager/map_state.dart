
import 'package:somi/online_clinic/features/map/presentation/manager/status/get_permission_status.dart';

class MapState {
  final GetPermissionStatus permissionStatus;

  const MapState({required this.permissionStatus});

  MapState copyWith({GetPermissionStatus? newPermissionStatus}) {
    return MapState(permissionStatus: newPermissionStatus ?? permissionStatus);
  }
}
