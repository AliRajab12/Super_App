import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/theme/text_styles.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_bloc.dart';
import 'package:somi/presentation/screens/home/bloc/home_screen_state.dart';
import 'package:somi/presentation/screens/somidashboard/screens/somihomedetailscreen.dart';
import 'package:somi/presentation/screens/somidashboard/screens/somirecentlyrented.dart';
import 'card_list_shimmer.dart';

class TopSellerWidget extends StatelessWidget {
  const TopSellerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
        bloc: locator(),
        builder: (context, state) {
          if (state.topSellerloading) {
            return const CardListShimmer();
          } else if (state.topCarSeller.isNotEmpty) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.v),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Top Sellers',
                        style: kSectionTitle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SomiRecentlyRented(
                                cars: state.topCarSeller,
                              ),
                            ),
                          );
                        },
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
                      itemCount: state.topCarSeller.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (ctx, i) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SomiHomeDetailScreen(
                                    name: state.topCarSeller[i].name,
                                    brand: state.topCarSeller[i].brand,
                                    imageUrl: state.topCarSeller[i].imageUrl,
                                    description:
                                        state.topCarSeller[i].description,
                                    speed: state.topCarSeller[i].speed,
                                    seats: state.topCarSeller[i].seats,
                                    engine: state.topCarSeller[i].engine,
                                    price: state.topCarSeller[i].price,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                                width: size.width * 0.6,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade300,
                                          blurRadius: 3,
                                          spreadRadius: 0.2)
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          height: 150,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.grey.shade200),
                                          child: Center(
                                            child: Hero(
                                              tag: state
                                                  .topCarSeller[i].imageUrl,
                                              child: Image.asset(
                                                state.topCarSeller[i].imageUrl,
                                                scale: 1.5,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        height: 10.v,
                                      ),
                                      Text(
                                        state.topCarSeller[i].name,
                                        style: kService,
                                      ),
                                      SizedBox(
                                        height: 6.v,
                                      ),
                                      Text(
                                        state.topCarSeller[i].speed,
                                        style: kService.copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: Colors.grey),
                                      ),
                                      SizedBox(
                                        height: 6.v,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color:
                                                Colors.yellow.withOpacity(0.7),
                                          ),
                                          SizedBox(
                                            width: 3.v,
                                          ),
                                          Text(state.topCarSeller[i].stars,
                                              style: kService.copyWith(
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10.v,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color?>(
                                                        (Set<MaterialState>
                                                            states) {
                                              return AppColors.primary
                                                  .withOpacity(0.6);
                                            }),
                                          ),
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SomiHomeDetailScreen(
                                                name:
                                                    state.topCarSeller[i].name,
                                                brand:
                                                    state.topCarSeller[i].brand,
                                                imageUrl: state
                                                    .topCarSeller[i].imageUrl,
                                                description: state
                                                    .topCarSeller[i]
                                                    .description,
                                                speed:
                                                    state.topCarSeller[i].speed,
                                                seats:
                                                    state.topCarSeller[i].seats,
                                                engine: state
                                                    .topCarSeller[i].engine,
                                                price:
                                                    state.topCarSeller[i].price,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            state.topCarSeller[i].price,
                                            style: kPrice.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                                // child: Column(
                                //   children: [
                                //     Container(
                                //       child: Center(
                                //         child: Hero(
                                //           tag: state.topCarSeller[i].imageUrl,
                                //           child: Image.asset(
                                //             state.topCarSeller[i].imageUrl,
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
                                //               state.topCarSeller[i].name,
                                //               style: kService,
                                //             ),
                                //             const SizedBox(height: 4),
                                //             Row(
                                //               children: [
                                //                 Image.asset('images/star.png'),
                                //                 const SizedBox(width: 4),
                                //                 Text(
                                //                   state.topCarSeller[i].stars,
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
                                //     //     tag: state.topCarSeller[i].imageUrl,
                                //     //     child: Image.asset(
                                //     //       state.topCarSeller[i].imageUrl,
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
                                //               state.topCarSeller[i].price,
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
