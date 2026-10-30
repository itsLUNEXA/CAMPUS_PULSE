import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import '../generated/protocol.dart';

class InterviewPrepEndpoint extends Endpoint {
  /// Lists all campus companies visiting for placements and internships
  Future<List<CampusCompany>> listCompanies(Session session) async {
    final count = await CampusCompany.db.count(session);
    if (count == 0) {
      await _seedDefaultCompanies(session);
    }

    return await CampusCompany.db.find(
      session,
      orderBy: (t) => t.avgPackageLpa.desc(),
    );
  }

  /// Lists senior interview experiences with questions and round breakdowns
  Future<List<SeniorExperience>> listSeniorExperiences(
    Session session, {
    String? companyName,
  }) async {
    final count = await SeniorExperience.db.count(session);
    if (count == 0) {
      await _seedDefaultExperiences(session);
    }

    return await SeniorExperience.db.find(
      session,
      where: (t) {
        if (companyName != null &&
            companyName.isNotEmpty &&
            companyName != 'All') {
          return t.companyName.equals(companyName);
        }
        return Constant.bool(true);
      },
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Request a personalized 1-on-1 mock interview with an experienced campus senior
  Future<MockInterviewSlot> requestMockInterview(
    Session session, {
    required String targetCompany,
    required String targetRole,
    required String mockRound, // 'Coding & DSA', 'System Design & Core CS', 'HR & Resume Walkthrough'
    required DateTime preferredDate,
    String? resumeUrl,
    String? notes,
  }) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) {
      throw StateError('Authentication required to request a mock interview.');
    }

    final profile = await StudentProfile.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(callerId),
    );

    final studentName = profile?.fullName ?? 'Campus Student';
    final studentEmail = profile?.email ?? 'student@campus.edu';

    final now = DateTime.now().toUtc();
    final slot = await MockInterviewSlot.db.insertRow(
      session,
      MockInterviewSlot(
        studentAuthUserId: callerId,
        studentName: studentName,
        studentEmail: studentEmail,
        targetCompany: targetCompany,
        targetRole: targetRole,
        mockRound: mockRound,
        preferredDate: preferredDate,
        resumeUrl: resumeUrl,
        notes: notes,
        status: 'REQUESTED',
        createdAt: now,
      ),
    );

    // Notify the student
    await CampusNotification.db.insertRow(
      session,
      CampusNotification(
        authUserId: callerId,
        title: 'Mock Interview Requested: $targetCompany',
        message:
            'Your $mockRound mock interview request for $targetCompany has been queued. A senior mentor will be assigned shortly.',
        type: 'Placements',
        targetRoute: 'interview_prep',
        targetId: slot.id.toString(),
        isRead: false,
        createdAt: now,
      ),
    );

