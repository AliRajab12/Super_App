import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class LessonContentWebviewNew extends StatefulWidget {
  final String url;
  final String lessonTitle;

  const LessonContentWebviewNew(
      {Key? key, required this.url, required this.lessonTitle})
      : super(key: key);

  @override
  State<LessonContentWebviewNew> createState() =>
      _LessonContentWebviewNewState();
}

class _LessonContentWebviewNewState extends State<LessonContentWebviewNew> {
  double _progress = 0;
  late InAppWebViewController inAppWebViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();

        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: SafeArea(
        child: Scaffold(
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
              InAppWebView(
                initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
                onWebViewCreated: (InAppWebViewController controller) {
                  inAppWebViewController = controller;
                },
                onProgressChanged:
                    (InAppWebViewController controller, int progress) {
                  _progress = progress / 100;
                  if (_progress == 1) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
              ),
              isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Stack(),
            ],
          ),
        ),
      ),
    );
  }
}
