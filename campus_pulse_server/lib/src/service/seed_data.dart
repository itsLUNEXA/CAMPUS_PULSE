import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SeedService {
  static String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  static Future<void> seedAll(Session session) async {
    await seedStudents(session);
    await seedEvents(session);
    await seedQuizQuestions(session);
    await seedInitialScoresAndRequests(session);
  }

  static Future<void> seedStudents(Session session) async {
    final count = await Student.db.count(session);
    if (count > 0) return;

    final defaultPassword = hashPassword('campus123');

    final students = [
      Student(
        name: 'Aarav Sharma',
        email: 'aarav@campus.edu',
        passwordHash: defaultPassword,
        branch: 'Computer Science',
        year: 3,
        interests: ['DSA', 'AI', 'DBMS', 'Web3'],
        hostelArea: 'Hostel Block A',
      ),
      Student(
        name: 'Priya Patel',
        email: 'priya@campus.edu',
        passwordHash: defaultPassword,
        branch: 'Information Technology',
        year: 2,
        interests: ['OS', 'DBMS', 'Networks', 'Flutter'],
        hostelArea: 'Girls Hostel 2',
      ),
      Student(
        name: 'Rohan Verma',
        email: 'rohan@campus.edu',
        passwordHash: defaultPassword,
        branch: 'Mechanical Eng.',
        year: 4,
        interests: ['Robotics', 'Mathematics', 'DSA'],
        hostelArea: 'Hostel Block B',
      ),
      Student(
        name: 'Ananya Iyer',
        email: 'ananya@campus.edu',
        passwordHash: defaultPassword,
        branch: 'Electronics & Comm.',
        year: 3,
        interests: ['Embedded Systems', 'OS', 'DSA', 'AI'],
        hostelArea: 'Girls Hostel 1',
      ),
      Student(
        name: 'Kabir Singh',
        email: 'kabir@campus.edu',
        passwordHash: defaultPassword,
        branch: 'Civil Eng.',
        year: 2,
        interests: ['Mathematics', 'DBMS', 'Physics'],
        hostelArea: 'Hostel Block C',
      ),
    ];

    for (final s in students) {
      await Student.db.insertRow(session, s);
    }
  }

  static Future<void> seedEvents(Session session) async {
    final count = await CampusEvent.db.count(session);
    if (count > 0) return;

    final now = DateTime.now();

    final events = [
      CampusEvent(
        title: "PulseHack '26 - 36hr Hackathon",
        description: 'Build futuristic mobile and web dApps. Prizes worth ₹2,00,000!',
        category: 'Tech',
        venue: 'Computer Center & Auditorium',
        startTime: now.add(const Duration(days: 2, hours: 4)),
        createdBy: 'Campus Tech Council',
        rsvpCount: 42,
      ),
      CampusEvent(
        title: 'AI & Generative Agents Workshop',
        description: 'Hands-on masterclass building LLM tool agents and embeddings.',
        category: 'Workshop',
        venue: 'Seminar Hall 3, IT Block',
        startTime: now.add(const Duration(days: 3, hours: 2)),
        createdBy: 'AI Research Club',
        rsvpCount: 28,
      ),
      CampusEvent(
        title: 'Inter-Hostel Cricket Derby',
        description: 'High-voltage clash: Block A Titans vs Block B Warriors under floodlights.',
        category: 'Sports',
        venue: 'Main University Ground',
        startTime: now.add(const Duration(days: 1, hours: 6)),
        createdBy: 'Sports Committee',
        rsvpCount: 65,
      ),
      CampusEvent(
        title: 'Spandan: Annual Cultural Night',
        description: 'Dance, music concerts, and drama performances across universities.',
        category: 'Cultural',
        venue: 'Open Air Amphitheatre',
        startTime: now.add(const Duration(days: 5, hours: 8)),
        createdBy: 'Cultural Council',
        rsvpCount: 110,
      ),
      CampusEvent(
        title: 'Cloud & Docker DevOps Bootcamp',
        description: 'Learn containerization, CI/CD pipelines, and cloud deployment secrets.',
        category: 'Workshop',
        venue: 'Lab 4, Tech Block',
        startTime: now.add(const Duration(days: 4, hours: 1)),
        createdBy: 'Developer Student Club',
        rsvpCount: 19,
      ),
      CampusEvent(
        title: 'Campus Esports Championship (Valorant & BGMI)',
        description: 'Compete for the ultimate gaming trophy and streaming gear.',
        category: 'Sports',
        venue: 'Student Activity Center',
        startTime: now.add(const Duration(days: 6, hours: 5)),
        createdBy: 'Gaming Guild',
        rsvpCount: 54,
      ),
      CampusEvent(
        title: 'Startup Pitch Arena 2026',
        description: 'Pitch your breakthrough startup idea to top angel investors & alumni.',
        category: 'Tech',
        venue: 'Incubation Center Lounge',
        startTime: now.add(const Duration(days: 7, hours: 3)),
        createdBy: 'E-Cell',
        rsvpCount: 35,
      ),
      CampusEvent(
        title: 'Battle of the Bands',
        description: 'Rock, fusion, and indie bands battling live for the campus crown.',
        category: 'Cultural',
        venue: 'University Auditorium',
        startTime: now.add(const Duration(days: 8, hours: 7)),
        createdBy: 'Music Club',
        rsvpCount: 78,
      ),
      CampusEvent(
        title: 'Competitive Coding Sprint',
        description: '2-hour speed coding round covering DSA, dynamic programming, and graphs.',
        category: 'Tech',
        venue: 'CSE Lab 2',
        startTime: now.add(const Duration(days: 3, hours: 5)),
        createdBy: 'ACM Student Chapter',
        rsvpCount: 46,
      ),
      CampusEvent(
        title: 'Badminton Doubles Cup',
        description: 'Smash your way to victory in the annual campus badminton tournament.',
        category: 'Sports',
        venue: 'Indoor Sports Arena Court 2',
        startTime: now.add(const Duration(days: 4, hours: 9)),
        createdBy: 'Sports Committee',
        rsvpCount: 22,
      ),
    ];

    for (final e in events) {
      await CampusEvent.db.insertRow(session, e);
    }
  }

  static Future<void> seedQuizQuestions(Session session) async {
    final count = await QuizQuestion.db.count(session);
    if (count > 0) return;

    final questions = [
      // DBMS Questions (5)
      QuizQuestion(
        subject: 'DBMS',
        question: 'Which ACID property guarantees that either all database operations succeed or none do?',
        options: ['Atomicity', 'Consistency', 'Isolation', 'Durability'],
        correctIndex: 0,
      ),
      QuizQuestion(
        subject: 'DBMS',
        question: 'Which normal form addresses and eliminates transitive functional dependencies?',
        options: ['1NF', '2NF', '3NF', 'BCNF'],
        correctIndex: 2,
      ),
      QuizQuestion(
        subject: 'DBMS',
        question: 'Which SQL clause is used to filter results after an aggregation using GROUP BY?',
        options: ['WHERE', 'HAVING', 'ORDER BY', 'FILTER'],
        correctIndex: 1,
      ),
      QuizQuestion(
        subject: 'DBMS',
        question: 'What data structure is standard for high-performance multi-level database indexing?',
        options: ['B+ Tree', 'Hash Map', 'Trie', 'Binary Search Tree'],
        correctIndex: 0,
      ),
      QuizQuestion(
        subject: 'DBMS',
        question: 'Which transaction isolation level prevents "dirty reads" by disallowing uncommitted read data?',
        options: ['Read Uncommitted', 'Read Committed', 'Repeatable Read', 'Serializable'],
        correctIndex: 1,
      ),

      // OS Questions (5)
      QuizQuestion(
        subject: 'OS',
        question: 'Which condition is NOT a required Coffman condition for a deadlock to occur?',
        options: ['Mutual Exclusion', 'Hold and Wait', 'Preemption Allowed', 'Circular Wait'],
        correctIndex: 2,
      ),
      QuizQuestion(
        subject: 'OS',
        question: "Which page replacement algorithm suffers from Belady's Anomaly where more frames can cause more faults?",
        options: ['LRU', 'FIFO', 'Optimal', 'LFU'],
        correctIndex: 1,
      ),
      QuizQuestion(
        subject: 'OS',
        question: 'What is the primary function of the Translation Lookaside Buffer (TLB)?',
        options: ['Cache virtual-to-physical address translations', 'Schedule CPU burst threads', 'Manage disk block allocations', 'Prevent buffer overflow'],
        correctIndex: 0,
      ),
      QuizQuestion(
        subject: 'OS',
        question: 'Which resource is shared among all threads of the same parent process?',
        options: ['CPU Registers', 'Call Stack', 'Address Space and Code', 'Thread ID'],
        correctIndex: 2,
      ),
      QuizQuestion(
        subject: 'OS',
        question: 'A counting semaphore initialized to 5 allows how many processes into the critical region concurrently?',
        options: ['1', '5', 'Unlimited', '0'],
        correctIndex: 1,
      ),

      // DSA Questions (5)
      QuizQuestion(
        subject: 'DSA',
        question: 'What is the average time complexity of searching in a Balanced Binary Search Tree (AVL/Red-Black)?',
        options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
        correctIndex: 1,
      ),
      QuizQuestion(
        subject: 'DSA',
        question: 'Which data structure is standard for implementing Breadth-First Search (BFS) in a graph?',
        options: ['Stack', 'Queue', 'Priority Queue', 'Disjoint Set'],
        correctIndex: 1,
      ),
      QuizQuestion(
        subject: 'DSA',
        question: 'What is the worst-case time complexity of QuickSort when bad pivots are repeatedly chosen?',
        options: ['O(n log n)', 'O(n)', 'O(n²)', 'O(2ⁿ)'],
        correctIndex: 2,
      ),
      QuizQuestion(
        subject: 'DSA',
        question: 'Which algorithm design paradigm solves subproblems only once and stores their solutions in a table?',
        options: ['Divide and Conquer', 'Greedy Method', 'Dynamic Programming', 'Backtracking'],
        correctIndex: 2,
      ),
      QuizQuestion(
        subject: 'DSA',
        question: 'What is the minimum number of queues required to implement a FIFO Stack?',
        options: ['1', '2', '3', '4'],
        correctIndex: 1,
      ),
    ];

    for (final q in questions) {
      await QuizQuestion.db.insertRow(session, q);
    }
  }

  static Future<void> seedInitialScoresAndRequests(Session session) async {
    final scoreCount = await QuizScore.db.count(session);
    if (scoreCount == 0) {
      final now = DateTime.now();
      final sampleScores = [
        QuizScore(studentId: 1, subject: 'DSA', score: 5, createdAt: now.subtract(const Duration(hours: 2))),
        QuizScore(studentId: 2, subject: 'DBMS', score: 4, createdAt: now.subtract(const Duration(hours: 3))),
        QuizScore(studentId: 4, subject: 'OS', score: 5, createdAt: now.subtract(const Duration(hours: 5))),
        QuizScore(studentId: 3, subject: 'DSA', score: 4, createdAt: now.subtract(const Duration(hours: 8))),
        QuizScore(studentId: 5, subject: 'DBMS', score: 3, createdAt: now.subtract(const Duration(hours: 12))),
      ];
      for (final sc in sampleScores) {
        await QuizScore.db.insertRow(session, sc);
      }
    }

    final reqCount = await StudyRequest.db.count(session);
    if (reqCount == 0) {
      final now = DateTime.now();
      final sampleRequests = [
        StudyRequest(
          studentId: 1,
          studentName: 'Aarav Sharma',
          branch: 'Computer Science',
          subject: 'DSA',
          location: 'Hostel Block A Study Room',
          status: 'open',
          createdAt: now.subtract(const Duration(hours: 1)),
        ),
        StudyRequest(
          studentId: 2,
          studentName: 'Priya Patel',
          branch: 'Information Technology',
          subject: 'DBMS',
          location: 'Girls Hostel 2 Library',
          status: 'open',
          createdAt: now.subtract(const Duration(hours: 4)),
        ),
      ];
      for (final r in sampleRequests) {
        await StudyRequest.db.insertRow(session, r);
      }
    }
  }
}
