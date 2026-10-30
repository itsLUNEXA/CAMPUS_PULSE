import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class ClubEndpoint extends Endpoint {
  /// Lists campus clubs with optional category filtering
  Future<List<CampusClub>> listClubs(
    Session session, {
    String? category,
  }) async {
    // If table is completely empty, populate realistic campus clubs
    final count = await CampusClub.db.count(session);
    if (count == 0) {
      await _seedDefaultClubs(session);
    }

    return await CampusClub.db.find(
      session,
      where: (t) {
        if (category != null && category.isNotEmpty && category != 'All') {
          return t.category.equals(category);
        }
        return Constant.bool(true);
      },
      orderBy: (t) => t.name,
    );
  }

  /// Get details of a single club
  Future<CampusClub?> getClub(Session session, int clubId) async {
    return await CampusClub.db.findById(session, clubId);
  }

  /// Submit a query request to either the Tech Team or Management Team of a club
  Future<ClubQueryRequest> submitClubQuery(
    Session session, {
    required int clubId,
    required String targetTeam, // 'Tech Team' or 'Management Team'
    required String category, // 'Recruitment', 'Project Collaboration', 'Event Query', 'Technical Doubt', 'Sponsorship'
    required String subject,
    required String message,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to submit club query.');
    }

    final club = await CampusClub.db.findById(session, clubId);
    if (club == null) {
      throw StateError('Club with ID $clubId not found.');
    }

    // Fetch student profile for sender details
    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );

    final senderName = profile?.fullName ?? 'Campus Student';
    final senderEmail = profile?.email ?? 'student@campus.edu';
    final senderBranch = profile?.branch ?? 'CSE';
    final senderYear = profile?.academicYear ?? 2;

    final now = DateTime.now().toUtc();
    final query = await ClubQueryRequest.db.insertRow(
      session,
      ClubQueryRequest(
        clubId: clubId,
        clubName: club.name,
        targetTeam: targetTeam,
        senderAuthUserId: callerId,
        senderName: senderName,
        senderEmail: senderEmail,
        senderBranch: senderBranch,
        senderYear: senderYear,
        category: category,
        subject: subject.trim(),
        message: message.trim(),
        status: 'PENDING',
        createdAt: now,
      ),
    );

    // Notify the student
    await CampusNotification.db.insertRow(
      session,
      CampusNotification(
        authUserId: callerId,
        title: 'Query Submitted to ${club.name}',
        message:
            'Your query regarding "$subject" was forwarded to the ${club.name} $targetTeam.',
        type: 'Clubs',
        targetRoute: 'clubs',
        targetId: clubId.toString(),
        isRead: false,
        createdAt: now,
      ),
    );

    return query;
  }

  /// Get all queries sent by the current student
  Future<List<ClubQueryRequest>> getMyClubQueries(Session session) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    return await ClubQueryRequest.db.find(
      session,
      where: (t) => t.senderAuthUserId.equals(callerId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Get queries submitted to a specific club (accessible to club leads and admins)
  Future<List<ClubQueryRequest>> getClubQueries(
    Session session, {
    int? clubId,
    String? targetTeam,
    String? status,
  }) async {
    return await ClubQueryRequest.db.find(
      session,
      where: (t) {
        Expression expr = Constant.bool(true);
        if (clubId != null) {
          expr = expr & t.clubId.equals(clubId);
        }
        if (targetTeam != null &&
            targetTeam.isNotEmpty &&
            targetTeam != 'All') {
          expr = expr & t.targetTeam.equals(targetTeam);
        }
        if (status != null && status.isNotEmpty && status != 'All') {
          expr = expr & t.status.equals(status);
        }
        return expr;
      },
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Respond to a student query
  Future<ClubQueryRequest> respondToClubQuery(
    Session session, {
    required int queryId,
    required String responseMessage,
    String? responderName,
  }) async {
    final query = await ClubQueryRequest.db.findById(session, queryId);
    if (query == null) {
      throw StateError('Query request with ID $queryId not found.');
    }

    final now = DateTime.now().toUtc();
    query.status = 'ANSWERED';
    query.responseMessage = responseMessage.trim();
    query.responderName = responderName ?? 'Club Coordinator';
    query.respondedAt = now;

    final updated = await ClubQueryRequest.db.updateRow(session, query);

    // Notify student about response
    await CampusNotification.db.insertRow(
      session,
      CampusNotification(
        authUserId: query.senderAuthUserId,
        title: '${query.clubName} (${query.targetTeam}) Answered Your Query',
        message: 'Re: ${query.subject} — "$responseMessage"',
        type: 'Clubs',
        targetRoute: 'clubs',
        targetId: query.clubId.toString(),
        isRead: false,
        createdAt: now,
      ),
    );

    return updated;
  }

  Future<void> _seedDefaultClubs(Session session) async {
    final now = DateTime.now().toUtc();
    final clubs = [
      CampusClub(
        name: 'ByteCraft — GDSC & Open Source Society',
        tagline: 'Building campus apps, open source tools, and cloud architectures',
        category: 'Technical',
        description:
            'The premier developer collective on campus. We organize hackathons, dev workshops on Flutter, Go, Cloud, and system design, and maintain open-source projects.',
        leadName: 'Rohan Verma',
        leadEmail: 'rohan.gdsc@campus.edu',
        techTeamLead: 'Aniket Sharma (Focus: Backend, Cloud & App Dev)',
        techTeamEmail: 'tech.bytecraft@campus.edu',
        managementLead: 'Ananya Sen (Focus: Hackathons, PR & Logistics)',
        managementEmail: 'mgmt.bytecraft@campus.edu',
        membersCount: 142,
        recruitmentOpen: true,
        meetingSchedule: 'Wednesdays & Saturdays @ 6:00 PM, Lab 4',
        createdAt: now,
      ),
      CampusClub(
        name: 'RoboPulse — Robotics & Mechatronics Society',
        tagline: 'Autonomous rovers, drone swarms, and embedded IoT hardware',
        category: 'Technical',
        description:
            'Hands-on engineering hub dedicated to competitive robotics (RoboWars, Maze Solvers, Drone League) and autonomous AI systems.',
        leadName: 'Vikram Malhotra',
        leadEmail: 'vikram.robo@campus.edu',
        techTeamLead: 'Harsh Vardhan (Focus: ROS2, SLAM, Embedded C & PCB)',
        techTeamEmail: 'tech.robopulse@campus.edu',
        managementLead: 'Shreya Das (Focus: Sponsorships, Lab Inventory & Expos)',
        managementEmail: 'mgmt.robopulse@campus.edu',
        membersCount: 98,
        recruitmentOpen: true,
        meetingSchedule: 'Tuesdays & Fridays @ 5:30 PM, Robotics Bay',
        createdAt: now,
      ),
      CampusClub(
        name: 'E-Cell — Entrepreneurship & Venture Cell',
        tagline: 'Incubating student founders, pitch decks, and angel connections',
        category: 'Management & Entrepreneurship',
        description:
            'Fostering startup spirit. We organize the Annual Campus E-Summit, founder fireside chats, seed grant competitions, and VC networking.',
        leadName: 'Kabir Mehta',
        leadEmail: 'kabir.ecell@campus.edu',
        techTeamLead: 'Tanmay Joshi (Focus: Founder portal & Tech stack advisory)',
        techTeamEmail: 'tech.ecell@campus.edu',
        managementLead: 'Ishita Kapoor (Focus: Investor relations & Event Operations)',
        managementEmail: 'mgmt.ecell@campus.edu',
        membersCount: 120,
        recruitmentOpen: false,
        meetingSchedule: 'Mondays @ 6:30 PM, Seminar Hall B',
        createdAt: now,
      ),
      CampusClub(
        name: 'Natraj — Cultural & Dramatics Society',
        tagline: 'Stage plays, street theatre (Nukkad Natak), scriptwriting and mime',
        category: 'Cultural & Arts',
        description:
            'Campus theatre and cultural heart. Multiple national trophy winners at inter-university fest circuits and annual campus productions.',
        leadName: 'Aryan Roy',
        leadEmail: 'aryan.theatre@campus.edu',
        techTeamLead: 'Rishi Patel (Focus: Stage acoustics, VFX & Dynamic lighting)',
        techTeamEmail: 'tech.natraj@campus.edu',
        managementLead: 'Simran Kaur (Focus: Production crew, ticketing & Media)',
        managementEmail: 'mgmt.natraj@campus.edu',
        membersCount: 85,
        recruitmentOpen: true,
        meetingSchedule: 'Daily 5:00 PM @ Open Air Amphitheatre',
        createdAt: now,
      ),
      CampusClub(
        name: 'FinPulse — Finance & Consulting Club',
        tagline: 'Equity research, case studies, algorithmic trading, and valuation',
        category: 'Management & Finance',
        description:
            'Analyzing market trends, consulting case-cracker bootcamps, and running the virtual campus student investment fund.',
        leadName: 'Kunal Singhania',
        leadEmail: 'kunal.fin@campus.edu',
        techTeamLead: 'Aditya Birla (Focus: Quant trading algorithms & Python backtesters)',
        techTeamEmail: 'tech.finpulse@campus.edu',
        managementLead: 'Meera Nair (Focus: Case competitions & Corporate outreach)',
        managementEmail: 'mgmt.finpulse@campus.edu',
        membersCount: 76,
        recruitmentOpen: true,
        meetingSchedule: 'Thursdays @ 6:00 PM, Management Block CR-2',
        createdAt: now,
      ),
    ];

    for (final c in clubs) {
      await CampusClub.db.insertRow(session, c);
    }
  }
}
