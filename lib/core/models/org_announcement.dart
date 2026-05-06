// ignore_for_file: non_constant_identifier_names

import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_announcement.freezed.dart';
part 'org_announcement.g.dart';

@freezed
class OrgAnnouncement with _$OrgAnnouncement {
  factory OrgAnnouncement({
    @Default(null) String? title,
    @Default(null) String? description,
    @Default(null) String? linkUrl,
    @Default(null) String? linkName,
    @Default(null) String? imageUrl,
  }) = _OrgAnnouncement;

  factory OrgAnnouncement.fromJson(Map<String, dynamic> json) =>
      _$OrgAnnouncementFromJson(json);
}
