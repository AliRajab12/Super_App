import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:somi/online_clinic/core/enums/field_worker_page_state_enum.dart';
import 'package:somi/online_clinic/core/enums/user_type_enum.dart';
import 'package:somi/online_clinic/core/widgets/app_widgets/custom_image/fullscreen_photo_page.dart';
import 'package:somi/online_clinic/features/category_selected_list_feature/presentation/pages/category_list_page.dart';
import 'package:somi/online_clinic/features/doctor_appointment_list_feature/presentation/pages/doctor_appointment_list_page.dart';
import 'package:somi/online_clinic/features/doctor_home_panel_feature/presentation/pages/doctor_home_panel_feature.dart';
import 'package:somi/online_clinic/features/doctor_profile_feature/presentation/pages/doctor_profile_page.dart';
import 'package:somi/online_clinic/features/edit_appointment_page_feature/presentation/pages/edit_appointment_page.dart';
import 'package:somi/online_clinic/features/field_worker_appointmet_list_feature/presentation/pages/field_worker_appointment_list_page.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/pages/field_worker_profile_page.dart';
import 'package:somi/online_clinic/features/field_worker_home_feature/presentation/pages/field_worker_profile_with_location_page.dart';
import 'package:somi/online_clinic/features/guest_home_feature/domain/entities/category_entity.dart';
import 'package:somi/online_clinic/features/guest_home_feature/presentation/pages/clinic_home_page.dart';
import 'package:somi/online_clinic/features/medical_gallery_feature/presentation/pages/medical_gallery_page.dart';
import 'package:somi/online_clinic/features/patientProfile/presentation/pages/patientProfilePage.dart';
import 'package:somi/online_clinic/features/patients_reviews_feature/presentation/pages/patients_reviews_page.dart';
import 'package:somi/online_clinic/features/user_appointment_list_feature/presentation/pages/user_appointment_list_page.dart';
import 'package:somi/online_clinic/features/user_home_feature/presentation/pages/user_home_page.dart';
import 'package:somi/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/presentation/screens/home/home_screen.dart';
import 'package:somi/presentation/screens/launch/launch_screen.dart';
import 'package:somi/presentation/screens/login/login_screen.dart';
import 'package:somi/presentation/screens/login/logout_screen.dart';
import 'package:somi/presentation/screens/login/phonetwilio/somiphonelogin.dart';
import 'package:somi/presentation/screens/login/phonetwilio/somiphoneverify.dart';
import 'package:somi/presentation/screens/login/reset_password/reset_password_screen.dart';
import 'package:somi/presentation/screens/menu_new/menu_screen.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/documents_screen/documents_screen.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/documents/presentation/documents_upload_screen/documents_upload_screen.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/my_cards_screen.dart';

import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/add_address_screen/add_address_screen.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/presentation/screens/saved_addresses/saved_address_screen.dart';
import 'package:somi/presentation/screens/notification/presentation/screens/notification_list_screen.dart';
import 'package:somi/presentation/screens/self_profile/profile_menu_screen.dart';
import 'package:somi/presentation/screens/tourist_visa/features/apply_for_visa/presentation/screens/visa_application_screen.dart';
import 'package:somi/presentation/screens/tourist_visa/features/payment/presentation/screens/visa_payment_screen.dart';
import 'package:somi/presentation/screens/tourist_visa/features/visa_extension/presentation/screens/visa_extension_screen.dart';
import 'package:somi/presentation/screens/tourist_visa/features/visa_renewal/presentation/screens/visa_renweal_screen.dart';
import 'package:somi/presentation/screens/tourist_visa/tourist_visa_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/car_book_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/car_details_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/car_filter_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/car_rental_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/identify_screen.dart';
import '../presentation/screens/car_rental/presentation/pages/payment_screen.dart';
import '../presentation/screens/my_profile_screen/presentation/pages/add_card_screen.dart';
import '../presentation/screens/my_profile_screen/presentation/pages/my_profile_screen.dart';
import '../presentation/screens/my_profile_screen/presentation/pages/personal_information_screen.dart';
import '../presentation/screens/my_profile_screen/presentation/pages/wallet_screen.dart';

part 'main_router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route,Screen',
)
class MainRouter extends _$MainRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(path: '/', page: LaunchScreenRoute.page),
    CustomRoute(
        path: '/login',
        page: LoginScreenRoute.page,
        durationInMilliseconds: 700,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    AutoRoute(path: '/reset-password/*', page: ResetPasswordScreenRoute.page),
    AutoRoute(page: LogoutScreenRoute.page),
    CustomRoute(
        path: '/identify-screen',
        page: IdentifyScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/home',
        page: HomeScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/dashboard',
        page: DashboardScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/car-rental',
        page: CarRentalScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/car-details',
        page: CarDetailsScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/car-filter',
        page: CarFilterScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/car-book',
        page: CarBookScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/visa',
        page: TouristVisaScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/visa-app',
        page: VisaApplicationScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/visa-renewal',
        page: VisaRenewalScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/visa-extension',
        page: VisaExtensionScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/visa-payment',
        page: VisaPaymentScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/notifications',
        page: NotificationListScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/profile',
        page: ProfileMenuScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/my-profile',
        page: MyProfileScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/saved-addresses',
        page: SavedAddressesScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/address/add',
        page: AddAddressScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/personal-info',
        page: PersonalInformationScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/documents',
        page: DocumentsScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/documents/upload',
        page: DocumentsUploadScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/phonelogin',
        page: SomiPhoneLoginRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/phoneverify',
        page: SomiPhoneVerifyRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/payment',
        page: PaymentScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: ClinicHomePage.route,
        page: ClinicHomePageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: CategoryListPage.route,
        page: CategoryListPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: DoctorProfilePage.route,
        page: DoctorProfilePageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: UserAppointmentListPage.route,
        page: UserAppointmentListPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: DoctorHomePage.route,
        page: DoctorHomePageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: DoctorAppointmentListPage.route,
        page: DoctorAppointmentListPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: UserHomePage.route,
        page: UserHomePageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: PatientsReviewsPage.route,
        page: PatientsReviewsPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: PatientProfile.route,
        page: PatientProfileRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: FieldWorkerProfilePage.route,
        page: FieldWorkerProfilePageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: EditAppointmentPage.route,
        page: EditAppointmentPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: MedicalGalleryPage.route,
        page: MedicalGalleryPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: FullScreenPhotoPage.route,
        page: FullScreenPhotoPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: FieldWorkerAppointmentListPage.route,
        page: FieldWorkerAppointmentListPageRoute.page,
        durationInMilliseconds: 50,
        transitionsBuilder: TransitionsBuilders.slideRight),
    CustomRoute(
        path: '/wallet',
        page: WalletScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/my-cards',
        page: MyCardScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
    CustomRoute(
        path: '/add-card',
        page: AddCardScreenRoute.page,
        durationInMilliseconds: 600,
        transitionsBuilder: TransitionsBuilders.slideBottom),
  ];
}
