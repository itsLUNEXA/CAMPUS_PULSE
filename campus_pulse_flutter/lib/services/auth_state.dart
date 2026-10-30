import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../client.dart';

class AuthState extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  StudentProfile? _currentProfile;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  StudentProfile? get currentProfile => _currentProfile;
  bool get isAuthenticated => client.auth.isAuthenticated;

  AuthState() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
  }

  void _onAuthChanged() {
    if (client.auth.isAuthenticated) {
      loadProfile();
    } else {
      _currentProfile = null;
      notifyListeners();
    }
  }

  /// Loads current student profile from backend
  Future<void> loadProfile() async {
    if (!client.auth.isAuthenticated) return;
    try {
      _currentProfile = await client.student.getProfile();
      notifyListeners();
    } catch (_) {}
  }

  /// Logs in with email and password
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
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

  /// 1-Click Instant Demo Login
  Future<bool> loginDemo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authSuccess = await client.student.loginDemo();
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
