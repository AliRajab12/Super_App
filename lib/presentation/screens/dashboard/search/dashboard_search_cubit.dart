import 'package:somi/core/services/user_service.dart';
import 'package:somi/presentation/screens/dashboard/search/dashboard_search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardSearchCubit extends Cubit<DashboardSearchState> {
  final UserService userService;

  DashboardSearchCubit(this.userService) : super(const DashboardSearchState());

  void searchSkills(String query) async {
    emit(
        state.copyWith(currentQuery: query, searching: true, searchResult: []));

    try {
      final searchResult = await userService.searchContent(query: query);

      // Return if the query has changed since the search started
      if (state.currentQuery != query) return;

      emit(state.copyWith(
        searchResult: searchResult.toSet().toList(),
        displayQuery: state.currentQuery,
      ));
    } catch (e) {
      if (state.currentQuery == query) {
        emit(state.copyWith(searchError: e));
      }
    } finally {
      emit(state.copyWith(searching: false));
    }
  }
}
