import 'package:equatable/equatable.dart';

abstract class GetPermissionStatus extends Equatable {}

class PermissionInit extends GetPermissionStatus {
  @override
  List<Object?> get props => [];
}

class PermissionLoading extends GetPermissionStatus {
  @override
  List<Object?> get props => [];
}

class PermissionGranted extends GetPermissionStatus {
  @override
  List<Object?> get props => [];

  PermissionGranted();
}

class PermissionDenied extends GetPermissionStatus {
  @override
  List<Object?> get props => [];
}
