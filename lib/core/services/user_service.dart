import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:somi/core/main_router.dart';
import 'package:somi/core/models/analytics_event.dart';
import 'package:somi/core/models/car.dart';
import 'package:somi/core/models/comments.dart';
import 'package:somi/core/models/discover_response.dart';
import 'package:somi/core/models/doctor.dart';
import 'package:somi/core/models/group.dart';
import 'package:somi/core/models/high_level_counts.dart';
import 'package:somi/core/models/initial_data.dart';
import 'package:somi/core/models/input.dart';
import 'package:somi/core/models/offer.dart';
import 'package:somi/core/models/org_announcement.dart';
import 'package:somi/core/models/page_response.dart';
import 'package:somi/core/models/pathway_details.dart';
import 'package:somi/core/models/plan_details.dart';
import 'package:somi/core/models/push_preference.dart';
import 'package:somi/core/models/rating.dart';
import 'package:somi/core/models/rating_level.dart';
import 'package:somi/core/models/reference.dart';
import 'package:somi/core/models/role.dart';
import 'package:somi/core/models/saved_item.dart';
import 'package:somi/core/models/search_result.dart';
import 'package:somi/core/models/tag.dart';
import 'package:somi/core/models/takeaway.dart';
import 'package:somi/core/models/target.dart';
import 'package:somi/core/models/user.dart';
import 'package:somi/core/models/user_item.dart';
import 'package:somi/core/models/user_pathway_response.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/network/page_params.dart';
import 'package:somi/core/repos/auth_data_repo.dart';
import 'package:somi/core/repos/org_skill_rating_repo.dart';
import 'package:somi/core/repos/user_prefs.dart';
import 'package:somi/core/repos/user_repo.dart';
import 'package:somi/core/service_locator.dart';
import 'package:somi/core/services/analytics_service.dart';
import 'package:somi/core/services/auth/auth_service.dart';
import 'package:somi/core/services/security_provider.dart';
import 'package:somi/core/theme/SuperApp_theme.dart';
import 'package:somi/core/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http_parser/http_parser.dart';
import 'package:somi/presentation/screens/my_profile_screen/presentation/pages/saved_addresses/data/models/address.dart';
import 'package:somi/presentation/screens/somidashboard/data/car.dart';
import 'package:somi/presentation/screens/notification/data/models/notification.dart'
    as notification;

class UserService {
  final NetworkProvider network;

  UserService(this.network);

  Future<InitialData> getInitialData() async {
    final response = await network
        .auth(forceRefresh: true)
        .get('/api/mobile/user/initialdata');
    return InitialData.fromJson(response.data);
  }

  Future<String> getBlobBaseUrl() async {
    try {
      final response = await network.noAuth().get('/api/webenvironment/info');
      return response.data['BlobBaseUrl'];
    } catch (e) {
      log('Unable to fetch BlobBaseUrl', error: e);
      return '';
    }
  }

  Future<HighLevelCounts> getHighLevelCounts({bool refresh = false}) async {
    final response = await network
        .auth(forceRefresh: refresh)
        .get('/api/mobile/user/highlevelcounts');
    return HighLevelCounts.fromJson(response.data);
  }

  Future<List<Input>> getTodayFeed() async {
    final response = await network
        .auth(pageParams: const CountSkip(100, 0))
        .get('/api/mobile/user/today');
    return response.deserializeList(Input.fromJson);
  }

  Future<void> clearTodayFeedCache() async {
    await network.clearCache(path: '/api/mobile/user/today');
  }

  Future<PageResponse<Input>> getSavedFeed(int nextPageNumber,
      {int pageNumber = 0}) async {
    final response = await network
        .auth(pageParams: CountSkip(10, pageNumber))
        .get('/api/mobile/v3/user/queue');
    return response.deserializePage(Input.fromJson);
  }

  Future<void> clearSavedCache() async {
    await network.clearCache(path: '/api/mobile/v3/user/queue');
  }

  Future<PageResponse<Input>> getCollection(int userKey, int pageNumber) async {
    final response = await network
        .auth(pageParams: CountSkip(10, pageNumber))
        .get('/api/mobile/users/$userKey/collection');
    return response.deserializePage((json) {
      return Input.fromJson(json['Content'])
          .copyWith(inputId: json['ItemId'], userInputId: json['UserItemId']);
    });
  }

