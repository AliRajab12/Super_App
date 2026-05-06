import 'package:somi/core/widgets/progress_bar.dart';
import 'package:flutter/widgets.dart';

class LinearLoadingIndicator extends StatelessWidget {
  const LinearLoadingIndicator(
    this.loading, {
    super.key,
    this.width = 64,
    this.height = 2,
    this.color,
    this.backgroundColor,
  });

  final bool loading;
  final double width;
  final double height;
  final Color? backgroundColor;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Center(
        child: AnimatedContainer(
          width: loading ? width : 0,
          duration: const Duration(milliseconds: 200),
          curve: loading ? Curves.easeOutCubic : Curves.easeInCubic,
          child: LinearProgressBar(
            minHeight: 2,
            value: loading ? null : 0,
            color: color,
            backgroundColor: backgroundColor,
          ),
        ),
      ),
    );
  }
}
