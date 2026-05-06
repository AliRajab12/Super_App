import 'package:somi/core/models/org_announcement.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/core/widgets/cards/dg_card/dg_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SomiBannerCard extends StatefulWidget {
  final OrgAnnouncement? orgAnnouncement;

  const SomiBannerCard({
    Key? key,
    required this.orgAnnouncement,
  }) : super(key: key);

  @override
  State<SomiBannerCard> createState() => _SomiBannerCardState();
}

class _SomiBannerCardState extends State<SomiBannerCard> {
  bool dismissAnnouncement = false;
  @override
  Widget build(BuildContext context) {
    DGCardConfig config = DGCardConfig.of(context);

    return dismissAnnouncement
        ? Container()
        : Padding(
            padding: config.margin ?? config.format.margin,
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              ),
              color: const Color(0xfffcf8fd),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          constraints: BoxConstraints.expand(height: 300.v),
                          child: announcementThumbnail(),
                        ),

                        /// Button bar
                        /*IconButton(
                            onPressed: () {
                              setState(() {
                                //dismissAnnouncement = true;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color(0xff44464F),
                            ))*/
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              widget.orgAnnouncement?.title ??
                                  AppLocalizations.of(context)!
                                      .somiBannnerTitle,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              widget.orgAnnouncement?.description ??
                                  'Luxury car available for great rental price. Hurry and explore UAE today with a great ride.',
                              maxLines: 3,
                              style: Theme.of(context).textTheme.bodyMedium,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: GestureDetector(
                        onTap: () {
                          // TODO: To Add announcement launch screen
                        },
                        child: Text(
                          AppLocalizations.of(context)!.takemethere,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Widget announcementThumbnail() {
    return Container(
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFe9f5f3),
              Color(0xFFf6eee3),
              Color(0xFFf7e4ed),
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(16.v))),
      child: Center(
        child: Hero(
          tag: 'item.cars[i].imageUrl',
          child: Image.asset(
            'images/somicar1.png',
            scale: 1.5,
          ),
        ),
      ),
    );
  }
}