  Future<List<Role>> getOrgRoles({String query = ''}) async {
    final response = await network
        .auth()
        .get('/api/mobile/orgs/roles', queryParameters: {'term': query});
    return response.deserializeList(Role.fromJson, 'Items');
  }

  Future<List<RatingLevel>> getOrgRatingLevels() async {
    final response =
        await network.auth().get('/api/mobile/orgs/skills/ratinglevels');
    return response.deserializeList(RatingLevel.fromJson);
  }

  Future<void> clearOrgRatingLevelsCache() async {
    await network.clearCache(path: '/api/mobile/orgs/skills/ratinglevels');
  }

  Future<void> updateSkillFocusState(int skillId, bool isFocused) async {
    await network.auth().put(
      '/api/mobile/user/skills/$skillId',
      data: {
        'RequestingUserIsFocused': isFocused,
      },
    );
  }

  Future<List<Tag>> searchSkills({String query = ''}) async {
    final response = await network
        .auth()
        .get('/api/mobile/skills/search', queryParameters: {'term': query});
    return response.deserializeList(Tag.fromJson, 'Items');
  }

  Future<List<SearchResult>> searchContent({String query = ''}) async {
    final response = await network.auth(pageParams: const CountSkip(10, 0)).get(
        '/api/mobile/v2/search/resources',
        queryParameters: {'terms': query});
    return response.deserializeList(SearchResult.fromJson, 'Results');
  }

  Future<void> clearSearchSkillsCache() async {
    await network.clearCache(path: '/api/mobile/skills/search');
  }

  // Future<PageResponse<DegreedNotification>> getNotifications(
  //     {int pageNumber = 0, bool refresh = false}) async {
  //   final response = await network
  //       .auth(pageParams: CountSkip(10, pageNumber), forceRefresh: refresh)
  //       .get('/api/mobile/v2/user/notifications');
  //   return response.deserializePage(DegreedNotification.fromJson);
  // }

  Future<void> clearNotificationsCache() async {
    await network.clearCache(path: '/api/mobile/v2/user/notifications');
  }

  Future<void> setJobRole(String role) async {
    await network.auth().put(
      '/api/mobile/user/role',
      data: {'JobRole': role},
    );
  }

  Future<void> addSkill(int skillId, String skillName) async {
    await network.auth().post(
          '/api/mobile/user/skills',
          data: jsonEncode({
            'tagId': skillId,
            'name': skillName,
          }),
        );
  }

  Future<void> addComment(TakeAway takeAway) async {
    await network.auth().post(
          '/api/mobile/comments',
          data: jsonEncode(takeAway),
        );
  }

  Future<Comments> getComments(
      int contentId, String contentType, String localeId) async {
    const pageSize = TakeSkip(10, 0);
    final response = await network.auth(pageParams: pageSize).get(
      '/api/mobile/comments',
      queryParameters: {
        'ContentId': contentId,
        'ContentType': contentType,
      },
    );
    return Comments.fromJson(response.data);
  }

  Future<void> registerFirebaseTokenBackend(
      String deviceToken, String platformName) async {
    await network.auth().post(
          '/api/mobile/user/push',
          data: jsonEncode({
            'DeviceToken': deviceToken,
            'Platform': platformName,
          }),
        );
  }

  Future<void> removeSkill(int skillId) async {
    await network.auth().delete('/api/mobile/user/skills/$skillId');
  }

  Future<void> setOnboarded() =>
      network.auth().post('/api/mobile/user/onboarded');

  Future<void> resetOnboarding() =>
      network.auth().delete('/api/mobile/user/onboarded');

  Future<List<PushPreference>> getPushPreferences() async {
    final response =
        await network.auth().get('/api/mobile/user/push/preferences');
    return response.deserializeList(PushPreference.fromJson);
  }

  Future<void> clearPushPreferenceCache() async {
    await network.clearCache(path: '/api/mobile/user/push/preferences');
  }

  Future<void> setPushPreference(PushPreference pushPreference) async {
    await network.auth().put(
          '/api/mobile/user/push/preference',
          data: pushPreference.toJson(),
        );
  }

  Future<PageResponse<Input>> getRecommendedFeed(int nextPageNumber,
      {int pageNumber = 0}) async {
    final pageSize = CountSkip(10, pageNumber);
    final response = await network
        .auth(pageParams: pageSize)
        .get('/api/mobile/user/recommendations');
    return response.deserializePage(Input.fromJson, 'Recommendations');
  }

