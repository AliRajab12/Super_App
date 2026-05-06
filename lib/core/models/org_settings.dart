// ignore_for_file: non_constant_identifier_names

import 'package:somi/core/models/branding.dart';
import 'package:somi/core/models/org_announcement.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'org_settings.freezed.dart';
part 'org_settings.g.dart';

@freezed
class OrgSettings with _$OrgSettings {
  factory OrgSettings({
    @Default(null) int? OrgId,
    @Default(false) bool? IsDefaultCatalog,
    @Default(false) bool? ShouldWarnIfExternalContent,
    @JsonKey(name: 'HideExternalCatalog')
    @Default(false)
    bool hideExternalCatalog,
    @Default(null) String? ExternalContentWarning,
    @JsonKey(name: 'Branding') @Default(null) Branding? branding,
    @JsonKey(name: 'OrgAnnouncement')
    @Default(null)
    OrgAnnouncement? orgAnnouncement,
    @Default(null) String? Logo,
    @Default(null) String? DataPrivacyAcceptanceMessage,
    @Default(null) int? BrowseTargetId,
  }) = _OrgSettings;

  factory OrgSettings.fromJson(Map<String, dynamic> json) =>
      _$OrgSettingsFromJson(json);
}
