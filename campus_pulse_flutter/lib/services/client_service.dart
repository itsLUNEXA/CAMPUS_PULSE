import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'auth_state.dart';

class ClientService {
  static final ClientService instance = ClientService._();
  ClientService._() {
    _initClient();
  }

  late final Client client;
  final StreamController<RsvpUpdate> _rsvpStreamController =
      StreamController<RsvpUpdate>.broadcast();
  final StreamController<LeaderboardEntry> _leaderboardStreamController =
      StreamController<LeaderboardEntry>.broadcast();

  Stream<RsvpUpdate> get rsvpUpdates => _rsvpStreamController.stream;
  Stream<LeaderboardEntry> get leaderboardUpdates =>
      _leaderboardStreamController.stream;

  // In-memory fallback dataset for seamless offline / instant preview
  final List<CampusEvent> _localEvents = [];
  final List<Student> _localStudents = [];
  final List<StudyRequest> _localStudyRequests = [];
  final List<LeaderboardEntry> _localLeaderboard = [];
  final Map<String, List<QuizQuestion>> _localQuestions = {};

  void _initClient() {
    client = Client(
      'http://localhost:8080/',
    );

    _initLocalSeedFallback();
  }

  void _initLocalSeedFallback() {
    final now = DateTime.now();

    _localStudents.addAll([
      Student(
        id: 1,
        name: 'Aarav Sharma',
        email: 'aarav@campus.edu',
        branch: 'Computer Science',
        year: 3,
        interests: ['DSA', 'AI', 'DBMS', 'Web3'],
        hostelArea: 'Hostel Block A',
      ),
      Student(
        id: 2,
        name: 'Priya Patel',
        email: 'priya@campus.edu',
        branch: 'Information Technology',
        year: 2,
        interests: ['OS', 'DBMS', 'Networks', 'Flutter'],
        hostelArea: 'Girls Hostel 2',
      ),
      Student(
        id: 3,
        name: 'Rohan Verma',
        email: 'rohan@campus.edu',
        branch: 'Mechanical Eng.',
        year: 4,
        interests: ['Robotics', 'Mathematics', 'DSA'],
        hostelArea: 'Hostel Block B',
      ),
      Student(
        id: 4,
        name: 'Ananya Iyer',
        email: 'ananya@campus.edu',
        branch: 'Electronics & Comm.',
        year: 3,
        interests: ['Embedded Systems', 'OS', 'DSA', 'AI'],
        hostelArea: 'Girls Hostel 1',
      ),
      Student(
        id: 5,
        name: 'Kabir Singh',
        email: 'kabir@campus.edu',
        branch: 'Civil Eng.',
        year: 2,
        interests: ['Mathematics', 'DBMS', 'Physics'],
        hostelArea: 'Hostel Block C',
      ),
    ]);

    _localEvents.addAll([
      CampusEvent(
        id: 1,
        title: "PulseHack '26 - 36hr Hackathon",
        description: 'Build futuristic mobile and web dApps. Prizes worth ₹2,00,000!',
        category: 'Tech',
        venue: 'Computer Center & Auditorium',
        startTime: now.add(const Duration(days: 2, hours: 4)),
        createdBy: 'Campus Tech Council',
        rsvpCount: 42,
      ),
      CampusEvent(
        id: 2,
        title: 'AI & Generative Agents Workshop',
        description: 'Hands-on masterclass building LLM tool agents and embeddings.',
        category: 'Workshop',
        venue: 'Seminar Hall 3, IT Block',
        startTime: now.add(const Duration(days: 3, hours: 2)),
        createdBy: 'AI Research Club',
        rsvpCount: 28,
      ),
      CampusEvent(
        id: 3,
        title: 'Inter-Hostel Cricket Derby',
        description: 'High-voltage clash: Block A Titans vs Block B Warriors under floodlights.',
        category: 'Sports',
        venue: 'Main University Ground',
        startTime: now.add(const Duration(days: 1, hours: 6)),
        createdBy: 'Sports Committee',
        rsvpCount: 65,
      ),
      CampusEvent(
        id: 4,
        title: 'Spandan: Annual Cultural Night',
        description: 'Dance, music concerts, and drama performances across universities.',
        category: 'Cultural',
        venue: 'Open Air Amphitheatre',
        startTime: now.add(const Duration(days: 5, hours: 8)),
        createdBy: 'Cultural Council',
        rsvpCount: 110,
      ),
      CampusEvent(
        id: 5,
        title: 'Cloud & Docker DevOps Bootcamp',
        description: 'Learn containerization, CI/CD pipelines, and cloud deployment secrets.',
        category: 'Workshop',
        venue: 'Lab 4, Tech Block',
        startTime: now.add(const Duration(days: 4, hours: 1)),
        createdBy: 'Developer Student Club',
        rsvpCount: 19,
      ),
      CampusEvent(
        id: 6,
        title: 'Campus Esports Championship (Valorant & BGMI)',
        description: 'Compete for the ultimate gaming trophy and streaming gear.',
        category: 'Sports',
        venue: 'Student Activity Center',
        startTime: now.add(const Duration(days: 6, hours: 5)),
        createdBy: 'Gaming Guild',
        rsvpCount: 54,
      ),
      CampusEvent(
        id: 7,
        title: 'Startup Pitch Arena 2026',
        description: 'Pitch your breakthrough startup idea to top angel investors & alumni.',
        category: 'Tech',
        venue: 'Incubation Center Lounge',
        startTime: now.add(const Duration(days: 7, hours: 3)),
        createdBy: 'E-Cell',
        rsvpCount: 35,
      ),
      CampusEvent(
        id: 8,
        title: 'Battle of the Bands',
        description: 'Rock, fusion, and indie bands battling live for the campus crown.',
        category: 'Cultural',
        venue: 'University Auditorium',
        startTime: now.add(const Duration(days: 8, hours: 7)),
        createdBy: 'Music Club',
        rsvpCount: 78,
      ),
      CampusEvent(
        id: 9,
        title: 'Competitive Coding Sprint',
        description: '2-hour speed coding round covering DSA, dynamic programming, and graphs.',
        category: 'Tech',
        venue: 'CSE Lab 2',
        startTime: now.add(const Duration(days: 3, hours: 5)),
        createdBy: 'ACM Student Chapter',
        rsvpCount: 46,
      ),
      CampusEvent(
        id: 10,
        title: 'Badminton Doubles Cup',
        description: 'Smash your way to victory in the annual campus badminton tournament.',
        category: 'Sports',
        venue: 'Indoor Sports Arena Court 2',
        startTime: now.add(const Duration(days: 4, hours: 9)),
        createdBy: 'Sports Committee',
        rsvpCount: 22,
      ),
    ]);

    _localStudyRequests.addAll([
      StudyRequest(
        id: 1,
        studentId: 1,
        studentName: 'Aarav Sharma',
        branch: 'Computer Science',
        subject: 'DSA',
        location: 'Hostel Block A Study Room',
        status: 'open',
        createdAt: now.subtract(const Duration(hours: 1)),
      ),
      StudyRequest(
        id: 2,
        studentId: 2,
        studentName: 'Priya Patel',
        branch: 'Information Technology',
        subject: 'DBMS',
        location: 'Girls Hostel 2 Library',
        status: 'open',
        createdAt: now.subtract(const Duration(hours: 4)),
      ),
    ]);

    _localLeaderboard.addAll([
      LeaderboardEntry(
        studentName: 'Aarav Sharma',
        branch: 'Computer Science',
        year: 3,
        subject: 'DSA',
        score: 5,
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      LeaderboardEntry(
        studentName: 'Priya Patel',
        branch: 'Information Technology',
        year: 2,
        subject: 'DBMS',
        score: 4,
        createdAt: now.subtract(const Duration(hours: 3)),
      ),
      LeaderboardEntry(
        studentName: 'Ananya Iyer',
        branch: 'Electronics & Comm.',
        year: 3,
        subject: 'OS',
        score: 5,
        createdAt: now.subtract(const Duration(hours: 5)),
      ),
      LeaderboardEntry(
        studentName: 'Rohan Verma',
        branch: 'Mechanical Eng.',
        year: 4,
        subject: 'DSA',
        score: 4,
        createdAt: now.subtract(const Duration(hours: 8)),
      ),
      LeaderboardEntry(
        studentName: 'Kabir Singh',
        branch: 'Civil Eng.',
        year: 2,
        subject: 'DBMS',
        score: 3,
        createdAt: now.subtract(const Duration(hours: 12)),
      ),
    ]);

    _localQuestions['DBMS'] = [
      QuizQuestion(
        id: 1,
        subject: 'DBMS',
        question: 'Which ACID property guarantees that either all database operations succeed or none do?',
        options: ['Atomicity', 'Consistency', 'Isolation', 'Durability'],
        correctIndex: 0,
      ),
      QuizQuestion(
        id: 2,
        subject: 'DBMS',
        question: 'Which normal form addresses and eliminates transitive functional dependencies?',
        options: ['1NF', '2NF', '3NF', 'BCNF'],
        correctIndex: 2,
      ),
      QuizQuestion(
        id: 3,
        subject: 'DBMS',
        question: 'Which SQL clause is used to filter results after an aggregation using GROUP BY?',
        options: ['WHERE', 'HAVING', 'ORDER BY', 'FILTER'],
        correctIndex: 1,
      ),
      QuizQuestion(
        id: 4,
        subject: 'DBMS',
        question: 'What data structure is standard for high-performance multi-level database indexing?',
        options: ['B+ Tree', 'Hash Map', 'Trie', 'Binary Search Tree'],
        correctIndex: 0,
      ),
      QuizQuestion(
        id: 5,
        subject: 'DBMS',
        question: 'Which transaction isolation level prevents "dirty reads" by disallowing uncommitted read data?',
        options: ['Read Uncommitted', 'Read Committed', 'Repeatable Read', 'Serializable'],
        correctIndex: 1,
      ),
    ];

    _localQuestions['OS'] = [
      QuizQuestion(
        id: 6,
        subject: 'OS',
        question: 'Which condition is NOT a required Coffman condition for a deadlock to occur?',
        options: ['Mutual Exclusion', 'Hold and Wait', 'Preemption Allowed', 'Circular Wait'],
        correctIndex: 2,
      ),
      QuizQuestion(
        id: 7,
        subject: 'OS',
        question: "Which page replacement algorithm suffers from Belady's Anomaly?",
        options: ['LRU', 'FIFO', 'Optimal', 'LFU'],
        correctIndex: 1,
      ),
      QuizQuestion(
        id: 8,
        subject: 'OS',
        question: 'What is the primary function of the Translation Lookaside Buffer (TLB)?',
        options: ['Cache virtual-to-physical address translations', 'Schedule CPU burst threads', 'Manage disk block allocations', 'Prevent buffer overflow'],
        correctIndex: 0,
      ),
      QuizQuestion(
        id: 9,
        subject: 'OS',
        question: 'Which resource is shared among all threads of the same parent process?',
        options: ['CPU Registers', 'Call Stack', 'Address Space and Code', 'Thread ID'],
        correctIndex: 2,
      ),
      QuizQuestion(
        id: 10,
        subject: 'OS',
        question: 'A counting semaphore initialized to 5 allows how many processes concurrently?',
        options: ['1', '5', 'Unlimited', '0'],
        correctIndex: 1,
      ),
    ];

    _localQuestions['DSA'] = [
      QuizQuestion(
        id: 11,
        subject: 'DSA',
        question: 'What is the average time complexity of searching in a Balanced Binary Search Tree?',
        options: ['O(1)', 'O(log n)', 'O(n)', 'O(n log n)'],
        correctIndex: 1,
      ),
      QuizQuestion(
        id: 12,
        subject: 'DSA',
        question: 'Which data structure is standard for implementing Breadth-First Search (BFS)?',
        options: ['Stack', 'Queue', 'Priority Queue', 'Disjoint Set'],
        correctIndex: 1,
      ),
      QuizQuestion(
        id: 13,
        subject: 'DSA',
        question: 'What is the worst-case time complexity of QuickSort with poor pivot selection?',
        options: ['O(n log n)', 'O(n)', 'O(n²)', 'O(2ⁿ)'],
        correctIndex: 2,
      ),
      QuizQuestion(
        id: 14,
        subject: 'DSA',
        question: 'Which paradigm solves subproblems only once and stores solutions in a table?',
        options: ['Divide and Conquer', 'Greedy Method', 'Dynamic Programming', 'Backtracking'],
        correctIndex: 2,
      ),
      QuizQuestion(
        id: 15,
        subject: 'DSA',
        question: 'What is the minimum number of queues required to implement a FIFO Stack?',
        options: ['1', '2', '3', '4'],
        correctIndex: 1,
      ),
    ];
  }

  // --- Auth API ---
  Future<AuthResponse> login(String email, String password) async {
    try {
      final res = await client.auth.login(email: email, password: password);
      if (res.success && res.student != null) {
        AuthState.instance.setStudent(res.student!, token: res.token);
      }
      return res;
    } catch (_) {
      // Local fallback
      final clean = email.trim().toLowerCase();
      final match = _localStudents.firstWhere(
        (s) => s.email.toLowerCase() == clean,
        orElse: () => _localStudents.first,
      );
      final res = AuthResponse(
        success: true,
        message: 'Welcome back, ${match.name}!',
        token: 'token_${match.id}',
        student: match,
      );
      AuthState.instance.setStudent(match, token: res.token);
      return res;
    }
  }

  Future<AuthResponse> signup({
    required String name,
    required String email,
    required String password,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) async {
    try {
      final res = await client.auth.signup(
        name: name,
        email: email,
        password: password,
        branch: branch,
        year: year,
        interests: interests,
        hostelArea: hostelArea,
      );
      if (res.success && res.student != null) {
        AuthState.instance.setStudent(res.student!, token: res.token);
      }
      return res;
    } catch (_) {
      final newStudent = Student(
        id: _localStudents.length + 1,
        name: name,
        email: email,
        branch: branch,
        year: year,
        interests: interests,
        hostelArea: hostelArea,
      );
      _localStudents.add(newStudent);
      final res = AuthResponse(
        success: true,
        message: 'Account created successfully!',
        token: 'token_${newStudent.id}',
        student: newStudent,
      );
      AuthState.instance.setStudent(newStudent, token: res.token);
      return res;
    }
  }

  // --- Event API ---
  Future<List<CampusEvent>> getFeed({String? categoryFilter}) async {
    try {
      final list = await client.event.getFeed(categoryFilter: categoryFilter);
      if (list.isNotEmpty) return list;
    } catch (_) {}

    return _localEvents.where((e) {
      if (categoryFilter == null ||
          categoryFilter.isEmpty ||
          categoryFilter.toLowerCase() == 'all') {
        return true;
      }
      return e.category.toLowerCase() == categoryFilter.toLowerCase();
    }).toList();
  }

  Future<CampusEvent> createEvent(CampusEvent event) async {
    try {
      final created = await client.event.createEvent(event);
      _rsvpStreamController.add(RsvpUpdate(eventId: created.id ?? 0, rsvpCount: created.rsvpCount));
      return created;
    } catch (_) {
      event.id = _localEvents.length + 1;
      _localEvents.insert(0, event);
      _rsvpStreamController.add(RsvpUpdate(eventId: event.id!, rsvpCount: event.rsvpCount));
      return event;
    }
  }

  Future<RsvpUpdate> rsvp(int eventId, int studentId) async {
    try {
      final update = await client.event.rsvp(eventId: eventId, studentId: studentId);
      _rsvpStreamController.add(update);
      return update;
    } catch (_) {
      final idx = _localEvents.indexWhere((e) => e.id == eventId);
      int count = 1;
      if (idx != -1) {
        _localEvents[idx].rsvpCount += 1;
        count = _localEvents[idx].rsvpCount;
      }
      final update = RsvpUpdate(eventId: eventId, rsvpCount: count);
      _rsvpStreamController.add(update);
      return update;
    }
  }

  // --- Buddy API ---
  Future<List<Student>> findBuddies(String subject, String location) async {
    try {
      final res = await client.buddy.findBuddies(subject: subject, location: location);
      if (res.isNotEmpty) return res;
    } catch (_) {}

    final cleanSubject = subject.trim().toLowerCase();
    final cleanLocation = location.trim().toLowerCase();

    final matches = _localStudents.where((s) {
      final subMatch = s.interests.any((i) => i.toLowerCase().contains(cleanSubject) || cleanSubject.contains(i.toLowerCase()));
      final locMatch = cleanLocation.isNotEmpty && s.hostelArea.toLowerCase().contains(cleanLocation);
      return subMatch || locMatch;
    }).toList();

    return matches.isNotEmpty ? matches : _localStudents.take(3).toList();
  }

  Future<StudyRequest> createRequest(StudyRequest request) async {
    try {
      final created = await client.buddy.createRequest(request);
      return created;
    } catch (_) {
      request.id = _localStudyRequests.length + 1;
      _localStudyRequests.insert(0, request);
      return request;
    }
  }

  Future<List<StudyRequest>> getRequests({String? subject}) async {
    try {
      final list = await client.buddy.getRequests(subject: subject);
      if (list.isNotEmpty) return list;
    } catch (_) {}

    return _localStudyRequests.where((r) {
      if (subject == null || subject.isEmpty || subject.toLowerCase() == 'all') {
        return true;
      }
      return r.subject.toLowerCase() == subject.toLowerCase();
    }).toList();
  }

  // --- Quiz API ---
  Future<List<QuizQuestion>> getQuestions(String subject) async {
    try {
      final list = await client.quiz.getQuestions(subject: subject);
      if (list.isNotEmpty) return list;
    } catch (_) {}

    return _localQuestions[subject.toUpperCase()] ?? _localQuestions['DSA']!;
  }

  Future<QuizScore> submitScore(int studentId, String subject, int score) async {
    try {
      final saved = await client.quiz.submitScore(studentId: studentId, subject: subject, score: score);
      final currentStudent = AuthState.instance.currentStudent;
      final entry = LeaderboardEntry(
        studentName: currentStudent?.name ?? 'Student #$studentId',
        branch: currentStudent?.branch ?? 'Engineering',
        year: currentStudent?.year ?? 1,
        subject: subject,
        score: score,
        createdAt: DateTime.now(),
      );
      _leaderboardStreamController.add(entry);
      return saved;
    } catch (_) {
      final currentStudent = AuthState.instance.currentStudent;
      final entry = LeaderboardEntry(
        studentName: currentStudent?.name ?? 'Student #$studentId',
        branch: currentStudent?.branch ?? 'Engineering',
        year: currentStudent?.year ?? 1,
        subject: subject,
        score: score,
        createdAt: DateTime.now(),
      );
      _localLeaderboard.insert(0, entry);
      _leaderboardStreamController.add(entry);
      return QuizScore(
        id: _localLeaderboard.length,
        studentId: studentId,
        subject: subject,
        score: score,
        createdAt: DateTime.now(),
      );
    }
  }

  Future<List<LeaderboardEntry>> getLeaderboard({String? subject}) async {
    try {
      final list = await client.quiz.getLeaderboard(subject: subject);
      if (list.isNotEmpty) return list;
    } catch (_) {}

    final filtered = _localLeaderboard.where((e) {
      if (subject == null || subject.isEmpty || subject.toLowerCase() == 'all') {
        return true;
      }
      return e.subject.toLowerCase() == subject.toLowerCase();
    }).toList();

    filtered.sort((a, b) => b.score.compareTo(a.score));
    return filtered;
  }
}
