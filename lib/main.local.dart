import 'package:somi/core/environment.dart';
import 'package:somi/core/init.dart';

void main() async {
  initApp(
    env: const AppEnvironment(
      environmentType: AppEnvironmentType.local,
      accountType: '',
      somiApiUrl: '',
      allowUsernameLogin: false,
    ),
  );
}
