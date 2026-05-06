import 'package:somi/presentation/screens/car_rental/presentation/bloc/car_bloc.dart';

import '../../../../../core/service_locator.dart';

class GlobalBloc {
  static CarBloc carBloc = locator<CarBloc>();
}
