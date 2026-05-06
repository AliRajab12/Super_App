import 'package:somi/core/models/comments.dart';
import 'package:somi/core/models/group_activity.dart';
import 'package:somi/core/models/statistics.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/network/page_params.dart';
import 'package:somi/core/utils/extensions.dart';

class GroupService {
  final NetworkProvider network;

  GroupService(this.network);

  Future<(List<GroupActivity>, List<Comments>, List<Statistics>)> getGroupFeed(
      int groupId, String? sinceDate) async {
    final response = await network
        .auth(pageParams: CountDate(10, sinceDate))
        .get('/api/mobile/groups/$groupId/feed');
    return (
      response.deserializeList(GroupActivity.fromJson, 'Activities'),
      response.deserializeList(Comments.fromJson, 'Comments'),
      response.deserializeList(Statistics.fromJson, 'Statistics'),
    );
  }

  Future<void> clearFeedCache(int groupId) =>
      network.clearCache(path: '/api/mobile/groups/$groupId/feed');
}
