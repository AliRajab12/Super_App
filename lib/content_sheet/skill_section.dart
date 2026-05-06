import 'package:somi/core/models/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkillSection extends StatelessWidget {
  final Input input;
  const SkillSection({super.key, required this.input});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: (input.skill?.isNotEmpty == true)
          ? skillChip(context)
          : buildSkillEmptyState(context),
    );
  }

  /// Skill chip
  Widget skillChip(BuildContext context) {
    String skillTag = input.skill!;

    List<String>? skillList = skillTag.split(',');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            AppLocalizations.of(context)!.skills,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              Wrap(
                spacing: 4.0,
                runSpacing: 6.0,
                children: skillList.map((skill) {
                  return Chip(
                    backgroundColor: const Color(0xFFDCE2F9),
                    side: BorderSide.none,
                    label: Text(
                      skill,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Empty state for skills in content sheet.
  Widget buildSkillEmptyState(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '${AppLocalizations.of(context)!.skills}・0',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: SizedBox(
                  width: 326,
                  height: 163,
                  child: Image.asset('images/illustrations/puzzle-cube.png')),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  AppLocalizations.of(context)!.noSkills,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  AppLocalizations.of(context)!.noSkillsDescription,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
