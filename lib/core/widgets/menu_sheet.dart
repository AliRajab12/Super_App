import 'dart:io';

import 'package:somi/core/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MenuSheetOption {
  final String label;
  final VoidCallback onTap;
  final IconData? icon;
  final bool isDestructive;

  MenuSheetOption(this.label, this.onTap,
      {this.icon, this.isDestructive = false});
}

Future<T?> showMenuSheet<T>(
  BuildContext context,
  List<MenuSheetOption> options, {
  String? title,
  bool canCancel = true,
  bool canDismiss = true,
  bool? forceCupertino,
}) async {
  if ((forceCupertino == null && Platform.isIOS) || forceCupertino == true) {
    return _showCupertinoMenuSheet(
      context,
      options,
      title,
      canCancel: canCancel,
      canDismiss: canDismiss,
    );
  } else {
    return _showMaterialMenuSheet(
      context,
      options,
      title,
      canDismiss: canDismiss,
    );
  }
}

Future<T?> _showCupertinoMenuSheet<T>(
  BuildContext context,
  List<MenuSheetOption> options,
  String? title, {
  bool canCancel = true,
  bool canDismiss = true,
}) {
  return showCupertinoModalPopup(
    context: context,
    barrierDismissible: canDismiss,
    builder: (BuildContext context) {
      bool anyHasIcon = options.any((option) => option.icon != null);
      return CupertinoActionSheet(
        title: title == null ? null : Text(title),
        actions: options.map((option) {
          return CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              option.onTap();
            },
            isDestructiveAction: option.isDestructive,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      option.label,
                      textAlign: anyHasIcon ? TextAlign.left : TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  if (option.icon != null) Icon(option.icon!, size: 16),
                ],
              ),
            ),
          );
        }).toList(),
        cancelButton: canCancel
            ? CupertinoActionSheetAction(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppLocalizations.of(context)!.cancel,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            : null,
      );
    },
  );
}

Future<T?> _showMaterialMenuSheet<T>(
  BuildContext context,
  List<MenuSheetOption> options,
  String? title, {
  bool canDismiss = true,
}) {
  return showModalBottomSheet<T>(
    context: context,
    elevation: 0,
    isDismissible: canDismiss,
    enableDrag: canDismiss,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ),
    ),
    builder: (BuildContext context) {
      bool anyHasIcon = options.any((option) => option.icon != null);
      return WillPopScope(
        onWillPop: () async => canDismiss,
        child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (title != null)
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 8),
                    child: Text(title,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                if (title == null) const SizedBox(height: 8),
                ...options.map<Widget>((option) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).pop();
                      option.onTap();
                    },
                    minLeadingWidth: 24,
                    leading: anyHasIcon
                        ? (option.icon == null
                            ? const SizedBox(width: 16)
                            : SizedBox(
                                height: double.infinity,
                                child: Icon(option.icon!, size: 16)))
                        : null,
                    title: Padding(
                      padding: anyHasIcon
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(left: 16),
                      child: Text(option.label,
                          style: const TextStyle(fontSize: 14)),
                    ),
                  );
                }).toList(),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      );
    },
  );
}
