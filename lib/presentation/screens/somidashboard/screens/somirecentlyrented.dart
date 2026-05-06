import 'package:flutter/material.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/core/theme/text_styles.dart';

class SomiRecentlyRented extends StatefulWidget {
  final List<Car> cars;

  const SomiRecentlyRented({Key? key, required this.cars}) : super(key: key);

  @override
  SomiRecentlyRentedState createState() => SomiRecentlyRentedState();
}

class SomiRecentlyRentedState extends State<SomiRecentlyRented> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: size.width * 0.1,
                    width: size.width * 0.1,
                    margin: const EdgeInsets.fromLTRB(16, 20, 0, 18),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Image.asset('images/back-arrow.png'),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Top Sellers', style: kCarTitle),
                  SizedBox(height: 13.v),
                  SizedBox(
                    height: size.height * 0.9,
                    child: ListView.builder(
                      itemCount: widget.cars.length,
                      itemBuilder: (ctx, i) {
                        return Container(
                          height: size.height * 0.70.v,
                          width: size.width - 32,
                          margin: EdgeInsets.only(bottom: 20.v, top: 24.v),
                          padding: const EdgeInsets.fromLTRB(16, 32, 8, 10),
                          decoration: BoxDecoration(
                            color: kShadeColor.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.cars[i].name,
                                        style: kService,
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Image.asset('images/star.png'),
                                          const SizedBox(width: 4),
                                          Text(
                                            widget.cars[i].stars,
                                            style: kRate.apply(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: size.width * 0.1,
                                    width: size.width * 0.1,
                                    decoration: BoxDecoration(
                                      color: kShadeColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child:
                                        Image.asset('images/active-saved.png'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Center(
                                child: Hero(
                                  tag: widget.cars[i].imageUrl,
                                  child: Image.asset(
                                    widget.cars[i].imageUrl,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/cost.png',
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Cost',
                                            style: kCarDetails.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.cars[i].price,
                                        style: kCarDetails.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/date.png',
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Start Date',
                                            style: kCarDetails.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.cars[i].date,
                                        style: kCarDetails.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            'images/cost.png',
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Duration',
                                            style: kCarDetails.copyWith(
                                              color:
                                                  kTextColor.withOpacity(0.6),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        widget.cars[i].duration,
                                        style: kCarDetails.copyWith(
                                            color: kTextColor),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        '(${widget.cars[i].price}/week)',
                                        style: kCarDetails.copyWith(
                                            color: kTextColor.withOpacity(0.6)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
