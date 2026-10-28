import 'package:serverpod/serverpod.dart';
import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/service/seed_data.dart';

void run(List<String> args) async {
  // Initialize Serverpod with command line args, Protocol and Endpoints
  final pod = Serverpod(
    args,
    Protocol(),
    Endpoints(),
  );

  // Start Serverpod server (runs migrations if requested, starts listener)
  await pod.start();

  // Automatically seed sample data on startup
  final session = await pod.createSession();
  try {
    session.log('Seeding initial campus data (students, events, quiz questions)...');
    await SeedService.seedAll(session);
    session.log('Database seeded successfully!');
  } catch (e, stack) {
    session.log('Seeding error: $e\n$stack', level: LogLevel.warning);
  } finally {
    await session.close();
  }
}
