import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class BuddyEndpoint extends Endpoint {
  Future<List<Student>> findBuddies(
    Session session, {
    required String subject,
    required String location,
  }) async {
    final cleanSubject = subject.trim().toLowerCase();
    final cleanLocation = location.trim().toLowerCase();

    final allStudents = await Student.db.find(session);

    final matched = allStudents.where((s) {
      final interestMatch = s.interests.any(
        (interest) =>
            interest.toLowerCase().contains(cleanSubject) ||
            cleanSubject.contains(interest.toLowerCase()),
      );
      final locationMatch = cleanLocation.isNotEmpty &&
          s.hostelArea.toLowerCase().contains(cleanLocation);

      return interestMatch || locationMatch;
    }).toList();

    matched.sort((a, b) {
      final aSubjectMatch =
          a.interests.any((i) => i.toLowerCase().contains(cleanSubject)) ? 1 : 0;
      final bSubjectMatch =
          b.interests.any((i) => i.toLowerCase().contains(cleanSubject)) ? 1 : 0;
      return bSubjectMatch.compareTo(aSubjectMatch);
    });

    return matched;
  }

  Future<StudyRequest> createRequest(
    Session session,
    StudyRequest request,
  ) async {
    request.status = 'open';
    return await StudyRequest.db.insertRow(session, request);
  }

  Future<List<StudyRequest>> getRequests(
    Session session, {
    String? subject,
  }) async {
    final list = (subject != null && subject.isNotEmpty && subject.toLowerCase() != 'all')
        ? await StudyRequest.db.find(
            session,
            where: (t) => t.subject.equals(subject),
            orderBy: (t) => t.createdAt,
          )
        : await StudyRequest.db.find(
            session,
            orderBy: (t) => t.createdAt,
          );
    list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return list;
  }
}
