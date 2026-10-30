import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SearchEndpoint extends Endpoint {
  /// Bounded global campus search across events, study buddies, and public profiles.
  Future<SearchResponse> search(
    Session session,
    String query, {
    int limit = 20,
  }) async {
    final cleanQuery = query.trim().toLowerCase();
    if (cleanQuery.isEmpty) {
      return SearchResponse(query: query, items: [], totalCount: 0);
    }

    final items = <SearchItem>[];

    // 1. Search events
    final events = await CampusEvent.db.find(
      session,
      limit: 10,
      orderBy: (t) => t.startTime,
    );
    for (final e in events) {
      if (e.title.toLowerCase().contains(cleanQuery) ||
          e.description.toLowerCase().contains(cleanQuery) ||
          e.category.toLowerCase().contains(cleanQuery) ||
          e.venue.toLowerCase().contains(cleanQuery)) {
        items.add(
          SearchItem(
            type: 'event',
            id: e.id.toString(),
            title: e.title,
            subtitle: '${e.category} • ${e.venue}',
            description: e.description,
            category: e.category,
          ),
        );
      }
    }

    // 2. Search student study profiles
    final students = await StudentProfile.db.find(
      session,
      limit: 15,
    );
    for (final s in students) {
      final matchesName = s.fullName.toLowerCase().contains(cleanQuery);
      final matchesBranch = s.branch.toLowerCase().contains(cleanQuery);
      final matchesSubject = s.subjectInterests.any(
        (sub) => sub.toLowerCase().contains(cleanQuery),
      );

      if (matchesName || matchesBranch || matchesSubject) {
        items.add(
          SearchItem(
            type: 'student',
            id: s.authUserId.toString(),
            title: s.fullName,
            subtitle:
                '${s.branch} • Year ${s.academicYear} • ${s.hostelOrArea}',
            description: 'Interests: ${s.subjectInterests.join(', ')}',
            category: s.branch,
          ),
        );
      }
    }

    return SearchResponse(
      query: query,
      items: items.take(limit.clamp(1, 50)).toList(),
      totalCount: items.length,
    );
  }

  /// Submits a contact or support message.
  Future<bool> submitContact(
    Session session, {
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    if (name.trim().isEmpty || email.trim().isEmpty || message.trim().isEmpty) {
      throw ArgumentError('Name, email, and message are required.');
    }

    await ContactMessage.db.insertRow(
      session,
      ContactMessage(
        name: name.trim(),
        email: email.trim(),
        subject: subject.trim(),
        message: message.trim(),
        createdAt: DateTime.now().toUtc(),
      ),
    );

    return true;
  }
}
