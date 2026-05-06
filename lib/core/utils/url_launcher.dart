import 'package:url_launcher/url_launcher.dart';

/// A wrapper around url_launcher for testability
class UrlLauncher {
  Future<bool> launch(
    String url, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) =>
      launchUrl(
        Uri.parse(url),
        mode: mode,
        webViewConfiguration: webViewConfiguration,
        webOnlyWindowName: webOnlyWindowName,
      );

  Future<bool> launchUri(
    Uri uri, {
    LaunchMode mode = LaunchMode.platformDefault,
    WebViewConfiguration webViewConfiguration = const WebViewConfiguration(),
    String? webOnlyWindowName,
  }) =>
      launchUrl(
        uri,
        mode: mode,
        webViewConfiguration: webViewConfiguration,
        webOnlyWindowName: webOnlyWindowName,
      );

  Future<bool> canLaunch(Uri url) => canLaunchUrl(url);
}
