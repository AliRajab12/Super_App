import 'package:freezed_annotation/freezed_annotation.dart';

part 'suggestion_detail.freezed.dart';
part 'suggestion_detail.g.dart';

@freezed
class SuggestionDetail with _$SuggestionDetail {
  const factory SuggestionDetail({
    @JsonKey(name: 'Name') @Default(null) String? name,
    @JsonKey(name: 'InputType') @Default(null) String? inputType,
    @JsonKey(name: 'PathwayId') @Default(null) String? pathwayId,
    @JsonKey(name: 'PathwayName') @Default(null) String? pathwayName,
    @JsonKey(name: 'Source') @Default(null) String? source,
    @JsonKey(name: 'InputId') @Default(null) int? inputId,
    @JsonKey(name: 'ProfileUrl') @Default(null) String? url,
  }) = _SuggestionDetail;

  factory SuggestionDetail.fromJson(Map<String, dynamic> json) =>
      _$SuggestionDetailFromJson(json);
}
