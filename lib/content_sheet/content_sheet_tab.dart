import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContentSheetTab extends StatefulWidget {
  const ContentSheetTab({Key? key}) : super(key: key);

  @override
  State<ContentSheetTab> createState() => _ContentSheetTabState();
}

class _ContentSheetTabState extends State<ContentSheetTab> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: AppLocalizations.of(context)!.skills),
                Tab(text: AppLocalizations.of(context)!.comments),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [Container(), Container()],
        ),
      ),
    );
  }
}