  Future<void> clearRecommendedCache() async {
    await network.clearCache(path: '/api/mobile/user/recommendations');
  }

  Future<PageResponse<Group>> getGroups(int pageNumber,
      {int memberTake = 5}) async {
    final pageSize = TakeSkip(10, pageNumber);
    final response = await network.auth(pageParams: pageSize).get(
      '/api/mobile/v2/user/groups',
      queryParameters: {'memberTake': memberTake},
    );
    return response.deserializePage(Group.fromJson, 'Groups');
  }

  Future<DiscoverResponse> getContinueLearning(int pageNumber,
      {int memberTake = 20}) async {
    final pageSize = TakeSkip(memberTake, pageNumber);
    final response = await network.auth(pageParams: pageSize).get(
          '/api/mobile/learnerhome/continuelearning',
        );
    return DiscoverResponse.fromJson(response.data);
  }

  Future<DiscoverResponse> getRecentlyViewed(int pageNumber,
      {int memberTake = 20}) async {
    final pageSize = TakeSkip(memberTake, pageNumber);
    final response = await network.auth(pageParams: pageSize).get(
          '/api/mobile/learnerhome/recentlyviewed',
        );
    return DiscoverResponse.fromJson(response.data);
  }

  Future<DiscoverResponse> getDashboardTrendingDegreed(int pageNumber,
      {int memberTake = 5}) async {
    final pageSize = TakeSkip(memberTake, pageNumber);
    final response = await network.auth(pageParams: pageSize).get(
          '/api/mobile/learnerhome/TrendingInOrg',
        );
    return DiscoverResponse.fromJson(response.data);
  }

  Future<List<Input>> getDashboardTodayFeed(int pageNumber,
      {int memberTake = 5}) async {
    final pageSize = TakeSkip(memberTake, pageNumber);
    final response =
        await network.auth(pageParams: pageSize).get('/api/mobile/user/today');
    return response.deserializeList(Input.fromJson);
  }

  Future<void> clearContinueLearningCache() async {
    await network.clearCache(path: '/api/mobile/learnerhome/continuelearning');
  }

  Future<void> clearRecentlyViewedCache() async {
    await network.clearCache(path: '/api/mobile/learnerhome/recentlyviewed');
  }

  Future<void> clearDashboardTrendingDegreed() async {
    await network.clearCache(path: '/api/mobile/learnerhome/TrendingInOrg');
  }

  Future<void> clearDashboardTodayFeed() async {
    await network.clearCache(path: '/api/mobile/user/today');
  }

  Future<void> clearGroupsCache() async {
    await network.clearCache(path: '/api/mobile/v2/user/groups');
  }

  Future<void> acceptDataPrivacy() async {
    await network.auth().post(
          '/api/mobile/user/orgsettings',
          data: jsonEncode({'SettingName': 'EnforceDataPrivacyAcceptance'}),
        );
  }

  Future<void> performLogout({required bool manual, String? reason}) async {
    // Show logout screen
    locator<MainRouter>().replaceAll([const LogoutScreenRoute()]);

    await locator<Analytics>().track(
      manual ? Events.loggedOutManual : Events.loggedOutSystem,
      timeout: const Duration(milliseconds: 2000),
    );

    try {
      // Invalidate token.
      await locator<AuthService>().invalidateToken();
    } catch (_) {
      // Ignore errors; we don't want network/service hiccups to prevent logout
    }

    // Clear stored auth data
    await locator<AuthDataRepo>().clear();

    // Clear stored user data
    await locator<UserRepo>().clear();
    await locator<UserPrefs>().clear();
    await locator<OrgSkillRatingRepo>().clear();

    // Clear the HTTP cache
    await network.clearCache();

    // Clear the cache used by DGNetworkImage
    await locator<CacheManager>().emptyCache();

    // Clear secure storage
    await locator<SecurityProvider>().clear();

    // Revert to default brand theme
    locator<GlobalKey<SuperAppThemeState>>().currentState?.refreshBrandColors();

    // Route to login screen
    locator<MainRouter>().replaceAll([LoginScreenRoute(logoutReason: reason)]);
  }

