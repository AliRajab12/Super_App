import 'package:somi/core/models/discover_response.dart';
import 'package:somi/core/models/high_level_counts.dart';
import 'package:somi/core/models/input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_state_new.freezed.dart';

@freezed
class DiscoverStateNew with _$DiscoverStateNew {
  const factory DiscoverStateNew({
    @Default(false) bool loading,
    @Default(null) Object? error,
    @Default(HighLevelCounts()) HighLevelCounts counts,
    @Default(DiscoverResponse()) DiscoverResponse discoverItems,
    @Default(DiscoverResponse()) DiscoverResponse recentlyViewedItems,
    @Default(DiscoverResponse()) DiscoverResponse trendingItems,
    @Default([]) List<Input> todayFeedItems,
  }) = _DiscoverStateNew;
}
