import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Student Endpoint', (sessionBuilder, endpoints) {
    const userIdStr = '550e8400-e29b-41d4-a716-446655440001';
    final authedSession = sessionBuilder.copyWith(
      authentication: AuthenticationOverride.authenticationInfo(
        userIdStr,
        {},
      ),
    );

    test(
      'when creating and fetching a student profile then data is persisted and retrieved',
      () async {
        final profile = await endpoints.student.updateProfile(
          authedSession,
          fullName: 'Jane Doe',
          branch: 'CSE',
          academicYear: 3,
          hostelOrArea: 'Block A, Room 102',
          bio: 'Passionate about distributed systems',
          subjectInterests: ['DSA', 'OS', 'DBMS'],
        );

        expect(profile.fullName, 'Jane Doe');
        expect(profile.branch, 'CSE');
        expect(profile.academicYear, 3);

        final fetched = await endpoints.student.getProfile(authedSession);
        expect(fetched, isNotNull);
        expect(fetched!.fullName, 'Jane Doe');
        expect(fetched.subjectInterests, contains('DSA'));
      },
    );

    test(
      'when fetching public profile then email is redacted for privacy',
      () async {
        // Create profile in this isolated test transaction
        await endpoints.student.updateProfile(
          authedSession,
          fullName: 'Jane Doe',
          branch: 'CSE',
          academicYear: 3,
          hostelOrArea: 'Block A, Room 102',
          bio: 'Passionate about distributed systems',
          subjectInterests: ['DSA', 'OS', 'DBMS'],
        );

        final publicProfile = await endpoints.student.getPublicProfile(
          sessionBuilder,
          UuidValue.fromString(userIdStr),
        );

        expect(publicProfile, isNotNull);
        expect(publicProfile!.fullName, 'Jane Doe');
        expect(publicProfile.email, contains('***'));
      },
    );
  });
}
