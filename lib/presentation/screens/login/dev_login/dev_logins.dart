// ignore_for_file: unused_import

import 'package:somi/core/environment.dart';
import 'package:somi/presentation/screens/login/dev_login/dev_login.dart';

/// A list of development logins that will appear as quick login options on the LoginScreen. This list should
/// always remain empty in version control, and any changes to this file should NOT be committed.
///
/// To use this file and add your own credentials, run this command to have git ignore your local changes:
/// git update-index --skip-worktree lib/login/dev_login/dev_logins.dart
///
/// If for some reason you need git to resume tracking local changes to this file, run this command:
/// git update-index --no-skip-worktree lib/login/dev_login/dev_logins.dart
const List<DevLogin> devLogins = [
  // Example entry:
  //
  // DevLogin(
  //   username: 'username',
  //   password: 'pass',
  //   environmentType: AppEnvironmentType.staging, // A login with a null value here will show in all environments
  // ),
];
