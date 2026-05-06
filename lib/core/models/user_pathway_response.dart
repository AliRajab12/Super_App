import 'package:somi/core/models/pathway.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_pathway_response.freezed.dart';
part 'user_pathway_response.g.dart';

@freezed
class UserPathwayResponse with _$UserPathwayResponse {
  const factory UserPathwayResponse({
    @JsonKey(name: 'AuthoredPathways')
    @Default([])
    List<Pathway> authoredPathways,
    @JsonKey(name: 'EnrolledPathways')
    @Default([])
    List<Pathway> enrolledPathways,
    @JsonKey(name: 'CompletedPathways')
    @Default([])
    List<Pathway> completedPathways,
  }) = _UserPathwayResponse;

  factory UserPathwayResponse.fromJson(Map<String, dynamic> json) =>
      _$UserPathwayResponseFromJson(json);
}
