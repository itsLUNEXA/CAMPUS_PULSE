import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Study Request Endpoint', (sessionBuilder, endpoints) {
    const student1Id = '550e8400-e29b-41d4-a716-446655440004';
    const student2Id = '550e8400-e29b-41d4-a716-446655440005';

    final authedStudent1 = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(student1Id, {}),
    );
    final authedStudent2 = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(student2Id, {}),
    );

    test(
      'when sending and managing study requests then status transitions accurately',
      () async {
        // 1. Student 1 sends request to Student 2
        final req = await endpoints.studyRequest.sendRequest(
          authedStudent1,
          recipientAuthUserId: UuidValue.fromString(student2Id),
          subject: 'Data Structures',
          message: 'Let us prepare for the upcoming midterms together!',
          urgency: 'high',
        );

        expect(req.id, isNotNull);
        expect(req.status, 'pending');
        expect(req.subject, 'Data Structures');

        // 2. Student 2 checks incoming
        final incoming = await endpoints.studyRequest.getMyIncomingRequests(
          authedStudent2,
        );
        expect(incoming.any((r) => r.id == req.id), isTrue);

        // 3. Student 2 accepts the request
        final accepted = await endpoints.studyRequest.updateRequestStatus(
          authedStudent2,
          requestId: req.id!,
          newStatus: 'accepted',
        );
        expect(accepted.status, 'accepted');

        // 4. Student 1 checks outgoing and sees accepted
        final outgoing = await endpoints.studyRequest.getMyOutgoingRequests(
          authedStudent1,
        );
        final current = outgoing.firstWhere((r) => r.id == req.id);
        expect(current.status, 'accepted');
      },
    );
  });
}
