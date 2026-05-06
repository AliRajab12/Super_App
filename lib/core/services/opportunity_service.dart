import 'package:somi/core/models/reference.dart';
import 'package:somi/core/network/network_config.dart';
import 'package:somi/core/utils/extensions.dart';

class OpportunityService {
  final NetworkProvider network;

  OpportunityService(this.network);

  Future<List<Reference>> getOpportunities() async {
    final response =
        await network.auth().get('/api/mobile/learnerhome/opportunities');
    return response.deserializePage(Reference.fromJson).items;
  }

  Future<void> clearOpportunitiesCache() async {
    await network.clearCache(path: '/api/mobile/learnerhome/opportunities');
  }
}
