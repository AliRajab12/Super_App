import 'package:auto_route/auto_route.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/quick_nav.dart';
import 'package:somi/core/utils/size_utils.dart';
import 'package:somi/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_screen.dart';
import 'package:somi/presentation/screens/home/widgets/available_doctors.dart';
import 'package:flutter/material.dart';
import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_event.dart';
import 'widgets/banner_card.dart';
import 'widgets/services.dart';
import 'widgets/top_offers.dart';
import 'widgets/top_seller.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final homeBloc = locator<HomeScreenBloc>();
  @override
  void initState() {
    super.initState();
    homeBloc.add(const FetchOrgAnnouncment());
    homeBloc.add(const FetchTopCarSellers());
    homeBloc.add(const FetchAvailableDoctors());
    homeBloc.add(const FetchTopOffers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: DashboardSearchBar(
        onTap: () {
          QuickNav.push(context, const DashBoardSearchScreen());
        },
      ),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SomiServicesWidget(),
            SizedBox(
              height: 15.v,
            ),
            const HomeBannerCard(),
            SizedBox(
              height: 4.v,
            ),
            const TopSellerWidget(),
            SizedBox(
              height: 4.v,
            ),
            const AvailableDoctors(),
            SizedBox(
              height: 4.v,
            ),
            const TopOffers(),
          ],
        ),
      ),
    );
  }
}