    return slot;
  }

  /// Get mock interview slots booked by current student
  Future<List<MockInterviewSlot>> getMyMockInterviewSlots(
    Session session,
  ) async {
    final callerId = session.authenticated?.authUserId;
    if (callerId == null) return [];

    return await MockInterviewSlot.db.find(
      session,
      where: (t) => t.studentAuthUserId.equals(callerId),
      orderBy: (t) => t.createdAt.desc(),
    );
  }

  /// Update mock interview status (assign mentor, meeting link, or feedback)
  Future<MockInterviewSlot> updateMockInterviewStatus(
    Session session, {
    required int slotId,
    required String status,
    String? seniorMentorName,
    String? meetingLink,
    String? feedbackNotes,
  }) async {
    final slot = await MockInterviewSlot.db.findById(session, slotId);
    if (slot == null) {
      throw StateError('Mock interview slot #$slotId not found.');
    }

    slot.status = status;
    if (seniorMentorName != null) slot.seniorMentorName = seniorMentorName;
    if (meetingLink != null) slot.meetingLink = meetingLink;
    if (feedbackNotes != null) slot.feedbackNotes = feedbackNotes;

    final updated = await MockInterviewSlot.db.updateRow(session, slot);

    // Send update notification to student
    final now = DateTime.now().toUtc();
    await CampusNotification.db.insertRow(
      session,
      CampusNotification(
        authUserId: slot.studentAuthUserId,
        title: 'Mock Interview Status: $status (${slot.targetCompany})',
        message: seniorMentorName != null
            ? 'Senior mentor $seniorMentorName was assigned! Join link: ${meetingLink ?? "Check your portal"}'
            : 'Your mock session status was updated to $status.',
        type: 'Placements',
        targetRoute: 'interview_prep',
        targetId: slot.id.toString(),
        isRead: false,
        createdAt: now,
      ),
    );

    return updated;
  }

  Future<void> _seedDefaultCompanies(Session session) async {
    final now = DateTime.now().toUtc();
    final companies = [
      CampusCompany(
        name: 'Microsoft',
        tier: 'Dream (₹44.0 LPA)',
        avgPackageLpa: 44.0,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        cgpaCutoff: 7.5,
        hiringRounds: [
          'Round 1: Online Coding Assessment (3 LeetCode Mediums on Codility)',
          'Round 2: Technical Interview 1 (Binary Trees, Graphs & Recursion)',
          'Round 3: Technical Interview 2 (OS Internals, LRU Cache, Concurrency)',
          'Round 4: AA / Leadership Fitment (Project Architecture & Cultural Fit)',
        ],
        keyFocusAreas: [
          'Trees & Graphs (BFS/DFS, Topological Sort)',
          'Dynamic Programming (2D memoization)',
          'Operating Systems (Paging, Thread synchronization, Deadlocks)',
          'Database Indexing (B-Trees vs Hash)',
        ],
        description:
            'Regular campus day-1 recruiter hiring for SDE-1 (Redmond & IDC Hyderabad/Bangalore). Extremely structured hiring with high emphasis on code clarity and clean edge-case handling.',
        createdAt: now,
      ),
      CampusCompany(
        name: 'Amazon',
        tier: 'Dream (₹32.0 LPA)',
        avgPackageLpa: 32.0,
        eligibleBranches: ['CSE', 'IT', 'ECE', 'Mechanical', 'Civil'],
        cgpaCutoff: 7.0,
        hiringRounds: [
          'Round 1: Online Assessment (2 Coding Questions + Work Style Simulation)',
          'Round 2: Technical Round 1 (Data Structures: Heaps, HashMaps, Sliding Window)',
          'Round 3: Technical Round 2 (OOPs, Low-Level Design & System Modularity)',
          'Round 4: Bar Raiser (Deep dive on 16 Leadership Principles in STAR format)',
        ],
        keyFocusAreas: [
          '16 Amazon Leadership Principles (Customer Obsession, Ownership)',
          'Heap, PriorityQueue, Trie',
          'Low-Level Design (Design an Elevator, Parking Lot, Rate Limiter)',
          'Object-Oriented Design Principles (SOLID)',
        ],
        description:
            'Major campus hiring partner. Every single interview round devotes 20 minutes to behavioral questions mapped to Amazon Leadership Principles.',
        createdAt: now,
      ),
      CampusCompany(
        name: 'Cisco',
        tier: 'Super Dream (₹18.5 LPA)',
        avgPackageLpa: 18.5,
        eligibleBranches: ['CSE', 'IT', 'ECE'],
        cgpaCutoff: 7.0,
        hiringRounds: [
          'Round 1: Online Test (Aptitude, Networking Fundamentals, 2 Coding)',
          'Round 2: Technical Interview 1 (Computer Networks, TCP/IP, OSI, Sockets)',
          'Round 3: Technical Interview 2 (C/C++ Pointers, Memory leaks, OS)',
          'Round 4: Managerial & HR Interview',
        ],
        keyFocusAreas: [
          'Computer Networks (TCP 3-way handshake, Subnetting, DNS, HTTP/HTTPS)',
          'C/C++ memory management and pointer arithmetic',
          'Data Structures (Linked Lists, Bit Manipulation)',
          'Linux Command Line & Shell scripting',
        ],
        description:
            'Focuses heavily on core Computer Networks, OS, and C/C++ alongside algorithmic problem solving for Bangalore campus positions.',
        createdAt: now,
      ),
      CampusCompany(
        name: 'TCS Digital / Prime',
        tier: 'Core / Mass (₹9.0 LPA)',
        avgPackageLpa: 9.0,
        eligibleBranches: ['All Engineering Branches'],
        cgpaCutoff: 6.5,
        hiringRounds: [
          'Round 1: TCS National Qualifier Test (Cognitive + Advanced Coding)',
          'Round 2: Technical Interview (DSA Basics, Final Year Project, SQL)',
          'Round 3: Managerial & HR Round',
        ],
        keyFocusAreas: [
          'Core Java / Python / C++',
          'SQL Joins, Group By, Subqueries, Normalization',
          'Academic and Capstone Projects walkthrough',
          'Basic DSA (Strings, Arrays, Sorting)',
        ],
        description:
            'Top campus volume hiring partner for Digital and Prime roles. Focuses on project ownership, database query skills, and basic algorithmic thinking.',
        createdAt: now,
      ),
      CampusCompany(
        name: 'Zomato',
        tier: 'Dream (₹28.0 LPA)',
        avgPackageLpa: 28.0,
        eligibleBranches: ['CSE', 'IT'],
        cgpaCutoff: 7.0,
        hiringRounds: [
          'Round 1: Machine Coding Round (Implement an in-memory Food Delivery backend)',
          'Round 2: Data Structures & Algorithms (Hard DP, Graph shortest paths)',
          'Round 3: System Design & Scaling (Caching, DB sharding, Redis)',
          'Round 4: Cultural & Founder Fitment',
        ],
        keyFocusAreas: [
          'Machine Coding (Clean code, separation of concerns, concurrency)',
          'High Level System Design',
          'High-throughput Redis and Message Queue architectures (Kafka/RabbitMQ)',
          'Clean Git & API design',
        ],
        description:
            'Recruits high-caliber engineering interns and full-time SDEs. High emphasis on functional, bug-free Machine Coding rounds.',
        createdAt: now,
      ),
    ];

    for (final c in companies) {
      await CampusCompany.db.insertRow(session, c);
    }
  }

  Future<void> _seedDefaultExperiences(Session session) async {
    final now = DateTime.now().toUtc();
    final experiences = [
      SeniorExperience(
        companyName: 'Microsoft',
        seniorName: 'Aarav Sharma',
        seniorBranch: 'CSE (2025 Batch)',
        batchYear: 2025,
        placedRole: 'Software Development Engineer - 1',
        packageOffered: '₹44.0 LPA',
        difficultyRating: 4,
        interviewQuestions: [
          'Design an LRU Cache with O(1) get and put operations (Write complete runnable code).',
          'Word Ladder II: Find all shortest transformation sequences from beginWord to endWord.',
          'Explain difference between process vs thread, virtual memory paging, and deadlock avoidance (Banker\'s Algorithm).',
          'Given a binary tree, serialize it to string and deserialize it back without losing structure.',
        ],
        experienceReview:
            'The interviewers in Microsoft IDC were super friendly. In Technical Round 1, the interviewer asked me to think aloud before writing a single line of code. They looked for modular code, descriptive variable names, and handling null/empty inputs. In Round 2, half the time went into OS fundamentals like semaphores and mutexes.',
        tipsForJuniors:
            '1. Master Trees and Graphs thoroughly; Microsoft loves them.\n2. Do not hesitate to ask clarifying questions about edge cases.\n3. Revise Galvin Operating Systems Unit 1-4 (scheduling & memory management).',
        contactHandle: 'linkedin.com/in/aarav-sharma-dev',
        verified: true,
        createdAt: now,
      ),
      SeniorExperience(
        companyName: 'Amazon',
        seniorName: 'Neha Gupta',
        seniorBranch: 'IT (2025 Batch)',
        batchYear: 2025,
        placedRole: 'Software Development Engineer - 1',
        packageOffered: '₹32.0 LPA',
        difficultyRating: 4,
        interviewQuestions: [
          'Find median in a running data stream of integers (Dual Heap approach).',
          'Design an Amazon Locker delivery dispatch system with low-level OOP class diagrams.',
          'Tell me about a time when you had to make a tough technical trade-off under a tight deadline (LP: Bias for Action).',
          'Rotting Oranges / Multi-source BFS matrix problem.',
        ],
        experienceReview:
            'Every single round at Amazon begins with 20 minutes of behavioral questions based on their 16 Leadership Principles. Even if your code is 100% correct, failing to demonstrate "Customer Obsession" or "Ownership" can lead to rejection.',
        tipsForJuniors:
            '1. Prepare 5-6 structured stories from your academic/internship projects in the STAR format (Situation, Task, Action, Result).\n2. Practice Low-Level Design (SOLID principles).\n3. Keep calm in the Bar Raiser round; they test your composure under pressure.',
        contactHandle: 'linkedin.com/in/neha-gupta-tech',
        verified: true,
        createdAt: now,
      ),
      SeniorExperience(
        companyName: 'Cisco',
        seniorName: 'Tanmay Joshi',
        seniorBranch: 'ECE (2025 Batch)',
        batchYear: 2025,
        placedRole: 'Software Engineer (Enterprise Routing)',
        packageOffered: '₹18.5 LPA',
        difficultyRating: 3,
        interviewQuestions: [
          'Explain the complete packet life-cycle when you type "https://google.com" in a web browser (DNS, ARP, TCP, TLS, HTTP).',
          'How does subnetting work? Divide 192.168.1.0/24 into 4 equal subnets.',
          'Detect and remove loop in a singly linked list (Floyd\'s Cycle Finding algorithm).',
          'What are dangling pointers and memory leaks in C++? How do Smart Pointers prevent them?',
        ],
        experienceReview:
            'For ECE and CSE students alike, Cisco focuses on Computer Networks and C/C++ core fundamentals. The technical panel asked me to sketch TCP packet headers and calculate subnet masks on paper.',
        tipsForJuniors:
            '1. Read Kurose-Ross or Forouzan for Computer Networks.\n2. Know the difference between TCP vs UDP and state transitions.\n3. Brush up C/C++ pointer manipulation.',
        contactHandle: 'linkedin.com/in/tanmay-joshi-cisco',
        verified: true,
        createdAt: now,
      ),
      SeniorExperience(
        companyName: 'TCS Digital / Prime',
        seniorName: 'Sahil Deshmukh',
        seniorBranch: 'CSE (2025 Batch)',
        batchYear: 2025,
        placedRole: 'Prime Systems Engineer',
        packageOffered: '₹9.0 LPA',
        difficultyRating: 2,
        interviewQuestions: [
          'Explain the architecture and database schema of your 6th-semester project.',
          'Write a SQL query to find the 2nd highest salary using Dense_Rank and Subquery.',
          'Explain Polymorphism and how Method Overriding differs from Method Overloading in Java.',
          'Find the first non-repeating character in a string in O(n) time.',
        ],
        experienceReview:
            'The TCS Digital interview was focused on basic problem-solving, project authenticity, and database queries. The panel went line-by-line over my resume projects and asked why I chose MySQL over MongoDB.',
        tipsForJuniors:
            '1. Know every single detail mentioned on your resume.\n2. Practice SQL joins and aggregate functions.\n3. Maintain confidence and clear communication.',
        contactHandle: 'linkedin.com/in/sahil-deshmukh-tcs',
        verified: true,
        createdAt: now,
      ),
    ];

    for (final exp in experiences) {
      await SeniorExperience.db.insertRow(session, exp);
    }
  }
}
