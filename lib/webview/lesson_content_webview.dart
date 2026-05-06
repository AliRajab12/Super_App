import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LessonContentWebview extends StatefulWidget {
  final String url;
  final String lessonTitle;
  const LessonContentWebview(
      {super.key, required this.url, required this.lessonTitle});

  @override
  State<LessonContentWebview> createState() => _LessonContentWebviewState();
}

class _LessonContentWebviewState extends State<LessonContentWebview> {
  late final WebViewController controller;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (finish) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          widget.lessonTitle,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: controller,
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const Stack(),
        ],
      ),
    );
  }
}
