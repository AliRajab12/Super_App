import 'package:json_annotation/json_annotation.dart';

class StringAsInt implements JsonConverter<int?, String?> {
  const StringAsInt();

  @override
  int? fromJson(String? json) {
    if (json == null) return null;
    return int.tryParse(json);
  }

  @override
  String? toJson(int? num) {
    return num?.toString();
  }
}
