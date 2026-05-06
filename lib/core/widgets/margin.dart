import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
 * Borrowed and modified from the source code of the Padding widget
 */

/// A widget that applies the specified [margin] to its [child]. Identical to [Padding] but allows negative values.
class Margin extends SingleChildRenderObjectWidget {
  /// Creates a widget that insets its child.
  ///
  /// The [margin] argument must not be null.
  const Margin({
    super.key,
    required this.margin,
    super.child,
  });

  /// The amount of space by which to inset the child.
  final EdgeInsetsGeometry margin;

  @override
  RenderMargin createRenderObject(BuildContext context) {
    return RenderMargin(
      margin: margin,
      textDirection: Directionality.maybeOf(context),
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderMargin renderObject) {
    renderObject
      ..margin = margin
      ..textDirection = Directionality.maybeOf(context);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin));
  }
}

class RenderMargin extends RenderShiftedBox {
  /// Creates a render object that insets its child.
  ///
  /// The [margin] argument must not be null.
  RenderMargin({
    required EdgeInsetsGeometry margin,
    TextDirection? textDirection,
    RenderBox? child,
  })  : _textDirection = textDirection,
        _margin = margin,
        super(child);

  EdgeInsets? _resolvedMargin;

  void _resolve() {
    if (_resolvedMargin != null) {
      return;
    }
    _resolvedMargin = margin.resolve(textDirection);
  }

  void _markNeedResolution() {
    _resolvedMargin = null;
    markNeedsLayout();
  }

  /// The amount to pad the child in each dimension.
  ///
  /// If this is set to an [EdgeInsetsDirectional] object, then [textDirection]
  /// must not be null.
  EdgeInsetsGeometry get margin => _margin;
  EdgeInsetsGeometry _margin;

  set margin(EdgeInsetsGeometry value) {
    if (_margin == value) {
      return;
    }
    _margin = value;
    _markNeedResolution();
  }

  /// The text direction with which to resolve [margin].
  ///
  /// This may be changed to null, but only after the [margin] has been changed
  /// to a value that does not depend on the direction.
  TextDirection? get textDirection => _textDirection;
  TextDirection? _textDirection;

  set textDirection(TextDirection? value) {
    if (_textDirection == value) {
      return;
    }
    _textDirection = value;
    _markNeedResolution();
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    _resolve();
    final double totalHorizontalMargin =
        _resolvedMargin!.left + _resolvedMargin!.right;
    final double totalVerticalMargin =
        _resolvedMargin!.top + _resolvedMargin!.bottom;
    if (child != null) {
      // Relies on double.infinity absorption.
      return child!
              .getMinIntrinsicWidth(max(0.0, height - totalVerticalMargin)) +
          totalHorizontalMargin;
    }
    return totalHorizontalMargin;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    _resolve();
    final double totalHorizontalMargin =
        _resolvedMargin!.left + _resolvedMargin!.right;
    final double totalVerticalMargin =
        _resolvedMargin!.top + _resolvedMargin!.bottom;
    if (child != null) {
      // Relies on double.infinity absorption.
      return child!
              .getMaxIntrinsicWidth(max(0.0, height - totalVerticalMargin)) +
          totalHorizontalMargin;
    }
    return totalHorizontalMargin;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    _resolve();
    final double totalHorizontalMargin =
        _resolvedMargin!.left + _resolvedMargin!.right;
    final double totalVerticalMargin =
        _resolvedMargin!.top + _resolvedMargin!.bottom;
    if (child != null) {
      // Relies on double.infinity absorption.
      return child!
              .getMinIntrinsicHeight(max(0.0, width - totalHorizontalMargin)) +
          totalVerticalMargin;
    }
    return totalVerticalMargin;
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    _resolve();
    final double totalHorizontalMargin =
        _resolvedMargin!.left + _resolvedMargin!.right;
    final double totalVerticalMargin =
        _resolvedMargin!.top + _resolvedMargin!.bottom;
    if (child != null) {
      // Relies on double.infinity absorption.
      return child!
              .getMaxIntrinsicHeight(max(0.0, width - totalHorizontalMargin)) +
          totalVerticalMargin;
    }
    return totalVerticalMargin;
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    _resolve();
    assert(_resolvedMargin != null);
    if (child == null) {
      return constraints.constrain(Size(
        _resolvedMargin!.left + _resolvedMargin!.right,
        _resolvedMargin!.top + _resolvedMargin!.bottom,
      ));
    }
    final BoxConstraints innerConstraints =
        constraints.deflate(_resolvedMargin!);
    final Size childSize = child!.getDryLayout(innerConstraints);
    return constraints.constrain(Size(
      _resolvedMargin!.left + childSize.width + _resolvedMargin!.right,
      _resolvedMargin!.top + childSize.height + _resolvedMargin!.bottom,
    ));
  }

  @override
  void performLayout() {
    final BoxConstraints constraints = this.constraints;
    _resolve();
    assert(_resolvedMargin != null);
    if (child == null) {
      size = constraints.constrain(Size(
        _resolvedMargin!.left + _resolvedMargin!.right,
        _resolvedMargin!.top + _resolvedMargin!.bottom,
      ));
      return;
    }
    final BoxConstraints innerConstraints =
        constraints.deflate(_resolvedMargin!);
    child!.layout(innerConstraints, parentUsesSize: true);
    final BoxParentData childParentData = child!.parentData! as BoxParentData;
    childParentData.offset =
        Offset(_resolvedMargin!.left, _resolvedMargin!.top);
    size = constraints.constrain(Size(
      _resolvedMargin!.left + child!.size.width + _resolvedMargin!.right,
      _resolvedMargin!.top + child!.size.height + _resolvedMargin!.bottom,
    ));
  }

  @override
  void debugPaintSize(PaintingContext context, Offset offset) {
    super.debugPaintSize(context, offset);
    assert(() {
      final Rect outerRect = offset & size;
      debugPaintPadding(context.canvas, outerRect,
          child != null ? _resolvedMargin!.deflateRect(outerRect) : null);
      return true;
    }());
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>('margin', margin));
    properties.add(EnumProperty<TextDirection>('textDirection', textDirection,
        defaultValue: null));
  }
}
