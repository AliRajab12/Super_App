import 'package:freezed_annotation/freezed_annotation.dart';

part 'saved_item.freezed.dart';
part 'saved_item.g.dart';

@freezed
class SavedItem with _$SavedItem {
  const SavedItem._();

  const factory SavedItem({
    @Default(null) @JsonKey(name: 'QueueItemId') int? queueItemId,
    @JsonKey(name: 'ReferenceId') @Default(null) int? referenceId,
  }) = _SavedItem;

  factory SavedItem.fromJson(Map<String, dynamic> json) =>
      _$SavedItemFromJson(json);
}
