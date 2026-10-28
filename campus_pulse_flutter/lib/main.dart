import 'package:flutter/material.dart';
import 'services/auth_state.dart';
import 'services/client_service.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_page.dart';
import 'screens/main_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize ClientService singleton
  ClientService.instance;

  runApp(const CampusPulseApp());
}

class CampusPulseApp extends StatefulWidget {
  const CampusPulseApp({super.key});

  @override
  State<CampusPulseApp> createState() => _CampusPulseAppState();
}

class _CampusPulseAppState extends State<CampusPulseApp> {
  final AuthState _authState = AuthState.instance;

  @override
  void initState() {
    super.initState();
    _authState.addListener(_onAuthChanged);
  }

  @override
  void dispose() {
    _authState.removeListener(_onAuthChanged);
    super.dispose();
  }

  void _onAuthChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: _authState.isAuthenticated
          ? MainScaffold(onLogout: () => setState(() {}))
          : LoginPage(onLoginSuccess: () => setState(() {})),
    );
  }
}
