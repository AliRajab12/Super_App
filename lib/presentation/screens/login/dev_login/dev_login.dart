import 'package:somi/core/environment.dart';

/// Represents a development login that can be used for quick login when the app is built locally
class DevLogin {
  const DevLogin({
    required this.username,
    required this.password,
    this.environmentType,
  });

  final String username;
  final String password;

  /// The app environment type in which this login should be displayed.
  /// If null, the login will be displayed in all environment types.
  final AppEnvironmentType? environmentType;
}
