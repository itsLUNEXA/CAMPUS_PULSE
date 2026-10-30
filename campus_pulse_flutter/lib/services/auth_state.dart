import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../client.dart';

class AuthState extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  StudentProfile? _currentProfile;
  bool _isAdmin = false;
  bool _isLibraryStaff = false;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  StudentProfile? get currentProfile => _currentProfile;
  bool get isAuthenticated => client.auth.isAuthenticated;
  bool get isAdmin => _isAdmin;
  bool get isLibraryStaff => _isLibraryStaff;

  AuthState() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
  }

  void _onAuthChanged() {
    if (client.auth.isAuthenticated) {
      loadProfile();
    } else {
      _currentProfile = null;
      _isAdmin = false;
      _isLibraryStaff = false;
      notifyListeners();
    }
  }

  /// Loads current student profile from backend and checks roles
  Future<void> loadProfile() async {
    if (!client.auth.isAuthenticated) {
      _currentProfile = null;
      _isAdmin = false;
      _isLibraryStaff = false;
      notifyListeners();
      return;
    }
    try {
      _currentProfile = await client.student.getProfile();
    } catch (_) {
      _currentProfile = null;
    }

    try {
      final roles = await client.admin.getMyRoles();
      _isAdmin = roles.contains('admin');
      _isLibraryStaff =
          roles.contains('library_staff') || roles.contains('admin');
    } catch (_) {
      _isAdmin = false;
      _isLibraryStaff = false;
    }
    notifyListeners();
  }

  /// Logs in with email and password
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _currentProfile = null;
    notifyListeners();

    try {
      final authSuccess = await client.emailIdp.login(
        email: email.trim().toLowerCase(),
        password: password,
      );
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// 1-Click Instant Demo Login (studentIndex 1 = Aarav Sharma, studentIndex 2 = Priya Patel)
  Future<bool> loginDemo({int studentIndex = 1}) async {
    _isLoading = true;
    _errorMessage = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _currentProfile = null;
    notifyListeners();

    try {
      final authSuccess = studentIndex == 2
          ? await client.student.loginDemoStudent2()
          : await client.student.loginDemo();
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// 1-Click Master Admin Setup / Demo Login
  Future<bool> loginMasterAdminDemo() async {
    _isLoading = true;
    _errorMessage = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _currentProfile = null;
    notifyListeners();

    try {
      final authSuccess = await client.admin.loginMasterAdminDemo();
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isAdmin = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Dedicated Administrator Login with credentials
  Future<bool> loginAdmin(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _currentProfile = null;
    notifyListeners();

    try {
      final authSuccess = await client.admin.loginAdmin(
        email: email.trim().toLowerCase(),
        password: password,
      );
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isAdmin = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// 1-Click Library Counter Staff Demo Login
  Future<bool> loginLibraryStaffDemo() async {
    _isLoading = true;
    _errorMessage = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _currentProfile = null;
    notifyListeners();

    try {
      final authSuccess = await client.emailIdp.login(
        email: 'library@campuspulse.edu',
        password: 'LibraryStaff2026!',
      );
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isLibraryStaff = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Direct registration for students
  Future<bool> registerStudent({
    required String fullName,
    required String email,
    required String password,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authSuccess = await client.student.registerStudent(
        fullName: fullName.trim(),
        email: email.trim().toLowerCase(),
        password: password,
        branch: branch,
        academicYear: academicYear,
        hostelOrArea: hostelOrArea.trim(),
        bio: bio?.trim(),
        subjectInterests: subjectInterests,
      );
      await client.auth.updateSignedInUser(authSuccess);
      await loadProfile();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Updates or completes student profile
  Future<bool> updateProfile({
    required String fullName,
    String? email,
    required String branch,
    required int academicYear,
    required String hostelOrArea,
    String? bio,
    required List<String> subjectInterests,
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentProfile = await client.student.updateProfile(
        fullName: fullName.trim(),
        email: email,
        branch: branch,
        academicYear: academicYear,
        hostelOrArea: hostelOrArea.trim(),
        bio: bio?.trim(),
        subjectInterests: subjectInterests,
        eventInterests: eventInterests,
        preferredQuizSubjects: preferredQuizSubjects,
        preferredQuizTypes: preferredQuizTypes,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Updates student preferences
  Future<bool> updatePreferences({
    List<String>? eventInterests,
    List<String>? preferredQuizSubjects,
    List<String>? preferredQuizTypes,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentProfile = await client.student.updatePreferences(
        eventInterests: eventInterests,
        preferredQuizSubjects: preferredQuizSubjects,
        preferredQuizTypes: preferredQuizTypes,
      );
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _cleanErrorMessage(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Signs out completely and clears session
  Future<void> signOut() async {
    try {
      await client.auth.signOutDevice();
    } catch (_) {}
    _currentProfile = null;
    _isAdmin = false;
    _isLibraryStaff = false;
    _errorMessage = null;
    notifyListeners();
  }

  String _cleanErrorMessage(String raw) {
    if (raw.contains('invalidCredentials')) {
      return 'Invalid email or password. Please check your credentials.';
    }
    if (raw.contains('SocketException') || raw.contains('Failed host lookup')) {
      return 'Unable to reach Campus Pulse server. Please check your network connection.';
    }
    return raw.replaceAll('Exception:', '').trim();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthChanged);
    super.dispose();
  }
}
