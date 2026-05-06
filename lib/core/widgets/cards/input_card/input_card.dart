import 'package:collection/collection.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card_button.dart';
import 'package:somi/core/widgets/cards/input_card/input_card_options.dart';
import 'package:somi/core/widgets/cards/input_card/input_metadata.dart';
import 'package:somi/core/widgets/cards/input_card/input_reason_for_display.dart';
import 'package:somi/core/widgets/cards/input_card/input_thumbnail.dart';
import 'package:somi/core/widgets/dg_badge.dart';
import 'package:somi/core/widgets/markdown/degreed_markdown.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Actions that can be taken on an Input card
enum InputActionType {
  complete(),
  incomplete(),
  save(),
  unsave(),
  takeaway(),
  recommend(),
  viewDetails(),
  //enroll,
  report(),
  addToPlan(),
  removeFromPlan(),
  dismiss(),
  follow(),
  search(),
  edit(),
  addToPathway(),
  removeFromPathway(),
  // externalCompletion,
  star();
  //clear;

  String label(BuildContext context) {
    switch (this) {
      case InputActionType.complete:
        return AppLocalizations.of(context)!.markComplete;
      case InputActionType.incomplete:
        return AppLocalizations.of(context)!.markIncomplete;
      case InputActionType.save:
        return AppLocalizations.of(context)!.save;
      case InputActionType.unsave:
        return AppLocalizations.of(context)!.removeFromSaved;
      case InputActionType.takeaway:
        return AppLocalizations.of(context)!.takeaways;
      case InputActionType.recommend:
        return AppLocalizations.of(context)!.recommend;
      case InputActionType.viewDetails:
        return AppLocalizations.of(context)!.viewDetails;
      case InputActionType.report:
        return AppLocalizations.of(context)!.reportAProblem;
      case InputActionType.addToPlan:
        return AppLocalizations.of(context)!.addToTarget;
      case InputActionType.removeFromPlan:
        return AppLocalizations.of(context)!.removeFromTarget;
      case InputActionType.dismiss:
        return AppLocalizations.of(context)!.dismiss;
      case InputActionType.follow:
        return AppLocalizations.of(context)!.follow;
      case InputActionType.search:
        return AppLocalizations.of(context)!.search;
      case InputActionType.edit:
        return AppLocalizations.of(context)!.edit;
      case InputActionType.addToPathway:
        return AppLocalizations.of(context)!.addToPathway;
      case InputActionType.removeFromPathway:
        return AppLocalizations.of(context)!.removeFromPathway;
      case InputActionType.star:
        return AppLocalizations.of(context)!.addToFocusSkills;
    }
  }
}

enum InputActionIconVisibility { always, preferred }

enum InputActionLabelVisibility { always, preferred, never }

class InputAction {
  const InputAction(
    this.type,
    this.icon, {
    this.colorScheme,
    this.labelVisibility = InputActionLabelVisibility.never,
  });

  static const InputAction complete =
      InputAction(InputActionType.complete, Icons.check);
  static const InputAction incomplete =
      InputAction(InputActionType.incomplete, Icons.check);
  static const InputAction save =
      InputAction(InputActionType.save, Icons.bookmark);
  static const InputAction unsave =
      InputAction(InputActionType.unsave, Icons.bookmark);
  static const InputAction takeaway =
      InputAction(InputActionType.takeaway, Icons.edit_note);
  static const InputAction recommend =
      InputAction(InputActionType.recommend, Icons.recommend);
  static const InputAction viewDetails =
      InputAction(InputActionType.viewDetails, Icons.info);
  static const InputAction report =
      InputAction(InputActionType.report, Icons.report);
  static const InputAction addToPlan =
      InputAction(InputActionType.addToPlan, null);
  static const InputAction removeFromPlan =
      InputAction(InputActionType.removeFromPlan, null);
  static const InputAction dismiss =
      InputAction(InputActionType.dismiss, Icons.close);
  static const InputAction follow =
      InputAction(InputActionType.follow, Icons.add);
  static const InputAction search =
      InputAction(InputActionType.search, Icons.search);
  static const InputAction edit = InputAction(InputActionType.edit, Icons.edit);
  static const InputAction addToPathway =
      InputAction(InputActionType.addToPathway, null);
  static const InputAction removeFromPathway =
      InputAction(InputActionType.removeFromPathway, null);
  static const InputAction star = InputAction(InputActionType.star, null);