  Future<void> updateProfile(
      String? firstName, String? lastName, String? bio) async {
    await network.auth().post(
          '/api/mobile/user/profile',
          data: jsonEncode({
            'FirstName': firstName,
            'LastName': lastName,
            'Bio': bio,
          }),
        );
    await locator<UserRepo>().refreshInitialData();
  }

  Future<void> updateProfilePicture(Uint8List imageBytes) async {
    FormData data = FormData.fromMap({
      'file': MultipartFile.fromBytes(
        List.from(imageBytes),
        filename: 'profile.png',
        contentType: MediaType('image', 'png'),
      ),
    });
    await network.auth(forceRefresh: true).post(
          '/api/mobile/user/profile/picture',
          data: data,
        );
    await locator<UserRepo>().refreshInitialData();
  }

  Future<User> getUserProfile(String userSlug) async {
    final response =
        await network.auth().get('/api/mobile/users/$userSlug/profile');
    return User.fromJson(response.data);
  }

  Future<void> followUser(
      String userProfileId, String? userSlug, bool isFollowing) async {
    if (isFollowing) {
      await network.auth().post(
            '/api/mobile/user/following',
            data: jsonEncode({'userProfileId': userProfileId}),
          );
    } else {
      await network.auth().delete('/api/mobile/user/following/$userProfileId');
    }
    if (userSlug != null) {
      await network.clearCache(path: '/api/mobile/users/$userSlug/profile');
    }
  }

  Future<void> followPathway(String pathwayId) async {
    await network.auth().post(
          '/api/mobile/user/pathways',
          data: jsonEncode({'ExplicitEnrollment': true, 'PathId': pathwayId}),
        );
  }

  Future<void> unFollowPathway(String pathwayId) async {
    await network.auth().delete('/api/mobile/user/pathways/$pathwayId');
  }

  Future<void> markItemCompleted(Input input) async {
    await network.auth().post(
          '/api/mobile/user/collection',
          data: input.toJson(),
        );
  }

  Future<void> markItemNotCompleted(
      String resourceType, String resourceId) async {
    await network
        .auth()
        .delete('/api/mobile/user/collection/$resourceType/$resourceId');
  }

  Future<SavedItem> markItemSaved(Input input) async {
    final response = await network.auth().post(
          '/api/mobile/user/queue',
          data: input.toJson(),
        );
    return SavedItem.fromJson(response.data);
  }

  Future<void> markItemNotSaved(String resourceId) async {
    await network.auth().delete('/api/mobile/user/queue/$resourceId');
  }

  Future<PageResponse<UserItem>> getFollowers(int userKey,
      {int pageNumber = 0}) async {
    final response = await network
        .auth(pageParams: CountSkip(10, pageNumber))
        .get('/api/mobile/v2/users/$userKey/followers');
    return response.deserializePage(UserItem.fromJson);
  }

  Future<PageResponse<UserItem>> getFollowing(int userKey,
      {int pageNumber = 0}) async {
    final response = await network
        .auth(pageParams: CountSkip(10, pageNumber))
        .get('/api/mobile/v2/users/$userKey/following');
    return response.deserializePage(UserItem.fromJson);
  }

  Future<void> clearFollowCache(int userKey) async {
    await network.clearCache(path: '/api/mobile/v2/users/$userKey/followers');
    await network.clearCache(path: '/api/mobile/v2/users/$userKey/following');
  }

  Future<void> clearCollectionCache(int userKey) async {
    await network.clearCache(path: '/api/mobile/users/$userKey/collection');
  }

  Future<UserPathwayResponse> getPathways(int userKey) async {
    final response =
        await network.auth().get('/api/mobile/users/$userKey/pathways');
    return UserPathwayResponse.fromJson(response.data);
  }

  Future<void> clearPathwayCache(int userKey) async {
    await network.clearCache(path: '/api/mobile/users/$userKey/pathways');
  }

  Future<PageResponse<Target>> getTargets(int userKey, int pageNumber) async {
    final pageSize = CountSkip(10, pageNumber);
    final response = await network
        .auth(pageParams: pageSize)
        .get('/api/mobile/users/$userKey/targets');
    return response.deserializePage(Target.fromJson, 'Results');
  }

  Future<void> clearTargetsCache(int userKey) async {
    await network.clearCache(path: '/api/mobile/users/$userKey/targets');
  }

