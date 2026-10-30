import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_state.dart';
import '../services/preferences_service.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';
import 'back_to_top_button.dart';
import 'cookie_banner.dart';
import 'floating_contact_button.dart';
import 'scroll_progress_bar.dart';
import 'skip_to_content_link.dart';

class NavDestinationItem {
  final String label;
  final IconData icon;
  final Widget screen;
  final bool requiresAuth;

  const NavDestinationItem({
    required this.label,
    required this.icon,
    required this.screen,
    this.requiresAuth = false,
  });
}

class ResponsiveScaffold extends StatefulWidget {
  final Widget body;
  final String currentRoute;
  final Function(String route, Widget screen) onNavigate;
  final AuthState authState;
  final PreferencesService preferencesService;
  final RealtimeService realtimeService;
  final ScrollController? scrollController;
  final bool showProgress;
  final bool showFab;

  const ResponsiveScaffold({
    super.key,
    required this.body,
    required this.currentRoute,
    required this.onNavigate,
    required this.authState,
    required this.preferencesService,
    required this.realtimeService,
    this.scrollController,
    this.showProgress = false,
    this.showFab = true,
  });

  @override
  State<ResponsiveScaffold> createState() => _ResponsiveScaffoldState();
}

class _ResponsiveScaffoldState extends State<ResponsiveScaffold> {
  late final ScrollController _effectiveScrollController;
  final FocusNode _mainContentFocusNode = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _effectiveScrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    if (widget.scrollController == null) {
      _effectiveScrollController.dispose();
    }
    _mainContentFocusNode.dispose();
    super.dispose();
  }

  TextStyle _serifHeadline({
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) {
    try {
      return GoogleFonts.newsreader(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: -0.4,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: 'Georgia, serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
    }
  }

  TextStyle _sansText({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w500,
    Color? color,
  }) {
    try {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: '-apple-system, Roboto, sans-serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isWide = MediaQuery.of(context).size.width >= 960;
    final surfaceColor =
        isDark ? AppleTokens.darkSurface : AppleTokens.background;
    final borderColor = isDark ? AppleTokens.darkBorder : AppleTokens.border;

    return Scaffold(
      key: _scaffoldKey,
      drawer: isWide ? null : _buildMobileDrawer(context, isDark),
      body: Stack(
        children: [
          // Main Body
          Column(
            children: [
              // Sticky Header (UX Feature 14.11) - hidden on welcome landing page which has its own integrated Mindly navbar
              if (widget.currentRoute != 'welcome')
                _buildHeader(
                  context,
                  isDark,
                  isWide,
                  surfaceColor,
                  borderColor,
                ),

              // Scroll Progress Bar (UX Feature 14.8)
              if (widget.showProgress)
                ScrollProgressBar(scrollController: _effectiveScrollController),

              // Content Area with Focus Target for Skip-to-Content
              Expanded(
                child: Focus(
                  focusNode: _mainContentFocusNode,
                  child: widget.body,
                ),
              ),
            ],
          ),

          // Skip to Content Link (UX Feature 14.12)
          SkipToContentLink(targetFocusNode: _mainContentFocusNode),

          // Back to Top Button (UX Feature 14.4)
          Positioned(
            bottom: AppleTokens.space24,
            right: AppleTokens.space24,
            child: BackToTopButton(
              scrollController: _effectiveScrollController,
            ),
          ),

          // Floating Contact Button (UX Feature 14.20)
          if (widget.showFab)
            Positioned(
              bottom: AppleTokens.space24,
              left: AppleTokens.space24,
              child: const FloatingContactButton(),
            ),

          // Cookie Banner (UX Feature 14.2)
          CookieBanner(preferencesService: widget.preferencesService),

          // Floating Rounded Dark Navy Bottom Navigation Bar (Mobile reference match)
          if (!isWide && widget.currentRoute != 'welcome')
            _buildFloatingBottomNavBar(context, isDark),
        ],
      ),
    );
  }

  Widget _buildFloatingBottomNavBar(BuildContext context, bool isDark) {
    final current = widget.currentRoute;
    final isAuthed = widget.authState.isAuthenticated;

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppleTokens.darkNavy,
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: AppleTokens.darkNavy.withValues(alpha: 0.35),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _floatingNavIcon(
                icon: Icons.home_rounded,
                isActive: current == 'home' || current == 'welcome',
                onTap: () {
                  final target = isAuthed ? 'home' : 'welcome';
                  widget.onNavigate(target, Container());
                },
              ),
              const SizedBox(width: 14),
              _floatingNavIcon(
                icon: Icons.grid_view_rounded,
                isActive: current == 'events',
                onTap: () => widget.onNavigate('events', Container()),
              ),
              const SizedBox(width: 14),
              _floatingNavIcon(
                icon: Icons.bar_chart_rounded,
                isActive: current == 'leaderboard' || current == 'quizzes',
                onTap: () => widget.onNavigate(
                  isAuthed ? 'leaderboard' : 'quizzes',
                  Container(),
                ),
              ),
              const SizedBox(width: 14),
              _floatingNavIcon(
                icon: Icons.person_outline_rounded,
                isActive: current == 'profile' || current == 'auth',
                onTap: () => widget.onNavigate(
                  isAuthed ? 'profile' : 'auth',
                  Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _floatingNavIcon({
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    if (isActive) {
      return Container(
        width: 44,
        height: 44,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            icon,
            color: AppleTokens.darkNavy,
            size: 22,
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      child: Container(
        width: 44,
        height: 44,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.7),
          size: 22,
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    bool isDark,
    bool isWide,
    Color surfaceColor,
    Color borderColor,
  ) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.darkSurface : AppleTokens.warmWhite.withValues(alpha: 0.98),
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppleTokens.darkBorder : AppleTokens.borderPastel,
            width: AppleTokens.space1,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppleTokens.space24),
      child: Row(
        children: [
          // Mobile Hamburger Menu (UX Feature 14.5)
          if (!isWide)
            IconButton(
              icon: Icon(
                Icons.menu_rounded,
                color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
              ),
              tooltip: 'Open navigation menu',
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),

          // Logo / Brand (Pastel Mobile style)
          InkWell(
            onTap: () {
              final target =
                  widget.authState.isAuthenticated ? 'home' : 'welcome';
              widget.onNavigate(target, Container());
            },
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppleTokens.space8,
                vertical: AppleTokens.space4,
              ),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppleTokens.darkNavy,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: AppleTokens.darkNavy.withValues(alpha: 0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.bolt_rounded,
                        size: 20,
                        color: AppleTokens.softLavender,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppleTokens.space8),
                  Text(
                    'Campus Pulse',
                    style: GoogleFonts.inter(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                      color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Desktop Nav Links with Pill Active Indicators
          if (isWide) ...[
            const SizedBox(width: AppleTokens.space24),
            _navButton(
              'Home',
              widget.authState.isAuthenticated ? 'home' : 'welcome',
            ),
            _navButton('Events', 'events'),
            _navButton('Library & Notes', 'academic_resources'),
            _navButton('Certificates', 'certificates'),
            if (widget.authState.isAuthenticated) ...[
              _navButton('Timetable', 'timetable'),
              _navButton('Perks', 'rewards'),
              _navButton('Chat Hub', 'chat'),
              _navButton('Attendance', 'attendance'),
            ],
            _navButton('FAQ & Help', 'faq'),
          ],

          const Spacer(),

          // Site Search Button (UX Feature 14.3)
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              size: 20,
              color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
            ),
            tooltip: 'Search Campus Pulse',
            onPressed: () => widget.onNavigate('search', Container()),
          ),

          // Notifications Button (Real-time updates)
          if (widget.authState.isAuthenticated)
            ListenableBuilder(
              listenable: widget.realtimeService,
              builder: (context, _) {
                final count = widget.realtimeService.notifications.length;
                return Badge(
                  isLabelVisible: count > 0,
                  label: Text(count > 9 ? '9+' : '$count'),
                  backgroundColor: AppleTokens.pastelYellow,
                  textColor: AppleTokens.darkNavy,
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications_none_rounded,
                      size: 20,
                      color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                    ),
                    tooltip: 'Activity & Notifications',
                    onPressed:
                        () => widget.onNavigate('notifications', Container()),
                  ),
                );
              },
            ),

          // Dark Mode Toggle (UX Feature 14.1)
          _buildThemeToggle(context, isDark),

          const SizedBox(width: AppleTokens.space8),

          // Profile / Auth Action
          ListenableBuilder(
            listenable: widget.authState,
            builder: (context, _) {
              final isAuthed = widget.authState.isAuthenticated;
              if (isAuthed) {
                final student = widget.authState.currentProfile;
                final initials =
                    student?.fullName.isNotEmpty == true
                        ? student!.fullName.substring(0, 1).toUpperCase()
                        : 'U';

                return PopupMenuButton<String>(
                  tooltip: 'Account Menu',
                  onSelected: (val) async {
                    if (val == 'profile') {
                      widget.onNavigate('profile', Container());
                    } else if (val == 'requests') {
                      widget.onNavigate('study_requests', Container());
                    } else if (val == 'settings') {
                      widget.onNavigate('settings', Container());
                    } else if (val == 'admin_login') {
                      widget.onNavigate('admin_login', Container());
                    } else if (val == 'logout') {
                      await widget.authState.signOut();
                      widget.onNavigate('welcome', Container());
                    }
                  },
                  itemBuilder:
                      (ctx) => [
                        PopupMenuItem(
                          value: 'profile',
                          child: Text(
                            'Profile: ${student?.fullName ?? "Student"}',
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'requests',
                          child: Text('Study Requests'),
                        ),
                        const PopupMenuItem(
                          value: 'settings',
                          child: Text('Settings'),
                        ),
                        const PopupMenuItem(
                          value: 'admin_login',
                          child: Row(
                            children: [
                              Icon(
                                Icons.admin_panel_settings_rounded,
                                size: 18,
                                color: AppleTokens.softLavender,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Admin Portal',
                                style: TextStyle(
                                  color: AppleTokens.softLavender,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuDivider(),
                        const PopupMenuItem(
                          value: 'logout',
                          child: Row(
                            children: [
                              Icon(
                                Icons.logout_rounded,
                                size: 18,
                                color: AppleTokens.error,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Sign Out',
                                style: TextStyle(
                                  color: AppleTokens.error,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: AppleTokens.softLavender, width: 2),
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: AppleTokens.paleLavender,
                      child: Text(
                        initials,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () => widget.onNavigate('auth', Container()),
                      style: TextButton.styleFrom(
                        foregroundColor: AppleTokens.darkNavy,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: _sansText(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () => widget.onNavigate('auth', Container()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppleTokens.darkNavy,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 9,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Get Started',
                        style: _sansText(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _navButton(String label, String route) {
    final isActive = widget.currentRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: isActive ? AppleTokens.paleLavender : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isActive ? AppleTokens.softLavender : Colors.transparent,
          ),
        ),
        child: InkWell(
          onTap: () => widget.onNavigate(route, Container()),
          borderRadius: BorderRadius.circular(999),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: Text(
              label,
              style: _sansText(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w800 : FontWeight.w500,
                color: isActive ? AppleTokens.darkNavy : AppleTokens.textMutedGrey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle(BuildContext context, bool isDark) {
    return PopupMenuButton<ThemeMode>(
      tooltip: 'Theme mode',
      icon: Icon(
        isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
        size: 20,
      ),
      onSelected: (mode) => widget.preferencesService.setThemeMode(mode),
      itemBuilder:
          (ctx) => const [
            PopupMenuItem(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(Icons.brightness_auto, size: 18),
                  SizedBox(width: 8),
                  Text('System Appearance'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(Icons.light_mode, size: 18),
                  SizedBox(width: 8),
                  Text('Light Theme'),
                ],
              ),
            ),
            PopupMenuItem(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(Icons.dark_mode, size: 18),
                  SizedBox(width: 8),
                  Text('Dark Theme'),
                ],
              ),
            ),
          ],
    );
  }

  Widget _buildMobileDrawer(BuildContext context, bool isDark) {
    final isAuthed = widget.authState.isAuthenticated;
    final student = widget.authState.currentProfile;

    return Drawer(
      backgroundColor: isDark ? AppleTokens.darkSurface : AppleTokens.warmWhite,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(AppleTokens.space20),
              decoration: BoxDecoration(
                color: isDark ? AppleTokens.darkSurfaceElevated : AppleTokens.softSage,
                border: Border(
                  bottom: BorderSide(
                    color: isDark ? AppleTokens.darkBorder : AppleTokens.lightConcrete,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppleTokens.deepForest,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.bolt_rounded,
                        size: 22,
                        color: AppleTokens.sageGreen,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppleTokens.space12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Campus Pulse',
                        style: _serifHeadline(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.deepForest,
                        ),
                      ),
                      if (isAuthed && student != null)
                        Text(
                          student.fullName,
                          style: _sansText(
                            fontSize: 12,
                            color: isDark ? AppleTokens.darkTextSecondary : AppleTokens.mutedGrey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),

            // Navigation Links
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: AppleTokens.space12,
                  horizontal: 8,
                ),
                children: [
                  _drawerTile(
                    'Home',
                    Icons.dashboard_outlined,
                    isAuthed ? 'home' : 'welcome',
                  ),
                  _drawerTile('Events & RSVPs', Icons.event_outlined, 'events'),
                  _drawerTile('Academic Library & PYQs', Icons.menu_book_outlined, 'academic_resources'),
                  _drawerTile('Event Certificates', Icons.workspace_premium_outlined, 'certificates'),
                  if (isAuthed) ...[
                    _drawerTile('My Timetable & Free Slots', Icons.schedule_rounded, 'timetable'),
                    _drawerTile('Points & Perks Catalog', Icons.card_giftcard_rounded, 'rewards'),
                    _drawerTile('Campus Chat Hub', Icons.chat_bubble_outline, 'chat'),
                    _drawerTile('Attendance Check-In', Icons.fact_check_outlined, 'attendance'),
                    _drawerTile('Minutes of Meeting (MoM)', Icons.assignment_outlined, 'mom'),
                    _drawerTile(
                      'Peer Study Matching',
                      Icons.people_outline,
                      'study_buddies',
                    ),
                    _drawerTile(
                      'Academic Quizzes',
                      Icons.quiz_outlined,
                      'quizzes',
                    ),
                    _drawerTile(
                      'Live Leaderboard',
                      Icons.leaderboard_outlined,
                      'leaderboard',
                    ),
                    _drawerTile(
                      'Study Requests',
                      Icons.mail_outline,
                      'study_requests',
                    ),
                    _drawerTile(
                      'Profile & Bio',
                      Icons.person_outline,
                      'profile',
                    ),
                    _drawerTile(
                      'Notifications',
                      Icons.notifications_none_outlined,
                      'notifications',
                    ),
                    _drawerTile(
                      'Settings',
                      Icons.settings_outlined,
                      'settings',
                    ),
                  ],
                  _drawerTile('Help & FAQ', Icons.help_outline, 'faq'),
                  _drawerTile(
                    'Contact Support',
                    Icons.support_agent_outlined,
                    'contact',
                  ),
                ],
              ),
            ),

            // Bottom Drawer Actions (Auth / Sign Out)
            Container(
              padding: const EdgeInsets.all(AppleTokens.space16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: isDark ? AppleTokens.darkBorder : AppleTokens.lightConcrete,
                  ),
                ),
              ),
              child:
                  isAuthed
                      ? ListTile(
                        leading: const Icon(
                          Icons.logout_rounded,
                          color: AppleTokens.error,
                        ),
                        title: const Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppleTokens.error,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        onTap: () async {
                          Navigator.of(context).pop();
                          await widget.authState.signOut();
                          widget.onNavigate('welcome', Container());
                        },
                      )
                      : Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onNavigate('auth', Container());
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppleTokens.deepForest,
                                side: const BorderSide(color: AppleTokens.lightConcrete),
                              ),
                              child: const Text('Log In'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                widget.onNavigate('auth', Container());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppleTokens.burntAmber,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Get Started'),
                            ),
                          ),
                        ],
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerTile(String title, IconData icon, String route) {
    final isActive = widget.currentRoute == route;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor:
            isActive
                ? (isDark ? AppleTokens.darkSurfaceElevated : AppleTokens.softSage)
                : Colors.transparent,
        leading: Icon(
          icon,
          color:
              isActive
                  ? (isDark ? AppleTokens.sageGreen : AppleTokens.deepForest)
                  : (isDark ? AppleTokens.darkTextSecondary : AppleTokens.mutedGrey),
          size: 20,
        ),
        title: Text(
          title,
          style: _sansText(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.deepForest,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop();
          widget.onNavigate(route, Container());
        },
      ),
    );
  }
}
