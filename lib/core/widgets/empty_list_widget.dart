import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/empty_header_widget.dart';
import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    Key? key,
    required this.onRefresh,
    this.refreshKey,
    this.scrollController,
    this.title,
    this.message,
    this.imageAssetPath,
    this.contentKey,
    this.action,
    this.headerTitle,
    this.headerMessage,
  }) : super(key: key);

  final String? title;
  final String? message;
  final String? headerTitle;
  final String? headerMessage;
  final String? imageAssetPath;
  final Future<void> Function() onRefresh;
  final GlobalKey<RefreshIndicatorState>? refreshKey;
  final ScrollController? scrollController;
  final Key? contentKey;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return RefreshIndicator(
          key: refreshKey,
          onRefresh: onRefresh,
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  key: contentKey,
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: headerTitle?.isBlank == false
                              ? 360
                              : constraints.maxHeight,
                          maxWidth: 480,
                        ),
                        child: _buildContent(context),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Padding _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (headerTitle?.isBlank == false)
            EmptyHeaderWidget(
                headerTitle: headerTitle, headerMessage: headerMessage),
          if (imageAssetPath?.isBlank == false)
            Image.asset(imageAssetPath!, width: 240),
          const SizedBox(height: 36),
          if (title?.isBlank == false)
            Text(
              title!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          const SizedBox(height: 4),
          if (message?.isBlank == false)
            Text(message!, textAlign: TextAlign.center),
          if (action != null)
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: action!,
            ),
        ],
      ),
    );
  }
}
