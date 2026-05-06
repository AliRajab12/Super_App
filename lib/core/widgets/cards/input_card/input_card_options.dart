import 'package:somi/core/widgets/cards/input_card/input_card.dart';
import 'package:flutter/cupertino.dart';

class InputCardOptions extends InheritedWidget {
  final Map<InputActionType, InputAction>? actions;
  final Map<InputActionType, InputAction?>? actionOverrides;

  final Map<InputActionType, InputAction>? menuActions;
  final Map<InputActionType, InputAction?>? menuActionOverrides;

  const InputCardOptions({
    super.key,
    this.actions,
    this.actionOverrides,
    this.menuActions,
    this.menuActionOverrides,
    required super.child,
  })  : assert(
          actions == null || actionOverrides == null,
          'Cannot specify both actions and actionOverrides',
        ),
        assert(
          menuActions == null || menuActionOverrides == null,
          'Cannot specify both menuActions and menuActionOverrides',
        );

  static InputCardOptions? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<InputCardOptions>();
  }

  @override
  bool updateShouldNotify(covariant InputCardOptions oldWidget) {
    return actions != oldWidget.actions ||
        actionOverrides != oldWidget.actionOverrides ||
        menuActions != oldWidget.menuActions ||
        menuActionOverrides != oldWidget.menuActionOverrides;
  }
}