  final InputActionType type;
  final IconData? icon;
  final DGColorScheme? colorScheme;
  final InputActionLabelVisibility labelVisibility;
}

class InputCard extends StatelessWidget {
  const InputCard({Key? key, required this.input}) : super(key: key);

  final Input input;

  @override
  Widget build(BuildContext context) {
    String? title = input.title ?? input.reference?.title;
    String? summary = input.summary ?? input.reference?.summary;
    switch (input.inputType) {
      case 'Pathway':
        return buildPathwayCard(context, title, summary);
    }

    return DGCard(
      key: Key('input-${input.inputId}'),
      header: InputReasonForDisplay(input),
      thumbnail: InputThumbnail(input),
      metadata: buildMetadata(),
      title: buildTitle(title),
      summary: buildSummary(summary),
      buttons: _actionButtons(context),
      menuItems: _buildMenuItems(context),
    );
  }

  List<DGCardMenuItem> _buildMenuItems(BuildContext context) {
    return [
      if (input.isQueued == true)
        DGCardMenuItem(
          InputAction.unsave.type.label(context),
          () {},
        ),
      if (input.isQueued != true)
        DGCardMenuItem(
          InputAction.save.type.label(context),
          () {},
        ),
      DGCardMenuItem(
        InputAction.report.type.label(context),
        () => QuickNav.push(context, ReportAProblemScreen(input: input)),
      ),
      DGCardMenuItem(
        InputAction.recommend.type.label(context),
        () {},
      ),
    ];
  }

  Widget? buildMetadata() {
    if (InputMetadata.hasData(input)) return InputMetadata(input);
    return null;
  }

  Widget? buildTitle(String? title) {
    if (title == null || title.isEmpty) return null;
    return Text(title, maxLines: input.isPlan ? 1 : null);
  }

  Widget? buildSummary(String? summary) {
    if (summary == null || summary.isEmpty) return null;
    return StrippedMarkdown(data: summary);
  }

  List<Widget> _actionButtons(BuildContext context) {
    final options = InputCardOptions.of(context);
    Map<InputActionType, InputAction?> actions = options?.actions ??
        (input.inputType == 'Pathway'
            ? const {
                InputActionType.follow: InputAction.follow,
                InputActionType.viewDetails: InputAction.viewDetails,
              }
            : {
                if (input.isCompleted != true)
                  InputActionType.complete: InputAction.complete,
                if (input.isCompleted == true)
                  InputActionType.incomplete: InputAction.incomplete,
                InputActionType.takeaway: InputAction.takeaway,
                InputActionType.viewDetails: InputAction.viewDetails,
              });

    actions = Map.from(actions); // Create mutable copy

    if (options?.actionOverrides != null) {
      actions.addAll(options!.actionOverrides!);
    }

    return actions.values.whereNotNull().map((action) {
      DGColorScheme colorTheme = DGColorScheme.light;
      switch (action) {
        case InputAction.incomplete:
          colorTheme = DGColorScheme.appPrimary;
          break;
      }

      return DGCardButton(
        onPressed: () {},
        icon: action.icon,
        text: action.icon == null ? action.type.label(context) : null,
        iconSize: 18,
        colorTheme: colorTheme,
      );
    }).toList();
  }

  Widget buildPathwayCard(
      BuildContext context, String? title, String? summary) {
    Widget? badge;
    if (input.percentComplete != null) {
      badge = Row(
        children: [
          const SizedBox(width: 8),
          DGBadge(
            colorScheme: DGColorScheme.blue,
            slim: true,
            child: Text(
              AppLocalizations.of(context)!.percentComplete,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
    }
    return DGCard(
      key: Key('input-${input.inputId}'),
      header: InputReasonForDisplay(input),
      thumbnail: InputThumbnail(input),
      badge: badge,
      metadata: buildMetadata(),
      alwaysShowBadge: true,
      title: buildTitle(title),
      summary: buildSummary(summary),
      buttons: _actionButtons(context),
      menuItems: _buildMenuItems(context),
    );
  }
}
