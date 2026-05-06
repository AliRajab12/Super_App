import 'package:somi/core/models/rating_level.dart';
import 'package:somi/core/services/user_service.dart';

class OrgSkillRatingRepo {
  static const int defaultScale = 8;

  final UserService userService;

  List<RatingLevel>? _levels;

  OrgSkillRatingRepo(this.userService);

  Future<List<RatingLevel>> fetchLevels() async {
    _levels ??= await userService.getOrgRatingLevels();
    return _levels!;
  }

  Future<int> fetchRatingScale() async {
    final levels = await fetchLevels();
    return levels.isEmpty ? defaultScale : levels.length;
  }

  Future<void> clear() async {
    _levels = null;
    await userService.clearOrgRatingLevelsCache();
  }
}
