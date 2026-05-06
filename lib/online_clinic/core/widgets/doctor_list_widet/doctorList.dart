import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:somi/online_clinic/core/widgets/doctor_list_widet/doctor_item.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/doctor_entity.dart';

class DoctorList extends StatelessWidget {
  const DoctorList({super.key ,this.canScroll = true ,required this.doctorList , this.onTapBookButton , this.onTapCard , required this.showBookButton , this.usePadding = true, this.controller});
  final List<DoctorEntity> doctorList ;
  final GestureTapCallback? onTapCard;
  final GestureTapCallback? onTapBookButton;
  final bool showBookButton;
  final bool usePadding;
  final ScrollController? controller;
  final bool canScroll;

  @override
  Widget build(BuildContext context) {
    return   Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: doctorList.length,
          controller: controller,
          padding: EdgeInsets.symmetric(horizontal: 16.w),

          physics: canScroll?  const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
          itemBuilder: (context , index){
            return DoctorItem(
              showBookButton: showBookButton,
              usePadding: usePadding,
              doctorEntity: doctorList[index],
              onTapCard: onTapCard,
              onTapBookButton: onTapBookButton,
            );

          }),
    );
  }
}
