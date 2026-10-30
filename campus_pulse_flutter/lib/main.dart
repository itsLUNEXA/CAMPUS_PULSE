import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'client.dart';
import 'screens/auth_screen.dart';
import 'screens/master_admin_dashboard_screen.dart';
import 'screens/student_timetable_screen.dart';
import 'screens/rewards_screen.dart';
import 'screens/attendance_screen.dart';
import 'screens/certificates_screen.dart';
import 'screens/academic_resources_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/mom_screen.dart';
import 'screens/contact_support_screen.dart';
import 'screens/create_event_screen.dart';
import 'screens/event_detail_screen.dart';
import 'screens/events_feed_screen.dart';
import 'screens/faq_help_screen.dart';
import 'screens/home_dashboard_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/quiz_gameplay_screen.dart';
import 'screens/quiz_results_screen.dart';
import 'screens/quiz_selection_screen.dart';
import 'screens/search_results_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/student_discovery_screen.dart';
import 'screens/student_profile_screen.dart';
import 'screens/study_requests_screen.dart';
import 'screens/welcome_onboarding_screen.dart';
import 'screens/library_staff_dashboard_screen.dart';
import 'screens/student_print_screen.dart';
import 'screens/campus_clubs_screen.dart';
import 'screens/interview_prep_screen.dart';
import 'services/auth_state.dart';
import 'services/admin_auth_state.dart';
import 'services/preferences_service.dart';
import 'services/realtime_service.dart';
import 'services/utm_service.dart';
import 'theme/app_theme.dart';
import 'widgets/responsive_scaffold.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeClient();

  final preferencesService = PreferencesService();
  await preferencesService.init();

  final authState = AuthState();
  final adminAuthState = AdminAuthState();
  final realtimeService = RealtimeService();
  realtimeService.startListening();

  // Parse UTM parameters if opened on Web (UX Feature 14.14)
  try {
    UtmService.parseUri(Uri.base);
  } catch (_) {}

  runApp(
    CampusPulseApp(
      preferencesService: preferencesService,
      authState: authState,
      adminAuthState: adminAuthState,
      realtimeService: realtimeService,
    ),
  );
}

class CampusPulseApp extends StatelessWidget {
  final PreferencesService preferencesService;
  final AuthState authState;
  final AdminAuthState? adminAuthState;
  final RealtimeService realtimeService;

  const CampusPulseApp({
    super.key,
    required this.preferencesService,
    required this.authState,
    this.adminAuthState,
    required this.realtimeService,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveAdminAuth = adminAuthState ?? AdminAuthState();
    return ListenableBuilder(
      listenable: preferencesService,
      builder: (context, _) {
        return MaterialApp(
          title: 'CAMPULSE',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: preferencesService.themeMode,
          home: CampusPulseShell(
            preferencesService: preferencesService,
            authState: authState,
            adminAuthState: effectiveAdminAuth,
            realtimeService: realtimeService,
          ),
        );
      },
    );
  }
}

class CampusPulseShell extends StatefulWidget {
  final PreferencesService preferencesService;
  final AuthState authState;
  final AdminAuthState adminAuthState;
  final RealtimeService realtimeService;

  const CampusPulseShell({
    super.key,
    required this.preferencesService,
    required this.authState,
    required this.adminAuthState,
    required this.realtimeService,
  });

  @override
  State<CampusPulseShell> createState() => _CampusPulseShellState();
}

class _CampusPulseShellState extends State<CampusPulseShell> {
  late String _currentRoute;
  CampusEvent? _selectedEvent;
  String? _selectedQuizSubject;
  QuizResultSummary? _quizResult;

  static const Set<String> _publicRoutes = {
    'welcome',
    'auth',
    'admin_login',
    'events',
    'event_detail',
    'search',
    'faq',
    'contact',
    'certificates',
    'academic_resources',
  };

  static bool _isPublicRoute(String route) => _publicRoutes.contains(route);

  @override
  void initState() {
    super.initState();
    _currentRoute = widget.authState.isAuthenticated ? 'home' : 'welcome';
    widget.authState.addListener(_onAuthStateChanged);
  }

  @override
  void dispose() {
    widget.authState.removeListener(_onAuthStateChanged);
    super.dispose();
  }

  void _onAuthStateChanged() {
    if (!widget.authState.isAuthenticated) {
      widget.realtimeService.clearSession();
      // Force navigation to public landing page and clear private state
      if (!_isPublicRoute(_currentRoute)) {
        setState(() {
          _currentRoute = 'welcome';
          _selectedEvent = null;
          _selectedQuizSubject = null;
          _quizResult = null;
        });
      }
    } else {
      widget.realtimeService.startListening();
      if (widget.authState.isAdmin) {
        if (_currentRoute == 'auth' ||
            _currentRoute == 'welcome' ||
            _currentRoute == 'admin_login') {
          setState(() {
            _currentRoute = 'master_admin';
          });
        }
      } else {
        // Authenticated as regular student: Always redirect to home dashboard
        if (_currentRoute == 'auth' ||
            _currentRoute == 'welcome' ||
            _currentRoute == 'admin_login' ||
            _currentRoute == 'master_admin' ||
            _currentRoute == 'admin') {
          setState(() {
            _currentRoute = 'home';
          });
        }
      }
    }
  }

