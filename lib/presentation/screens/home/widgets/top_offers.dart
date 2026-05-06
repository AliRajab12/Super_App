import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_state.dart';

import 'card_list_shimmer.dart';

class TopOffers extends StatelessWidget {
  const TopOffers({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        bloc: locator(),
        builder: (context, state) {
          if (state.topOffersloading) {
            return const CardListShimmer();
          } else if (state.topOffers.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Offers',
                        style: kSectionTitle,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          'View all',
                          style: kViewAll,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 18.v,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: size.height * 0.43,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: state.topOffers.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                                width: 200,
                                height: 160,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 3,
                                          spreadRadius: 0.2)
                                    ]),
                                child: Hero(
                                  tag: state.topOffers[i].imageUrl,
                                  child: Image.asset(
                                    state.topOffers[i].imageUrl,
                                    fit: BoxFit.fill,
                                  ),
                                )
                                // child: Column(
                                //   children: [
                                //     Container(
                                //       child: Center(
                                //         child: Hero(
                                //           tag: state.topOffers[i].imageUrl,
                                //           child: Image.asset(
                                //             state.topOffers[i].imageUrl,
                                //             scale: 1.5,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //     Row(
                                //       crossAxisAlignment: CrossAxisAlignment.start,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Column(
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: [
                                //             Text(
                                //               state.topOffers[i].name,
                                //               style: kService,
                                //             ),
                                //             const SizedBox(height: 4),
                                //             Row(
                                //               children: [
                                //                 Image.asset('images/star.png'),
                                //                 const SizedBox(width: 4),
                                //                 Text(
                                //                   state.topOffers[i].stars,
                                //                   style: kRate.apply(
                                //                     color:
                                //                         kTextColor.withOpacity(0.6),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ],
                                //         ),
                                //         Container(
                                //           height: size.width * 0.1,
                                //           width: size.width * 0.1,
                                //           decoration: BoxDecoration(
                                //             color: kShadeColor,
                                //             borderRadius: BorderRadius.circular(8),
                                //           ),
                                //           child:
                                //               Image.asset('images/active-saved.png'),
                                //         ),
                                //       ],
                                //     ),
                                //     // const SizedBox(height: 20),
                                //     // Center(
                                //     //   child: Hero(
                                //     //     tag: state.topOffers[i].imageUrl,
                                //     //     child: Image.asset(
                                //     //       state.topOffers[i].imageUrl,
                                //     //       scale: 1.5,
                                //     //     ),
                                //     //   ),
                                //     // ),
                                //     // const SizedBox(height: 16),
                                //     Row(
                                //       mainAxisAlignment: MainAxisAlignment.start,
                                //       crossAxisAlignment: CrossAxisAlignment.center,
                                //       children: [
                                //         Image.asset('images/cost.png'),
                                //         const SizedBox(width: 8),
                                //         Row(
                                //           children: [
                                //             Text(
                                //               state.topOffers[i].price,
                                //               style: kPrice,
                                //             ),
                                //             Text(
                                //               '/week',
                                //               style: kPrice.copyWith(
                                //                 color: kTextColor.withOpacity(0.6),
                                //               ),
                                //             ),
                                //           ],
                                //         ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.v,
                )
              ],
            );
          } else {
            return const SizedBox.shrink();
          }
        });
  }
}
