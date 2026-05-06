import 'package:somi/core/models/high_level_counts.dart';
import 'package:somi/core/models/input.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'discover_state.freezed.dart';

@freezed
class DiscoverState with _$DiscoverState {
  const factory DiscoverState({
    @Default(false) bool loading,
    @Default(null) Object? error,
    @Default(HighLevelCounts()) HighLevelCounts counts,
    @Default([]) List<Input> continueLearningItems,
    @Default([]) List<Input> recentItems,
  }) = _DiscoverState;
}