  Future<PageResponse<Input>> getAssignments(
      int pageNumber, bool filterByCompleted) async {
    // TODO: Update with new assignments endpoint (PD-91363, PD-91556)
    final pageSize = CountSkip(200, pageNumber);
    final response = await network.auth(pageParams: pageSize).get(
      '/api/mobile/user/assignments',
      queryParameters: {'completed': filterByCompleted},
    );
    return response.deserializePage(Input.fromJson, 'Assignments');
  }

  Future<void> clearAssignmentsCache() async {
    await network.clearCache(path: '/api/mobile/user/assignments');
  }

  Future<List<Tag>> getSkills() async {
    final response = await network.auth().get('/api/mobile/user/skills');
    return response.data.map<Tag>((tag) => Tag.fromJson(tag)).toList();
  }

  Future<List<Tag>> getSkillsViewer(String userSlug) async {
    final response =
        await network.auth().get('/api/mobile/user/$userSlug/skills');
    return response.data.map<Tag>((tag) => Tag.fromJson(tag)).toList();
  }

  Future<void> clearSkillsCache() async {
    await network.clearCache(path: '/api/mobile/user/skills');
  }

  Future<Rating> updateSelfRating(int skillId, int ratingLevel) async {
    final response = await network.auth().post(
          '/api/mobile/user/skills/$skillId/ratings',
          data: jsonEncode({'Type': 'Self', 'Level': ratingLevel}),
        );
    return Rating.fromJson(response.data);
  }

  Future<PlanDetails> getPlanDetails(String targetID) async {
    final response =
        await network.auth().get('/api/mobile/v2/targets/$targetID');
    return PlanDetails.fromJson(response.data);
  }

  Future<void> clearPlanDetailsCache(String targetID) async {
    await network.clearCache(path: '/api/mobile/v2/targets/$targetID');
  }

  Future<List<Reference>> getPlanResources({
    required String targetID,
    required String sectionNode,
    int pageNumber = 1,
  }) async {
    final response = await network.auth().get(
          '/api/mobile/v2/targets/$targetID/resources?sectionNodes=$sectionNode',
        );
    return response.deserializeList(Reference.fromJson);
  }

  Future<void> clearPlanResources(String targetID) async {
    await network.clearCache(
        path: '/api/mobile/v2/targets/$targetID/resources');
  }

  Future<PathwayDetails> getPathwayDetails(String pathwayId) async {
    final response =
        await network.auth().get('/api/mobile/resources/pathway/$pathwayId');
    return PathwayDetails.fromJson(response.data);
  }

  Future<void> clearPathwayDetailsCache(String pathwayId) async {
    await network.clearCache(path: '/api/mobile/resources/pathway/$pathwayId');
  }

  Future<bool> followPlan(Target target) async {
    final response = await network.auth().post(
          '/api/mobile/targets',
          data: target.toJson(),
        );
    return response.statusCode == 200;
  }

  Future<bool> unFollowPlan(String targetId) async {
    final response = await network.auth().delete(
          '/api/mobile/targets/$targetId',
        );
    return response.statusCode == 200;
  }

  // Home Screen
  Future<OrgAnnouncement?> getOrgAnnouncements() async {
    // final response = await network.noAuth().get('/api/v1/org/banner');
    return null;
  }

  Future<List<Car>> getTopCarSellers() async {
    // final response = await network.noAuth().get('/api/v1/cars/top_seller');
    return cars;
  }

  Future<List<Doctor>> getAvailableDoctors() async {
    // final response = await network.noAuth().get('/api/v1/org/banner');
    return doctors;
  }

  Future<List<Offer>> getTopOffers() async {
    // final response = await network.noAuth().get('/api/v1/org/banner');
    return offers;
  }

  Future<List<Address>> getUserSavedAddresses() async {
    // final response = await network.noAuth().get('/api/v1/user/saved-address');
    return [];
  }

  Future<bool> saveUserAddress({required Address address}) async {
    debugPrint("Address: ${address.toJson()}");
    // final response = await network.noAuth().get('/api/v1/user/saved-address');
    return true;
  }

  Future<List<notification.Notification>> getNotificationList(
      {int pageNumber = 0, bool refresh = false}) async {
    // final response = await network
    //     .auth(pageParams: CountSkip(10, pageNumber), forceRefresh: refresh)
    //     .get('/api/v1/user/notifications');
    return [];
  }
}
