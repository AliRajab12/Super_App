import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/core/widgets/doctor_list_widet/doctorList.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/pages/doctor_profile_page.dart';
import 'package:somi/online_clinic/core/widgets/doctor_list_widet/doctor_item.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/doctor_entity.dart';

class TopDoctorWidget extends StatelessWidget {
  TopDoctorWidget({super.key, this.controller , this.canScroll = true});
  final ScrollController? controller;
  final bool canScroll;
  List<DoctorEntity> doctorList = [
    DoctorEntity(
        name: 'DR. Amelia Rodriguez',
        imagePath: 'images/onine_clinic_png/doctor.png',
        score: '4.5 Reviews',
        experience: '6 years of experience',
        specialist: 'Dentist'
    ),
    DoctorEntity(
        name: 'DR. Amelia Rodriguez',
        imagePath: 'images/onine_clinic_png/doctor.png',
        score: '4.5 Reviews',
        experience: '6 years of experience',
        specialist: 'Dentist'
    ),
    DoctorEntity(
        name: 'DR. Amelia Rodriguez',
        imagePath: 'images/onine_clinic_png/doctor.png',
        score: '4.5 Reviews',
        experience: '6 years of experience',
        specialist: 'Dentist'
    ),
    DoctorEntity(
        name: 'DR. Amelia Rodriguez',
        imagePath: 'images/onine_clinic_png/doctor.png',
        score: '4.5 Reviews',
        experience: '6 years of experience',
        specialist: 'Dentist'
    ),


  ];



  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        // color: Colors.red,
        width: 1.sw,
        // padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

             const TitleWidget(
                title: 'Our top doctors',
                subtitle: 'Most booked doctors',
            ),
            Gap(24.h),
            DoctorList(
              doctorList: doctorList,
              showBookButton: false,
              usePadding:false,
              controller: controller,
              canScroll: canScroll,
              onTapCard: (){
                locator<MainRouter>().push(const DoctorProfilePageRoute()  );

              },
            ),

          ],
        ),
      ),
    );
  }
}
