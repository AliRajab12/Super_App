import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:somi/core/main_router.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/online_clinic/core/constants/constants.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/utils/call_class.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/app_textfield/app_textfield.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/tab_bar/custom_tab_bar.dart';
import 'package:somi/online_clinic/core/widgets/custom_body.dart';
import 'package:somi/online_clinic/core/widgets/custom_text.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/domain/entity/appointment_entity.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/presentation/widgets/appointment_card_widget.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/presentation/widgets/completed_appointment_card.dart';

@RoutePage()
class UserAppointmentListPage extends StatefulWidget {
  const UserAppointmentListPage({super.key});

  static const String route = '/userAppointmentListPage';

  @override
  State<UserAppointmentListPage> createState() => _MyAppointmentListPageState();
}

class _MyAppointmentListPageState extends State<UserAppointmentListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();
    List<AppointmentEntity> appointments = [
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      ),
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      ),
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      ),
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      ),
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      ),
      AppointmentEntity(
        firstName: 'jamshid',
        lastName: 'jamshid',
        avatar: 'images/onine_clinic_png/doctor.png',
        appointmentDate: DateTime.now(),
        expertise: 'jarrah',
      )
    ];
    return CustomBody(
      showAppAppbar: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16.h),
          Center(
            child: AppTextField(
              controller: _searchController,
              hintText: 'Search a doctor or medical condition',
            ),
          ),
          Gap(25.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomText(
              text: 'Appointments',
              textFontWight: TextFontWight.bold,
              textStyle: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Gap(24.h),
          CustomTabbar(
            height: 37.h,
            onTap: (page) {
              //  _pageController.jumpToPage(page);
            },
            tabController: _tabController,
            tabs: const [
              Tab(
                text: 'Today’s',
              ),
              Tab(
                text: 'Upcoming',
              ),
              Tab(
                text: 'Completed',
              ),
            ],
            padding: EdgeInsets.symmetric(horizontal: 16.w),
          ),
          Gap(16.h),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: appointments.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: 8.r,
                    ),
                    child: TodaysAppointmentCardWidget(
                      appointment: appointments[index],
                      makeCallTap: () {
                        CallClass().joinMeeting(
                          context: context,
                          roomName: Constants.callRoomName,
                        );
                      },
                      checkupTap: () {
                        locator<MainRouter>().push(PatientProfileRoute(
                          userType: UserTypeEnum.patient,
                        ));
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: appointments.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: 8.r,
                    ),
                    child: TodaysAppointmentCardWidget(
                      appointment: appointments[index],
                      makeCallTap: () {
                        CallClass().joinMeeting(
                          context: context,
                          roomName: Constants.callRoomName,
                        );
                      },
                      checkupTap: () {
                        locator<MainRouter>().push(PatientProfileRoute(
                          userType: UserTypeEnum.patient,
                        ));
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: appointments.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: 8.r,
                    ),
                    child: CompletedAppointmentCard(
                      appointment: appointments[index],
                      checkupTap: () {
                        locator<MainRouter>().push(PatientProfileRoute(
                          userType: UserTypeEnum.patient,
                        ));
                      },
                      summaryTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
