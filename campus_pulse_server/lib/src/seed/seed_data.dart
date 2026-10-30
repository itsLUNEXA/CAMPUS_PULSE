import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';
import '../generated/protocol.dart';

class SeedDataService {
  static Future<void> seedInitialData(Session session) async {
    // 1. Seed Demo Student and Email Account
    try {
      const demoEmail = 'aarav.sharma@campus.edu';
      var emailAccount = await EmailAccount.db.findFirstRow(
        session,
        where: (t) => t.email.equals(demoEmail),
      );

      UuidValue authUserId;
      if (emailAccount == null) {
        final authUser = await const AuthUsers().create(session);
        authUserId = authUser.id;
        await AuthServices.instance.emailIdp.admin.createEmailAuthentication(
          session,
          authUserId: authUserId,
          email: demoEmail,
          password: 'password123',
        );
      } else {
        authUserId = emailAccount.authUserId;
      }

      final existingStudent = await StudentProfile.db.findFirstRow(
        session,
        where: (t) => t.authUserId.equals(authUserId),
      );

      if (existingStudent == null) {
        final now = DateTime.now().toUtc();
        await StudentProfile.db.insertRow(
          session,
          StudentProfile(
            authUserId: authUserId,
            fullName: 'Aarav Sharma',
            email: demoEmail,
            branch: 'CSE',
            academicYear: 3,
            hostelOrArea: 'Kaveri Hostel Block B',
            bio: 'Competitive programmer and open source enthusiast.',
            subjectInterests: ['DSA', 'Operating Systems', 'DBMS'],
            createdAt: now,
            updatedAt: now,
          ),
        );
      }
    } catch (_) {}

    // 2. Seed Peer Students for Discovery if not present
    try {
      final now = DateTime.now().toUtc();
      final demoPeers = [
        StudentProfile(
          authUserId: UuidValue.fromString(
            '550e8400-e29b-41d4-a716-446655440021',
          ),
          fullName: 'Priya Patel',
          email: 'priya.patel@campus.edu',
          branch: 'CSE',
          academicYear: 3,
          hostelOrArea: 'Kaveri Hostel Block B',
          bio: 'Passionate about Algorithms, System Design and Open Source.',
          subjectInterests: ['DSA', 'Operating Systems', 'System Design'],
          createdAt: now,
          updatedAt: now,
        ),
        StudentProfile(
          authUserId: UuidValue.fromString(
            '550e8400-e29b-41d4-a716-446655440022',
          ),
          fullName: 'Rohan Mehta',
          email: 'rohan.mehta@campus.edu',
          branch: 'IT',
          academicYear: 3,
          hostelOrArea: 'Ganga Hostel Block A',
          bio: 'Full-stack developer building real-time collaboration tools.',
          subjectInterests: ['DBMS', 'Computer Networks', 'Web Technologies'],
          createdAt: now,
          updatedAt: now,
        ),
        StudentProfile(
          authUserId: UuidValue.fromString(
            '550e8400-e29b-41d4-a716-446655440023',
          ),
          fullName: 'Sneha Verma',
          email: 'sneha.verma@campus.edu',
          branch: 'ECE',
          academicYear: 2,
          hostelOrArea: 'Yamuna Hostel Block C',
          bio: 'Robotics enthusiast and embedded systems developer.',
          subjectInterests: ['Microprocessors', 'IoT', 'Digital Electronics'],
          createdAt: now,
          updatedAt: now,
        ),
      ];

      for (final peer in demoPeers) {
        final existingPeer = await StudentProfile.db.findFirstRow(
          session,
          where: (t) => t.email.equals(peer.email),
        );
        if (existingPeer == null) {
          await StudentProfile.db.insertRow(session, peer);
        }
      }
    } catch (_) {}

    // 3. Seed Quiz Questions if table is empty
    final existingQuestions = await QuizQuestion.db.count(session);
    if (existingQuestions == 0) {
      session.log('Seeding initial quiz questions...', level: LogLevel.info);
      final questions = _getInitialQuestions();
      for (final q in questions) {
        await QuizQuestion.db.insertRow(session, q);
      }
    }

    // 4. Seed Campus Events idempotently by title
    final events = _getInitialEvents();
    for (final e in events) {
      final existing = await CampusEvent.db.findFirstRow(
        session,
        where: (t) => t.title.equals(e.title),
      );
      if (existing == null) {
        await CampusEvent.db.insertRow(session, e);
      }
    }
  }

