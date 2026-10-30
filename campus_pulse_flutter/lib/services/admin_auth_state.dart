import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import '../client.dart';

class AdminAuthState extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  bool _isAdminAuthenticated = false;
  bool _isLibraryStaff = false;
  String? _adminEmail;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAdminAuthenticated =>
      _isAdminAuthenticated && client.auth.isAuthenticated;
  bool get isLibraryStaff => _isLibraryStaff && client.auth.isAuthenticated;
  String? get adminEmail => _adminEmail;

  AdminAuthState() {
    client.auth.authInfoListenable.addListener(_onAuthChanged);
  }

  void _onAuthChanged() async {
    if (!client.auth.isAuthenticated) {
      _isAdminAuthenticated = false;
      _adminEmail = null;
      notifyListeners();
    } else {
      await checkAdminStatus();
    }
  }

  /// Verifies whether current authenticated session possesses the 'admin' master role
  Future<bool> checkAdminStatus() async {
    if (!client.auth.isAuthenticated) {
      _isAdminAuthenticated = false;
      notifyListeners();
      return false;
    }

    try {
      final isMaster = await client.admin.verifyAdminSession();
      _isAdminAuthenticated = isMaster;
      notifyListeners();
      return isMaster;
    } catch (_) {
      _isAdminAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  /// Dedicated Master Admin Login
  Future<bool> loginAdmin({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authSuccess = await client.admin.loginAdmin(
        email: email.trim().toLowerCase(),
        password: password,
      );

      await client.auth.updateSignedInUser(authSuccess);
      _isAdminAuthenticated = true;
      _adminEmail = email.trim();
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isAdminAuthenticated = false;
      _errorMessage = _cleanError(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// 1-Click Master Admin Demo Login for Authorized Campus Administrators
  Future<bool> loginMasterAdminDemo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authSuccess = await client.admin.loginMasterAdminDemo();
      await client.auth.updateSignedInUser(authSuccess);
      _isAdminAuthenticated = true;
      _adminEmail = 'admin@campuspulse.edu';
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isAdminAuthenticated = false;
      _errorMessage = _cleanError(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// 1-Click Library Counter Staff Demo Login
  Future<bool> loginLibraryStaffDemo() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final authSuccess = await client.emailIdp.login(
        email: 'library@campuspulse.edu',
        password: 'LibraryStaff2026!',
      );
      await client.auth.updateSignedInUser(authSuccess);
      _isAdminAuthenticated = false;
      _isLibraryStaff = true;
      _adminEmail = 'library@campuspulse.edu';
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _isLibraryStaff = false;
      _errorMessage = _cleanError(e.toString());
      notifyListeners();
      return false;
    }
  }

  /// Admin Sign Out: Clears administrative credentials and revokes session
  Future<void> signOutAdmin() async {
    try {
      await client.auth.signOutDevice();
    } catch (_) {}
    _isAdminAuthenticated = false;
    _adminEmail = null;
    _errorMessage = null;
    notifyListeners();
  }

  String _cleanError(String raw) {
    if (raw.contains('Access Denied')) {
      return 'Access Denied: This account is not an authorized Master Administrator.';
    }
    if (raw.contains('invalidCredentials')) {
      return 'Invalid admin email or password.';
    }
    return raw
        .replaceAll('Exception:', '')
        .replaceAll('StateError:', '')
        .trim();
  }

  @override
  void dispose() {
    client.auth.authInfoListenable.removeListener(_onAuthChanged);
    super.dispose();
  }
}
