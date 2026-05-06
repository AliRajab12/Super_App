enum AppEnvironmentType { production, release, beta, staging, local }

class AppEnvironment {
  final AppEnvironmentType environmentType;
  final String accountType;
  final String somiApiUrl;
  final String knowledgeCenterUrl;
  final bool allowUsernameLogin;

  const AppEnvironment({
    required this.environmentType,
    required this.accountType,
    required this.somiApiUrl,
    this.knowledgeCenterUrl =
        '',
    this.allowUsernameLogin = true,
  });

  bool get isProd => environmentType == AppEnvironmentType.production;

  bool get isRelease => environmentType == AppEnvironmentType.release;

  bool get isBeta => environmentType == AppEnvironmentType.beta;

  bool get isStaging => environmentType == AppEnvironmentType.staging;

  bool get isLocal => environmentType == AppEnvironmentType.local;
}

class ClientConfig {
  final String id;
  final String secret;

  const ClientConfig({required this.id, required this.secret});
}
