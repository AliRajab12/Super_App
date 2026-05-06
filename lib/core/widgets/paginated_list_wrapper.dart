import 'package:flutter/material.dart';

class PaginatedListWrapper extends StatelessWidget {
  final Widget child;
  final bool hasMorePages;
  final int threshold;
  final Function onNextPageRequested;

  final bool canRefresh;
  final Function onRefresh;

  const PaginatedListWrapper({
    super.key,
    this.threshold = 128,
    required this.hasMorePages,
    required this.onNextPageRequested,
    required this.canRefresh,
    required this.onRefresh,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollMetricsNotification>(
      onNotification: (n) {
        if (!hasMorePages) return true;

        final metrics = n.metrics;
        if (!metrics.hasViewportDimension || !metrics.hasViewportDimension)
          return true;

        bool shortList =
            metrics.viewportDimension > 0 && metrics.maxScrollExtent == 0;
        bool nearBottom = metrics.maxScrollExtent > 0 &&
            (metrics.pixels + threshold >= metrics.maxScrollExtent);

        if (shortList || nearBottom && hasMorePages) {
          onNextPageRequested();
        }

        return true;
      },
      child: RefreshIndicator(
        notificationPredicate: (_) => canRefresh,
        onRefresh: () async {
          onRefresh();
        },
        child: child,
      ),
    );
  }
}
