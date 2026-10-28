import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import '../service/seed_data.dart';

class AuthEndpoint extends Endpoint {
  Future<AuthResponse> signup(
    Session session, {
    required String name,
    required String email,
    required String password,
    required String branch,
    required int year,
    required List<String> interests,
    required String hostelArea,
  }) async {
    final cleanEmail = email.trim().toLowerCase();

    // Check if student already exists
    final existing = await Student.db.findFirstRow(
      session,
      where: (t) => t.email.equals(cleanEmail),
    );

    if (existing != null) {
      return AuthResponse(
        success: false,
        message: 'A student with this email is already registered.',
      );
    }

    final newStudent = Student(
      name: name.trim(),
      email: cleanEmail,
      passwordHash: SeedService.hashPassword(password),
      branch: branch,
      year: year,
      interests: interests,
      hostelArea: hostelArea.trim(),
    );

    final saved = await Student.db.insertRow(session, newStudent);

    return AuthResponse(
      success: true,
      message: 'Signup successful! Welcome to Campus Pulse.',
      token: 'token_${saved.id}_${DateTime.now().millisecondsSinceEpoch}',
      student: saved,
    );
  }

  Future<AuthResponse> login(
    Session session, {
    required String email,
    required String password,
  }) async {
    final cleanEmail = email.trim().toLowerCase();
    final hash = SeedService.hashPassword(password);

    final student = await Student.db.findFirstRow(
      session,
      where: (t) => t.email.equals(cleanEmail) & t.passwordHash.equals(hash),
    );

    if (student == null) {
      return AuthResponse(
        success: false,
        message: 'Invalid email or password. Please try again.',
      );
    }

    return AuthResponse(
      success: true,
      message: 'Welcome back, ${student.name}!',
      token: 'token_${student.id}_${DateTime.now().millisecondsSinceEpoch}',
      student: student,
    );
  }

  Future<Student?> getProfile(Session session, int studentId) async {
    return await Student.db.findById(session, studentId);
  }
}
