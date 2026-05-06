import 'package:somi/core/models/input.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:somi/core/widgets/cards/input_card/input_card.dart';
import 'package:somi/core/widgets/menu_sheet.dart';
import 'package:somi/core/widgets/report_a_problem/report_a_problem_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearningStatus extends StatelessWidget {
  final Input input;
  const LearningStatus({
    required this.input,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(
      width: 8,
    );
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: GestureDetector(
          onTap: () {
            //TODO:add action here
          },
          child: Container(
            width: 206,
            height: 40,
            decoration: const BoxDecoration(
                color: Color(0xFFDCE2F9),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.check,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  AppLocalizations.of(context)!.markComplete,
                  style: context.textTheme.titleSmall,
                )
              ],
            ),
          ),
        )),
        gap,
        _IconButton(
          iconData: Icons.bookmark_border,
          onTap: () => {
            //TODO:add action here
          },
        ),
        gap,
        _IconButton(
          iconData: Icons.more_vert,
          onTap: () => {
            showMenuSheet(
              context,
              _buildMenuItems(context)
                  .map((item) => MenuSheetOption(
                        item.label,
                        item.onTap,
                        isDestructive: item.isDestructive,
                      ))
                  .toList(),
            )
          },
        ),
      ],
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
        InputAction.addToPlan.type.label(context),
        () {},
      ),
      DGCardMenuItem(
        InputAction.report.type.label(context),
        () => QuickNav.push(context, ReportAProblemScreen(input: input)),
      ),
      DGCardMenuItem(
        InputAction.addToPathway.type.label(context),
        () {},
      ),
      DGCardMenuItem(
        InputAction.recommend.type.label(context),
        () {},
      ),
    ];
  }
}

class _IconButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onTap;

  const _IconButton({required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: const Color(0xFFDCE2F9),
            borderRadius: BorderRadius.circular(20)),
        alignment: Alignment.center,
        child: Icon(
          iconData,
          size: 24,
          color: const Color(0xFF151B2C),
        ),
      ),
    );
  }
}
