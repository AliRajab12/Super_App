import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_appbar/content_home_large_appbar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/title_widget.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/domain/entities/appointment_prioriy_type_enum.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/widgets/categoryWidget.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/widgets/top_doctor_widget.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/presentation/widgets/appointment_card_widget.dart';
import 'package:somi/online_clinic/features/user_home_feature/presentation/widget/diseaseCategoryList.dart';

@RoutePage()
class UserHomePage extends StatelessWidget {
  UserHomePage({super.key});

  static const route = '/userHomePage';

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return CustomBody(
        contentLargeAppBar: ContentHomeLargeAppBar(),
        child: SingleChildScrollView(
          controller: scrollController,
          child: SizedBox(
            height: 1.2.sh,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Gap(32.h),
                const TitleWidget(
                  title: 'Disease categories',
                  subtitle: 'Choose your disease or medical condition ',
                ),
                // Gap(24.h),

                DiseaseCategoryList(),
                // Gap(40.h),
                TitleWidget(
                  title: 'My appointments',
                  subtitle: 'Track your scheduled appointments',
                  onTapSeeAll: () {
                    locator<MainRouter>()
                        .push(const UserAppointmentListPageRoute());
                  },
                ),

                Gap(24.h),
                TodaysAppointmentCardWidget(
                  appointment: AppointmentEntity(
                    firstName: 'jamshid',
                    lastName: 'jamshid',
                    avatar: 'images/onine_clinic_png/doctor.png',
                    appointmentDate: DateTime.now(),
                    appointmentPriorityTypeEnum: AppointmentPriorityTypeEnum.urgent,
                    expertise: 'jarrah',
                  ),
                  makeCallTap: () {
                    CallClass().joinMeeting(
                      context: context,
                      roomName: Constants.callRoomName,
                    );
                  },
                  checkupTap: () {},
                ),

                Gap(40.h),
                CategoryWidget(),
                TopDoctorWidget(
                  controller: scrollController,
                  canScroll: true,
                ),
              ],
            ),
          ),
        ));
  }
}
