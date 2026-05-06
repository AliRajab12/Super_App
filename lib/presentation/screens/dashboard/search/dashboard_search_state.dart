import 'package:somi/core/models/search_result.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_search_state.freezed.dart';

@freezed
class DashboardSearchState with _$DashboardSearchState {
  const factory DashboardSearchState({
    String? currentQuery,
    String? displayQuery,
    @Default(false) bool searching,
    Object? searchError,
    @Default([]) List<SearchResult> searchResult,
    @Default({}) Set<int> searchIds,
  }) = _DashboardSearchState;
}
