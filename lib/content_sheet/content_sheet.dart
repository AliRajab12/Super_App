import 'package:somi/content_sheet/comments/comment_section.dart';
import 'package:somi/content_sheet/learning_status.dart';
import 'package:somi/content_sheet/skill_section.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somi/core/widgets/cards/input_card/input_thumbnail.dart';
import 'package:somi/core/widgets/collapsible_header.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ContentSheet extends StatefulWidget {
  /// Image thumbnail that will be displayed in a 16:9 aspect ratio using the full width of the card,
  /// placed at the top of the card but below the header (if any).
  final Input input;
  final ScrollController scrollController;

  /// Custom size constraints. Overrides any constraints specified by the the [format] or the inherited DGCardConfig
  final BoxConstraints? sizeConstraints;

  const ContentSheet(
      {super.key,
      required this.input,
      this.sizeConstraints,
      required this.scrollController});

  @override
  State<ContentSheet> createState() => _ContentSheetState();
}

class _ContentSheetState extends State<ContentSheet>
    with SingleTickerProviderStateMixin {
  late TabController _contentSheetTabController;

  @override
  void initState() {
    super.initState();
    _contentSheetTabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32), topRight: Radius.circular(32))),
      child: ListView(
        controller: widget.scrollController,
        children: [
          Center(
            child: Container(
              width: 32,
              height: 4,
              decoration: BoxDecoration(
                  color: AppColors.grayLight,
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(
              '${widget.input.inputType ?? ''}'
              ' • '
              '${widget.input.hostname ?? ''}',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
                constraints: const BoxConstraints.expand(height: 192),
                child: InputThumbnail(
                  widget.input,
                  cardThumbnail: false,
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Text(
                  '${widget.input.durationDisplay ?? widget.input.reference?.durationDisplay ?? ''} • ${widget.input.inputType ?? ''}',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: CollapsibleHeader(
              description: widget.input.summary ?? '',
              title: widget.input.title ?? '',
              titleStyle: Theme.of(context).textTheme.titleLarge,
              descriptionStyle: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: PrimaryButton.large(
              text: AppLocalizations.of(context)!.open,
              buttonTextStyle: context.textTheme.titleSmall!
                  .copyWith(color: SomiColors.ebonySolid3),
              expand: true,
              onPressed: () => {
                //TODO:add action here
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: LearningStatus(
              input: widget.input,
            ),
          ),
          TabBar(
            controller: _contentSheetTabController,
            indicatorWeight: 1.5,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: SomiColors.blue,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.skills),
              Tab(text: AppLocalizations.of(context)!.comments),
            ],
          ),
          SizedBox(
            height: 450,
            child: TabBarView(
              controller: _contentSheetTabController,
              children: [
                SkillSection(
                  input: widget.input,
                ),
                CommentSection(
                  input: widget.input,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget containerView(Color containerColor) {
    return Container(
      height: 100,
      color: containerColor,
    );
  }
}