  static List<QuizQuestion> _getInitialQuestions() {
    return [
      // --- DBMS Questions (5) ---
      QuizQuestion(
        subject: 'DBMS',
        question:
            'Which normal form deals with removing transitive dependencies?',
        options: ['1NF', '2NF', '3NF', 'BCNF'],
        correctOptionIndex: 2,
        explanation:
            '3NF ensures that every non-prime attribute is non-transitively dependent on every candidate key.',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'DBMS',
        question: 'What does the "A" in ACID transaction properties stand for?',
        options: ['Authentication', 'Atomicity', 'Availability', 'Accuracy'],
        correctOptionIndex: 1,
        explanation:
            'Atomicity ensures that all actions in a transaction execute completely or none at all (all-or-nothing).',
        difficulty: 'Easy',
      ),
      QuizQuestion(
        subject: 'DBMS',
        question:
            'Which index structure is primarily preferred for range queries in relational databases?',
        options: [
          'Hash Index',
          'B+ Tree Index',
          'Inverted Index',
          'Bitmap Index',
        ],
        correctOptionIndex: 1,
        explanation:
            'B+ Tree leaves are linked together in a sorted list, making sequential range scans very efficient.',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'DBMS',
        question:
            'In PostgreSQL, which isolation level prevents phantom reads and non-repeatable reads entirely?',
        options: [
          'Read Uncommitted',
          'Read Committed',
          'Repeatable Read',
          'Serializable',
        ],
        correctOptionIndex: 3,
        explanation:
            'Serializable isolation guarantees that concurrent transactions execute as if run serially, preventing phantom reads.',
        difficulty: 'Hard',
      ),
      QuizQuestion(
        subject: 'DBMS',
        question:
            'What type of lock prevents both read and write operations by other transactions?',
        options: [
          'Shared Lock (S)',
          'Exclusive Lock (X)',
          'Intent Shared (IS)',
          'Optimistic Lock',
        ],
        correctOptionIndex: 1,
        explanation:
            'An exclusive lock (X lock) allows only the holder to write, blocking other transactions from reading or writing.',
        difficulty: 'Medium',
      ),

      // --- Operating Systems Questions (5) ---
      QuizQuestion(
        subject: 'Operating Systems',
        question:
            'Which of the following is NOT a necessary condition for a deadlock to occur?',
        options: [
          'Mutual Exclusion',
          'Hold and Wait',
          'Preemption',
          'Circular Wait',
        ],
        correctOptionIndex: 2,
        explanation:
            'The four Coffman conditions are Mutual Exclusion, Hold and Wait, No Preemption, and Circular Wait. Preemption breaks deadlocks.',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'Operating Systems',
        question:
            'What is the phenomenon where increasing the number of page frames leads to more page faults called?',
        options: ['Thrashing', 'Belady\'s Anomaly', 'Aging', 'Starvation'],
        correctOptionIndex: 1,
        explanation:
            'Belady\'s Anomaly occurs with certain page replacement algorithms like FIFO, where more memory frames cause more page faults.',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'Operating Systems',
        question:
            'Which CPU scheduling algorithm gives the minimum average waiting time for a given set of processes?',
        options: [
          'First-Come First-Served (FCFS)',
          'Round Robin (RR)',
          'Shortest Job First (SJF)',
          'Priority Scheduling',
        ],
        correctOptionIndex: 2,
        explanation:
            'Shortest Job First (SJF) is provably optimal regarding minimum average waiting time for independent processes.',
        difficulty: 'Easy',
      ),
      QuizQuestion(
        subject: 'Operating Systems',
        question:
            'What mechanism does the CPU use to switch between user mode and kernel mode?',
        options: [
          'DMA Transfer',
          'Software Interrupt (Trap / System Call)',
          'Clock Drift',
          'Thread Pool',
        ],
        correctOptionIndex: 1,
        explanation:
            'A trap or system call generates a software interrupt switching the execution mode from user to kernel mode.',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'Operating Systems',
        question: 'What causes "Thrashing" in an operating system?',
        options: [
          'Too many page hits',
          'Excessive paging where CPU spends more time swapping than executing',
          'CPU clock overclocking',
          'Disk fragmentation',
        ],
        correctOptionIndex: 1,
        explanation:
            'Thrashing occurs when the system does not have enough physical memory frames, spending most time servicing page faults.',
        difficulty: 'Hard',
      ),

      // --- Data Structures and Algorithms Questions (5) ---
      QuizQuestion(
        subject: 'Data Structures and Algorithms',
        question:
            'What is the worst-case time complexity of QuickSort when using the naive first-element pivot selection?',
        options: ['O(N log N)', 'O(N)', 'O(N^2)', 'O(log N)'],
        correctOptionIndex: 2,
        explanation:
            'When the array is already sorted or reverse sorted, naive QuickSort partitions into 1 and N-1 elements, resulting in O(N^2).',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'Data Structures and Algorithms',
        question:
            'Which data structure is fundamentally used for Breadth-First Search (BFS) graph traversal?',
        options: ['Stack', 'Queue', 'Min-Heap', 'Disjoint Set'],
        correctOptionIndex: 1,
        explanation:
            'BFS uses a FIFO Queue to visit neighbors level-by-level in increasing order of distance.',
        difficulty: 'Easy',
      ),
      QuizQuestion(
        subject: 'Data Structures and Algorithms',
        question:
            'What is the balance factor constraint for any node in an AVL tree?',
        options: [
          'Height of left child == Height of right child',
          'Balance factor must be -1, 0, or +1',
          'Node key is greater than both children',
          'Balance factor can be any prime number',
        ],
        correctOptionIndex: 1,
        explanation:
            'An AVL tree requires that the difference in heights of left and right subtrees of any node is at most 1 (-1, 0, or 1).',
        difficulty: 'Medium',
      ),
      QuizQuestion(
        subject: 'Data Structures and Algorithms',
        question:
            'Which algorithmic paradigm does Dijkstra\'s Single Source Shortest Path algorithm use?',
        options: [
          'Greedy Approach',
          'Dynamic Programming',
          'Divide and Conquer',
          'Backtracking',
        ],
        correctOptionIndex: 0,
        explanation:
            'Dijkstra greedily chooses the unvisited vertex with the minimum tentative distance at each step.',
        difficulty: 'Easy',
      ),
      QuizQuestion(
        subject: 'Data Structures and Algorithms',
        question:
            'What is the amortized time complexity of inserting an element into a dynamic array (std::vector / ArrayList)?',
        options: ['O(N)', 'O(1)', 'O(log N)', 'O(N^2)'],
        correctOptionIndex: 1,
        explanation:
            'Although doubling the capacity takes O(N) when resizing occurs, over a sequence of N insertions the amortized cost per insert is O(1).',
        difficulty: 'Hard',
      ),
    ];
  }

