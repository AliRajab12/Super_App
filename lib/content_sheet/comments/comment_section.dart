import 'package:somi/content_sheet/comments/comment_section_cubit.dart';
import 'package:somi/content_sheet/comments/comment_state.dart';
import 'package:somi/core/models/comments.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/service_locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:somi/core/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentSection extends StatefulWidget {
  final Input input;
  const CommentSection({super.key, required this.input});

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final cubit = locator<CommentsCubit>();
  TextEditingController commentController = TextEditingController();
  bool _isTextFieldTapped = false;
  List<Comments> comments = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: BlocBuilder<CommentsCubit, CommentState>(
        bloc: cubit,
        builder: (context, state) => buildBody(context, state),
      ),
    );
  }

  Widget buildBody(BuildContext context, CommentState state) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              '${AppLocalizations.of(context)!.comments}・0',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: CircleAvatar(
                  radius: 24.0,
                  backgroundImage:
                      AssetImage('images/illustrations/fever.png'),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: const BoxDecoration(
                      color: Color(0xFFe3e2e6),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(4.0),
                        topLeft: Radius.circular(4.0),
                      )),
                  child: TextField(
                    controller: commentController,
                    onSubmitted: (comment) {
                      // addComment(comment);
                    },
                    onChanged: (text) {
                      setState(() {
                        _isTextFieldTapped = text.isNotEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.commentHintText,
                      labelStyle:
                          Theme.of(context).textTheme.bodyMedium!.copyWith(
                                color: const Color(0xFF44464F),
                              ),
                      border: InputBorder.none,
                      hintText: AppLocalizations.of(context)!.commentHintText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _isTextFieldTapped
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isTextFieldTapped = false;
                        commentController.clear();
                      });
                    },
                    child: Text(AppLocalizations.of(context)!.cancel,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: SomiColors.blue)),
                  ),
                  const SizedBox(width: 12.0),
                  SizedBox(
                    width: 115,
                    height: 40,
                    child: PrimaryButton.small(
                      text: AppLocalizations.of(context)!.comment,
                      buttonTextStyle: context.textTheme.titleSmall!
                          .copyWith(color: SomiColors.ebonySolid3),
                      onPressed: () {
                        cubit.addComment(
                          commentController.text,
                          widget.input.inputType!,
                          widget.input.inputId!,
                        );
                      },
                    ),
                  ),
                ],
              )
            : const SizedBox(),
        const SizedBox(height: 10.0),
        Expanded(child: buildCommentListView(context))
      ],
    );
  }

  Widget buildCommentListView(BuildContext context) {
    return FutureBuilder(
      initialData: cubit.getComment(
          widget.input.inputType!,
          widget.input.inputId!,
          Localizations.localeOf(context).toLanguageTag()),
      future: cubit.getComment(widget.input.inputType!, widget.input.inputId!,
          Localizations.localeOf(context).toLanguageTag()),
      builder: (context, state) {
        if (comments.isEmpty) return buildCommentEmptyState(context);

        return ListView.builder(
          itemCount: comments.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 1,
              child: ListTile(
                minVerticalPadding: 25,
                leading: const CircleAvatar(
                  radius: 22.0,
                  backgroundImage:
                      AssetImage('images/illustrations/fever.png'),
                ),
                title: Text(
                  'User $index',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                subtitle: Text(
                  'comment 1',
                  // comments[index].feed[index].comment!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Today'), Icon(Icons.more_vert)],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Empty state for skills in content sheet.
  Widget buildCommentEmptyState(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: SizedBox(
              width: 326,
              height: 163,
              child: Image.asset('images/illustrations/megaphone.png')),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.noComments,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              AppLocalizations.of(context)!.noCommentsDescription,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ],
    );
  }
}
