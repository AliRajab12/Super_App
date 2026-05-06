import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:somi/core/models/enrollment.dart';
import 'package:somi/core/models/group.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/pathway.dart';
import 'package:somi/core/models/resource.dart';
import 'package:somi/core/models/target.dart';
import 'package:somi/core/models/user.dart';
import 'package:somi/core/models/user_item.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/network/page_params.dart';
import 'package:somi/core/utils/extensions.dart';

class ResourceService {
  final NetworkProvider network;

  ResourceService(this.network);

  Future<void> clearBrowseCaches() async {
    await network.clearCache(path: '/api/mobile/search/opportunities');
    await network.clearCache(path: '/api/mobile/resources/pathways');
    await network.clearCache(path: '/api/mobile/resources/directories');
    await network.clearCache(path: '/api/mobile/search/targets');
    await network.clearCache(path: '/api/mobile/search/users');
    await network.clearCache(path: '/api/mobile/user/recommendations/users');
    await network.clearCache(path: '/api/mobile/search/resources');
    await network.clearCache(path: '/api/mobile/resources/groups');
  }

  Future<List<Resource>> searchOpportunities(
      int? orgId, String query, PageParams page) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/search/opportunities',
      queryParameters: {
        if (orgId != null) 'organizationId': orgId,
        'term': query,
      },
    );
    return response.deserializePage(Resource.fromJson).items;
  }

  Future<(List<Pathway>, List<Pathway>)> searchPathways(
      int? orgId, String query, PageParams page) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/resources/pathways',
      queryParameters: {
        if (orgId != null) 'organizationId': orgId,
        'searchTerm': query,
      },
    );

    final enrollments =
        response.deserializeList(Enrollment.fromJson, 'Enrollments');
    final Map<int?, Enrollment> enrollmentMap = {
      for (var e in enrollments) e.curriculumId: e
    };

    final List<Pathway> featured =
        response.deserializeList(Pathway.fromJson, 'Featured').map((e) {
      double? percentComplete = enrollmentMap[e.id]?.percentComplete;
      if (percentComplete == null) return e;
      return e.copyWith(percentComplete: percentComplete);
    }).toList();

    final List<Pathway> pathways =
        response.deserializeList(Pathway.fromJson, 'Paths').map((e) {
      double? percentComplete = enrollmentMap[e.id]?.percentComplete;
      if (percentComplete == null) return e;
      return e.copyWith(percentComplete: percentComplete);
    }).toList();

    return (featured, pathways);
  }

  Future<(String?, List<Target>)> getDirectories(int? orgId) async {
    if (orgId == null) return ('', <Target>[]);

    final response = await network.auth().get(
      '/api/mobile/resources/directories',
      queryParameters: {'organizationId': orgId},
    );

    if (response.data == null || response.data.isEmpty) return ('', <Target>[]);

    String? title = response.data['Title'];

    List<Target> data = response.data['Section']['TargetResources']
        .map((e) => e['Reference'])
        .where((e) => e != null)
        .map<Target>((e) => Target.fromJson(e))
        .toList();

    return (title, data);
  }

  Future<List<Target>> searchTargets(
      int? orgId, String query, PageParams page) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/search/targets',
      queryParameters: {
        'organizationId': orgId,
        'terms': query,
      },
    );
    return response.deserializeList(Target.fromJson, 'Results');
  }

  Future<List<User>> searchUsers(
      int? orgId, String? query, PageParams page) async {
    final response =
        await network.auth(forceRefresh: false, pageParams: page).get(
      '/api/mobile/search/users',
      queryParameters: {
        'organizationId': orgId,
        'terms': query,
      },
    );
    return response
        .deserializeList(UserItem.fromJson, 'Items')
        .map((e) => e.asUser())
        .whereNotNull()
        .toList();
  }

  Future<List<User>> getRecommendedUsers(int? orgId) async {
    final response = await network.auth().get(
      '/api/mobile/user/recommendations/users',
      queryParameters: {'organizationId': orgId},
    );
    return response.deserializeList(User.fromJson, 'UserProfileSummaries');
  }

  Future<Map<String, List<Input>>> searchResourcesMany(
    List<String> types,
    bool externalResources,
    String query, {
    PageParams page = const CountSkip(10, 0),
  }) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/search/resources',
      queryParameters: {
        'types': types.join(','),
        'externalResources': externalResources,
        'terms': query,
      },
    );

    return {
      for (var e in response.data)
        e['InputType']: List.from(e['LearningItems']
            .map((item) => Input.fromJson(item['FeedItem']))
            .toList()),
    };
  }

  Future<List<Input>> searchResources(String type, bool externalResources,
      String query, PageParams page) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/search/resources/$type',
      queryParameters: {
        'externalResources': externalResources,
        'terms': query,
      },
    );
    return List.from(response.data[0]['LearningItems']
        .map((item) => Input.fromJson(item['FeedItem']))
        .toList());
  }

  Future<List<Group>> searchGroups(
      int? orgId, String query, PageParams page) async {
    final response = await network.auth(pageParams: page).get(
      '/api/mobile/resources/groups',
      queryParameters: {
        'organizationId': orgId,
        'terms': query,
      },
    );
    return response.deserializeList(Group.fromJson, 'Groups');
  }

  Future<void> reportAProblem({
    required String emailBody,
    required String source,
    required String itemType,
    required int itemInfo,
    required String title,
    bool permission = false,
  }) async {
    await network.auth().post(
          '/api/mobile/report/content/problem',
          data: jsonEncode(
            {
              'emailBody': emailBody,
              'source': source,
              'itemType': itemType,
              'itemInfo': itemInfo,
              'title': title,
              'permission': permission,
            },
          ),
        );
  }
}
