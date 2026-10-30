import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:campus_pulse_flutter/client.dart';
import 'package:campus_pulse_flutter/screens/campus_clubs_screen.dart';
import 'package:campus_pulse_flutter/screens/interview_prep_screen.dart';
import 'package:campus_pulse_flutter/services/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    try {
      client = Client('http://localhost:8080/')
        ..authSessionManager = FlutterAuthSessionManager();
    } catch (_) {}
  });

  group('Campus Clubs & Team Query Flow Tests', () {
    test('CampusClub data model captures Tech and Management leads and contacts', () {
      final club = CampusClub(
        id: 1,
        name: 'ByteCraft — GDSC',
        tagline: 'Building campus apps',
        category: 'Technical',
        description: 'Developer society',
        leadName: 'Rohan Verma',
        leadEmail: 'rohan.gdsc@campus.edu',
        techTeamLead: 'Aniket Sharma',
        techTeamEmail: 'tech.bytecraft@campus.edu',
        managementLead: 'Ananya Sen',
        managementEmail: 'mgmt.bytecraft@campus.edu',
        membersCount: 142,
        recruitmentOpen: true,
        createdAt: DateTime.now(),
      );

      expect(club.name, contains('ByteCraft'));
      expect(club.techTeamLead, 'Aniket Sharma');
      expect(club.managementLead, 'Ananya Sen');
      expect(club.recruitmentOpen, isTrue);
    });

    test('ClubQueryRequest routes to Tech Team or Management Team', () {
      final query = ClubQueryRequest(
        id: 10,
        clubId: 1,
        clubName: 'ByteCraft — GDSC',
        targetTeam: 'Tech Team',
        senderAuthUserId: UuidValue.fromString('11111111-1111-1111-1111-111111111111'),
        senderName: 'Aarav Sharma',
        senderEmail: 'aarav@campus.edu',
        senderBranch: 'CSE',
        senderYear: 3,
        category: 'Project Collaboration',
        subject: 'Joint Flutter & Backend Hackathon Project',
        message: 'Would love to collaborate on the campus event tracker app.',
        status: 'PENDING',
        createdAt: DateTime.now(),
      );

      expect(query.targetTeam, 'Tech Team');
      expect(query.status, 'PENDING');
      expect(query.senderBranch, 'CSE');
    });

    testWidgets('CampusClubsScreen renders header and Discover Clubs tab', (tester) async {
      final authState = AuthState();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CampusClubsScreen(
              authState: authState,
              onBackToHome: () {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Campus Clubs & Societies'), findsOneWidget);
      expect(find.textContaining('Discover Clubs'), findsOneWidget);
      expect(find.textContaining('My Query Requests'), findsOneWidget);
    });
  });

  group('Mock Interview & Campus Company Prep Tests', () {
    test('CampusCompany model holds CTC, cutoffs, and hiring rounds', () {
      final company = CampusCompany(
        id: 1,
        name: 'Microsoft',
        tier: 'Dream (₹44.0 LPA)',
        avgPackageLpa: 44.0,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        cgpaCutoff: 7.5,
        hiringRounds: [
          'Round 1: Online Coding Assessment',
          'Round 2: Technical Interview 1 (DSA)',
          'Round 3: Technical Interview 2 (OS Internals)',
        ],
        keyFocusAreas: ['Trees & Graphs', 'OS Paging', 'LRU Cache'],
        description: 'Day-1 campus recruiter hiring for SDE-1.',
        createdAt: DateTime.now(),
      );

      expect(company.name, 'Microsoft');
      expect(company.avgPackageLpa, 44.0);
      expect(company.cgpaCutoff, 7.5);
      expect(company.hiringRounds.length, 3);
    });

    test('SeniorExperience captures actual interview questions and senior tips', () {
      final exp = SeniorExperience(
        id: 5,
        companyName: 'Microsoft',
        seniorName: 'Aarav Sharma',
        seniorBranch: 'CSE (2025 Batch)',
        batchYear: 2025,
        placedRole: 'SDE-1',
        packageOffered: '₹44.0 LPA',
        difficultyRating: 4,
        interviewQuestions: [
          'Design an LRU Cache in O(1)',
          'Word Ladder II shortest path',
        ],
        experienceReview: 'Very friendly panel. Focus on think-aloud problem solving.',
        tipsForJuniors: 'Revise Galvin Operating Systems Unit 1-4 and Graphs.',
        verified: true,
        createdAt: DateTime.now(),
      );

      expect(exp.seniorName, 'Aarav Sharma');
      expect(exp.difficultyRating, 4);
      expect(exp.interviewQuestions, contains('Design an LRU Cache in O(1)'));
      expect(exp.verified, isTrue);
    });

    testWidgets('InterviewPrepScreen renders tabs and Book Senior Mock button', (tester) async {
      final authState = AuthState();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: InterviewPrepScreen(
              authState: authState,
              onBackToHome: () {},
            ),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Campus Placement & Mock Hub'), findsOneWidget);
      expect(find.textContaining('Campus Companies'), findsOneWidget);
      expect(find.textContaining('Senior Experiences'), findsOneWidget);
      expect(find.textContaining('My Mock Sessions'), findsOneWidget);
      expect(find.text('Book Senior Mock'), findsOneWidget);
    });
  });
}