  void _navigateTo(String route) {
    // If admin_login is requested, route through main login portal
    if (route == 'admin_login') {
      setState(() {
        _currentRoute = 'auth';
      });
      return;
    }

    // Admin route protection: Ensure authenticated user has server-verified admin role
    if (route == 'master_admin' || route == 'admin') {
      if (!widget.authState.isAuthenticated) {
        setState(() {
          _currentRoute = 'auth';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in with administrator credentials.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      if (!widget.authState.isAdmin) {
        setState(() {
          _currentRoute = 'home';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Access Denied: Master Administrator credentials required.',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
    }

    if (!widget.authState.isAuthenticated && !_isPublicRoute(route)) {
      setState(() {
        _currentRoute = 'auth';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to access this feature.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() {
      _currentRoute = route;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen;

    switch (_currentRoute) {
      case 'welcome':
        activeScreen = WelcomeOnboardingScreen(
          onGetStarted: () => _navigateTo('auth'),
          onBrowseEvents: () => _navigateTo('events'),
          onNavigate: _navigateTo,
        );
        break;

      case 'auth':
        activeScreen = AuthScreen(
          authState: widget.authState,
          onAuthenticated: () {
            if (widget.authState.isAdmin) {
              _navigateTo('master_admin');
            } else {
              _navigateTo('home');
            }
          },
        );
        break;

      case 'home':
        activeScreen = HomeDashboardScreen(
          authState: widget.authState,
          realtimeService: widget.realtimeService,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'events':
        activeScreen = EventsFeedScreen(
          authState: widget.authState,
          realtimeService: widget.realtimeService,
          onSelectEvent: (event) {
            setState(() {
              _selectedEvent = event;
              _currentRoute = 'event_detail';
            });
          },
          onCreateEvent: () => _navigateTo('create_event'),
        );
        break;

      case 'event_detail':
        if (_selectedEvent != null) {
          activeScreen = EventDetailScreen(
            event: _selectedEvent!,
            authState: widget.authState,
            onBack: () => _navigateTo('events'),
          );
        } else {
          activeScreen = EventsFeedScreen(
            authState: widget.authState,
            realtimeService: widget.realtimeService,
            onSelectEvent: (event) {
              setState(() {
                _selectedEvent = event;
                _currentRoute = 'event_detail';
              });
            },
            onCreateEvent: () => _navigateTo('create_event'),
          );
        }
        break;

      case 'create_event':
        activeScreen = CreateEventScreen(
          authState: widget.authState,
          onEventCreated: () => _navigateTo('events'),
          onCancel: () => _navigateTo('events'),
        );
        break;

      case 'study_buddies':
        activeScreen = StudentDiscoveryScreen(
          authState: widget.authState,
          onViewRequests: () => _navigateTo('study_requests'),
        );
        break;

      case 'study_requests':
        activeScreen = StudyRequestsScreen(
          authState: widget.authState,
          onBack: () => _navigateTo('study_buddies'),
        );
        break;

      case 'profile':
        activeScreen = StudentProfileScreen(
          authState: widget.authState,
          onBack: () => _navigateTo('home'),
        );
        break;

      case 'quizzes':
        activeScreen = QuizSelectionScreen(
          authState: widget.authState,
          onStartQuiz: (subject) {
            setState(() {
              _selectedQuizSubject = subject;
              _currentRoute = 'quiz_gameplay';
            });
          },
          onViewLeaderboard: () => _navigateTo('leaderboard'),
        );
        break;

      case 'quiz_gameplay':
        activeScreen = QuizGameplayScreen(
          subject: _selectedQuizSubject ?? 'DBMS',
          authState: widget.authState,
          onFinished: (result) {
            setState(() {
              _quizResult = result;
              _currentRoute = 'quiz_results';
            });
          },
          onCancel: () => _navigateTo('quizzes'),
        );
        break;

      case 'quiz_results':
        if (_quizResult != null) {
          activeScreen = QuizResultsScreen(
            result: _quizResult!,
            onRetake: () => _navigateTo('quiz_gameplay'),
            onViewLeaderboard: () => _navigateTo('leaderboard'),
            onDone: () => _navigateTo('quizzes'),
          );
        } else {
          activeScreen = QuizSelectionScreen(
            authState: widget.authState,
            onStartQuiz: (subject) {
              setState(() {
                _selectedQuizSubject = subject;
                _currentRoute = 'quiz_gameplay';
              });
            },
            onViewLeaderboard: () => _navigateTo('leaderboard'),
          );
        }
        break;

      case 'leaderboard':
        activeScreen = LeaderboardScreen(
          authState: widget.authState,
          realtimeService: widget.realtimeService,
          onTakeQuiz: () => _navigateTo('quizzes'),
        );
        break;

      case 'notifications':
        activeScreen = NotificationsScreen(
          realtimeService: widget.realtimeService,
          onBack: () => _navigateTo('home'),
          onNavigate: (route) => _navigateTo(route),
          onNavigateWithTarget: (route, targetId) async {
            if (route == 'event_detail' && targetId != null) {
              final id = int.tryParse(targetId);
              if (id != null) {
                try {
                  final ev = await client.event.getEvent(id);
                  if (ev != null && mounted) {
                    setState(() {
                      _selectedEvent = ev;
                      _currentRoute = 'event_detail';
                    });
                    return;
                  }
                } catch (_) {}
              }
            }
            _navigateTo(route);
          },
        );
        break;

      case 'search':
        activeScreen = SearchResultsScreen(
          onBack: () => _navigateTo('home'),
          onSelectEvent: (eventId) async {
            try {
              final id = int.tryParse(eventId);
              if (id != null) {
                final ev = await client.event.getEvent(id);
                if (ev != null && mounted) {
                  setState(() {
                    _selectedEvent = ev;
                    _currentRoute = 'event_detail';
                  });
                }
              }
            } catch (_) {}
          },
        );
        break;

      case 'settings':
        activeScreen = SettingsScreen(
          authState: widget.authState,
          preferencesService: widget.preferencesService,
          onBack: () => _navigateTo('home'),
        );
        break;

      case 'faq':
        activeScreen = FaqHelpScreen(
          onBack: () => _navigateTo('home'),
          onContactSupport: () => _navigateTo('contact'),
        );
        break;

      case 'contact':
        activeScreen = ContactSupportScreen(
          onBack: () => _navigateTo('home'),
        );
        break;

      case 'admin_login':
        activeScreen = AuthScreen(
          authState: widget.authState,
          onAuthenticated: () {
            if (widget.authState.isAdmin) {
              _navigateTo('master_admin');
            } else {
              _navigateTo('home');
            }
          },
        );
        break;

      case 'master_admin':
      case 'admin':
        if (!widget.authState.isAuthenticated || !widget.authState.isAdmin) {
          activeScreen = AuthScreen(
            authState: widget.authState,
            onAuthenticated: () {
              if (widget.authState.isAdmin) {
                _navigateTo('master_admin');
              } else {
                _navigateTo('home');
              }
            },
          );
        } else {
          activeScreen = MasterAdminDashboardScreen(
            authState: widget.authState,
            onSignOut: () async {
              widget.realtimeService.clearSession();
              await widget.authState.signOut();
              _navigateTo('welcome');
            },
            onExitToStudentPortal: () => _navigateTo('home'),
          );
        }
        break;

      case 'timetable':
        activeScreen = StudentTimetableScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'rewards':
        activeScreen = RewardsScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'attendance':
        activeScreen = AttendanceScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'certificates':
        activeScreen = CertificatesScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'academic_resources':
        activeScreen = AcademicResourcesScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'chat':
        activeScreen = ChatScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'mom':
        activeScreen = MomScreen(
          authState: widget.authState,
          onNavigate: (route, _) => _navigateTo(route),
        );
        break;

      case 'print_shop':
      case 'library_print':
        activeScreen = StudentPrintScreen(
          authState: widget.authState,
          onBackToHome: () => _navigateTo('home'),
        );
        break;

      case 'library_panel':
      case 'library_staff':
        activeScreen = LibraryStaffDashboardScreen(
          authState: widget.authState,
          onBackToHome: () => _navigateTo('home'),
          onSignOut: () async {
            widget.realtimeService.clearSession();
            await widget.authState.signOut();
            _navigateTo('welcome');
          },
        );
        break;

      case 'clubs':
      case 'campus_clubs':
        activeScreen = CampusClubsScreen(
          authState: widget.authState,
          onBackToHome: () => _navigateTo('home'),
        );
        break;

      case 'interview_prep':
      case 'mock_interview':
      case 'placements':
        activeScreen = InterviewPrepScreen(
          authState: widget.authState,
          onBackToHome: () => _navigateTo('home'),
        );
        break;

      default:
        activeScreen = HomeDashboardScreen(
          authState: widget.authState,
          realtimeService: widget.realtimeService,
          onNavigate: (route, _) => _navigateTo(route),
        );
    }

    if (_currentRoute == 'admin_login' ||
        _currentRoute == 'master_admin' ||
        _currentRoute == 'library_panel') {
      return activeScreen;
    }

    return PopScope(
      canPop: _currentRoute == 'welcome' || _currentRoute == 'home',
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          _navigateTo(widget.authState.isAuthenticated ? 'home' : 'welcome');
        }
      },
      child: ResponsiveScaffold(
        currentRoute: _currentRoute,
        onNavigate: (route, _) => _navigateTo(route),
        authState: widget.authState,
        preferencesService: widget.preferencesService,
        realtimeService: widget.realtimeService,
        showProgress: _currentRoute == 'events' || _currentRoute == 'faq',
        body: activeScreen,
      ),
    );
  }
}
