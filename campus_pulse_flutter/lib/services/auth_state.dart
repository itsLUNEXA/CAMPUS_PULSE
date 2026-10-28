import 'package:flutter/foundation.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';

class AuthState extends ChangeNotifier {
  static final AuthState instance = AuthState._();
  AuthState._();

  Student? _currentStudent;
  String? _authToken;

  Student? get currentStudent => _currentStudent;
  String? get authToken => _authToken;
  bool get isAuthenticated => _currentStudent != null;

  void setStudent(Student student, {String? token}) {
    _currentStudent = student;
    _authToken = token ?? 'token_${student.id}';
    notifyListeners();
  }

  void logout() {
    _currentStudent = null;
    _authToken = null;
    notifyListeners();
  }
}