  static List<CampusEvent> _getInitialEvents() {
    final now = DateTime.now().toUtc();
    return [
      CampusEvent(
        title: 'HackPulse 2026: Campus 36-Hour Hackathon',
        description:
            'Build innovative solutions for campus sustainability, student productivity, and collaborative learning. Mentorship and food provided!',
        category: 'Hackathon',
        startTime: now.add(const Duration(days: 3, hours: 9)),
        endTime: now.add(const Duration(days: 4, hours: 21)),
        venue: 'Auditorium Hall B & Innovation Lab',
        bannerUrl:
            'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?w=800&auto=format&fit=crop',
        organizerAuthUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440011',
        ),
        organizerName: 'Google Developer Student Club',
        rsvpCount: 42,
      ),
      CampusEvent(
        title: 'Deep Dive into Systems & Linux Internals',
        description:
            'Master kernel system calls, memory management, and process scheduling with live C/Rust demonstrations.',
        category: 'Tech',
        startTime: now.add(const Duration(days: 1, hours: 16)),
        endTime: now.add(const Duration(days: 1, hours: 18)),
        venue: 'CS Seminar Hall 204',
        bannerUrl:
            'https://images.unsplash.com/photo-1629654297299-c8506221ca97?w=800&auto=format&fit=crop',
        organizerAuthUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440012',
        ),
        organizerName: 'ACM Student Chapter',
        rsvpCount: 28,
      ),
      CampusEvent(
        title: 'Inter-Department Cricket & Football Tournament',
        description:
            'Annual inter-department sports tournament. Cheer for your branch teams or participate in track events.',
        category: 'Sports',
        startTime: now.add(const Duration(days: 5, hours: 7)),
        endTime: now.add(const Duration(days: 6, hours: 18)),
        venue: 'University Sports Complex Ground',
        bannerUrl:
            'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=800&auto=format&fit=crop',
        organizerAuthUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440013',
        ),
        organizerName: 'Campus Sports Council',
        rsvpCount: 65,
      ),
      CampusEvent(
        title: 'PulseFest: Annual Cultural Gala & Battle of Bands',
        description:
            'A vibrant evening of acoustic performances, choreography showcase, street play, and food stalls.',
        category: 'Cultural',
        startTime: now.add(const Duration(days: 7, hours: 18)),
        endTime: now.add(const Duration(days: 7, hours: 23)),
        venue: 'Open Air Amphitheatre',
        bannerUrl:
            'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?w=800&auto=format&fit=crop',
        organizerAuthUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440014',
        ),
        organizerName: 'Cultural Arts Society',
        rsvpCount: 110,
      ),
      CampusEvent(
        title: 'Resume Review & Tech Interview Mastery Workshop',
        description:
            'Mock technical interviews, system design fundamentals, and behavioral Q&A preparation with alumni working at top tech firms.',
        category: 'Workshop',
        startTime: now.add(const Duration(days: 2, hours: 14)),
        endTime: now.add(const Duration(days: 2, hours: 17)),
        venue: 'Career Center Boardroom 1',
        bannerUrl:
            'https://images.unsplash.com/photo-1531482615713-2afd69097998?w=800&auto=format&fit=crop',
        organizerAuthUserId: UuidValue.fromString(
          '550e8400-e29b-41d4-a716-446655440015',
        ),
        organizerName: 'Campus Training & Placement Cell',
        rsvpCount: 54,
      ),
    ];
  }
}
