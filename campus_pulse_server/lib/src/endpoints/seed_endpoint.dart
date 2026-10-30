import 'package:serverpod/serverpod.dart';
import '../seed/seed_data.dart';

class SeedEndpoint extends Endpoint {
  /// Seeds initial campus events and quiz questions if they are not already populated.
  Future<bool> seedData(Session session) async {
    await SeedDataService.seedInitialData(session);
    return true;
  }
}
