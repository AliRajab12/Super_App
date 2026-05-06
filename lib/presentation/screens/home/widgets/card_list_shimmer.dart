import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:somi/core/theme/colors.dart';
import 'package:somi/core/utils/size_utils.dart';

class CardListShimmer extends StatelessWidget {
  const CardListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primary.withOpacity(0.03),
      highlightColor: AppColors.background,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(height: 20, width: 75, color: Colors.grey),
                Container(height: 20, width: 75, color: Colors.grey),
              ],
            ),
          ),
          SizedBox(
            height: 18.v,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.43,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (ctx, i) {
                  return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 0.6,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade300,
                                  blurRadius: 3,
                                  spreadRadius: 0.2)
                            ]),
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            height: 16.v,
          )
        ],
      ),
    );
  }
}
