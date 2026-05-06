import 'package:somi/core/models/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reference.freezed.dart';
part 'reference.g.dart';

@freezed
class Reference with _$Reference {
  const factory Reference({
    @JsonKey(name: 'ReferenceType') @Default('') String referenceType,
    @JsonKey(name: 'ReferenceId') @Default(0) int referenceId,
    @JsonKey(name: 'Reference') Resource? reference,
    @JsonKey(name: 'Parameter') int? parameter,
    @JsonKey(name: 'Node') String? node,
    @JsonKey(name: 'UserSuggestionId') int? userSuggestionId,
  }) = _Reference;

  factory Reference.fromJson(Map<String, dynamic> json) =>
      _$ReferenceFromJson(json);
}
