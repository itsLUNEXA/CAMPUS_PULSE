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
    final surfaceColor = isDark
        ? AppleTokens.darkSurface
        : AppleTokens.background;
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
          if (widget.showFab && widget.currentRoute != 'timetable')
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
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : Colors.white,
            borderRadius: BorderRadius.circular(AppleTokens.radius12),
            border: Border.all(
              color: isDark ? AppleTokens.darkBorder : AppleTokens.borderSubtle,
              width: 1.0,
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x12000000),
                blurRadius: 10,
                offset: Offset(0, 4),
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
              const SizedBox(width: 8),
              _floatingNavIcon(
                icon: Icons.grid_view_rounded,
                isActive: current == 'events',
                onTap: () => widget.onNavigate('events', Container()),
              ),
              const SizedBox(width: 8),
              _floatingNavIcon(
                icon: Icons.bar_chart_rounded,
                isActive: current == 'leaderboard' || current == 'quizzes',
                onTap: () => widget.onNavigate(
                  isAuthed ? 'leaderboard' : 'quizzes',
                  Container(),
                ),
              ),
              const SizedBox(width: 8),
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
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppleTokens.primaryTeal,
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
      );
    }
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppleTokens.radius8),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        child: Icon(
          icon,
          color: AppleTokens.neutralBrown,
          size: 20,
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
        color: isDark
            ? AppleTokens.darkSurface
            : AppleTokens.warmWhite.withValues(alpha: 0.98),
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
                color: isDark
                    ? AppleTokens.darkTextPrimary
                    : AppleTokens.darkNavy,
              ),
              tooltip: 'Open navigation menu',
              onPressed: () => _scaffoldKey.currentState?.openDrawer(),
            ),

          // Logo / Brand
          InkWell(
            onTap: () {
              final target = widget.authState.isAuthenticated
                  ? 'home'
                  : 'welcome';
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
                      color: AppleTokens.primaryTeal,
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppleTokens.space8),
                  Text(
                    'CAMPULSE',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.4,
                      color: isDark
                          ? AppleTokens.darkTextPrimary
                          : AppleTokens.neutralDark,
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
            _navButton('Clubs', 'clubs'),
            _navButton('Placement Mocks', 'interview_prep'),
            _navButton('Library & Notes', 'academic_resources'),
            _navButton('Print Shop', 'print_shop'),
            _navButton('Certificates', 'certificates'),
            if (widget.authState.isAuthenticated) ...[
              _navButton('Timetable', 'timetable'),
              _navButton('Perks', 'rewards'),
              _navButton('Chat Hub', 'chat'),
              _navButton('Attendance', 'attendance'),
              if (widget.authState.isLibraryStaff || widget.authState.isAdmin)
                _navButton('Library Panel', 'library_panel'),
            ],
            _navButton('FAQ & Help', 'faq'),
          ],

          const Spacer(),

          // Site Search Button (UX Feature 14.3)
          IconButton(
            icon: Icon(
              Icons.search_rounded,
              size: 20,
              color: isDark
                  ? AppleTokens.darkTextPrimary
                  : AppleTokens.darkNavy,
            ),
            tooltip: 'Search CAMPULSE',
            onPressed: () => widget.onNavigate('search', Container()),
          ),

          // Notifications Dropdown & Bell (UX Feature: Quick Notifications Panel)
          if (widget.authState.isAuthenticated)
            ListenableBuilder(
              listenable: widget.realtimeService,
              builder: (context, _) {
                final unread = widget.realtimeService.unreadCount;
                final notifs = widget.realtimeService.notifications;

                return PopupMenuButton<String>(
                  tooltip: 'Activity & Notifications',
                  offset: const Offset(0, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppleTokens.radius12),
                    side: BorderSide(
                      color: isDark
                          ? AppleTokens.darkBorder
                          : AppleTokens.border,
                    ),
                  ),
                  color: isDark
                      ? AppleTokens.darkSurface
                      : AppleTokens.cardSurface,
                  elevation: 8,
                  onSelected: (val) {
                    if (val == 'all') {
                      widget.onNavigate('notifications', Container());
                    } else if (val == 'mark_all') {
                      widget.realtimeService.markAllAsRead();
                    } else if (val.startsWith('notif_')) {
                      final id = int.tryParse(val.replaceFirst('notif_', ''));
                      if (id != null) {
                        widget.realtimeService.markAsRead(id);
                      }
                      widget.onNavigate('notifications', Container());
                    }
                  },
                  itemBuilder: (ctx) {
                    final items = <PopupMenuEntry<String>>[];

                    // Header row
                    items.add(
                      PopupMenuItem<String>(
                        enabled: false,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Notifications (${unread > 0 ? '$unread unread' : 'All caught up'})',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                                color: isDark
                                    ? AppleTokens.darkTextPrimary
                                    : AppleTokens.primaryText,
                              ),
                            ),
                            if (unread > 0)
                              InkWell(
                                onTap: () {
                                  Navigator.of(ctx).pop();
                                  widget.realtimeService.markAllAsRead();
                                },
                                child: const Text(
                                  'Mark read',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppleTokens.primaryTeal,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                    items.add(const PopupMenuDivider());

                    if (notifs.isEmpty) {
                      items.add(
                        const PopupMenuItem<String>(
                          enabled: false,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Center(
                              child: Text(
                                'No recent notifications',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppleTokens.mutedText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      final previewList = notifs.take(4).toList();
                      for (final n in previewList) {
                        items.add(
                          PopupMenuItem<String>(
                            value: 'notif_${n.id}',
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 280),
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.only(
                                      top: 5,
                                      right: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: n.isRead
                                          ? Colors.transparent
                                          : AppleTokens.primaryTeal,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          n.title,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: n.isRead
                                                ? FontWeight.w500
                                                : FontWeight.w700,
                                            color: isDark
                                                ? AppleTokens.darkTextPrimary
                                                : AppleTokens.primaryText,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          n.message,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            color: AppleTokens.secondaryText,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    }

                    items.add(const PopupMenuDivider());
                    items.add(
                      const PopupMenuItem<String>(
                        value: 'all',
                        child: Center(
                          child: Text(
                            'View All Notifications →',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppleTokens.primaryTeal,
                            ),
                          ),
                        ),
                      ),
                    );

                    return items;
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Badge(
                      isLabelVisible: unread > 0,
                      label: Text(unread > 99 ? '99+' : '$unread'),
                      backgroundColor: AppleTokens.primaryTeal,
                      textColor: Colors.white,
                      child: Icon(
                        unread > 0
                            ? Icons.notifications_active_rounded
                            : Icons.notifications_none_rounded,
                        size: 20,
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.primaryTeal,
                      ),
                    ),
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
                final initials = student?.fullName.isNotEmpty == true
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
                    } else if (val == 'library_panel') {
                      widget.onNavigate('library_panel', Container());
                    } else if (val == 'logout') {
                      widget.realtimeService.clearSession();
                      await widget.authState.signOut();
                      widget.onNavigate('welcome', Container());
                    }
                  },
                  itemBuilder: (ctx) => [
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
                    if (widget.authState.isLibraryStaff ||
                        widget.authState.isAdmin)
                      const PopupMenuItem(
                        value: 'library_panel',
                        child: Text('Library Staff Panel'),
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
                      border: Border.all(
                        color: AppleTokens.softLavender,
                        width: 2,
                      ),
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
                        foregroundColor: AppleTokens.primaryTeal,
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
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => widget.onNavigate('auth', Container()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppleTokens.primaryTeal,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        decoration: BoxDecoration(
          color: isActive ? AppleTokens.lightMint : Colors.transparent,
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          border: Border.all(
            color: isActive ? AppleTokens.purple : Colors.transparent,
          ),
        ),
        child: InkWell(
          onTap: () => widget.onNavigate(route, Container()),
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              label,
              style: _sansText(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? AppleTokens.primaryTeal
                    : (isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.neutralBrown),
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
      itemBuilder: (ctx) => const [
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
                color: isDark ? AppleTokens.darkSurfaceElevated : Colors.white,
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? AppleTokens.darkBorder
                        : AppleTokens.borderSubtle,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppleTokens.primaryTeal,
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
                    ),
                    child: const Center(
                      child: Text(
                        'C',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppleTokens.space12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CAMPULSE',
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: isDark
                              ? AppleTokens.darkTextPrimary
                              : AppleTokens.neutralDark,
                        ),
                      ),
                      Text(
                        isAuthed && student != null
                            ? student.fullName
                            : 'Discover. Connect. Compete.',
                        style: _sansText(
                          fontSize: 12,
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.neutralBrown,
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
                  _drawerTile(
                    'Campus Clubs & Query Desk',
                    Icons.groups_outlined,
                    'clubs',
                  ),
                  _drawerTile(
                    'Mock Interview & Placement Prep',
                    Icons.school_outlined,
                    'interview_prep',
                  ),
                  _drawerTile(
                    'Academic Library & PYQs',
                    Icons.menu_book_outlined,
                    'academic_resources',
                  ),
                  _drawerTile(
                    'Print Shop & Points Wallet',
                    Icons.local_printshop_outlined,
                    'print_shop',
                  ),
                  _drawerTile(
                    'Event Certificates',
                    Icons.workspace_premium_outlined,
                    'certificates',
                  ),
                  if (isAuthed) ...[
                    if (widget.authState.isLibraryStaff ||
                        widget.authState.isAdmin)
                      _drawerTile(
                        'Library Counter Staff Panel',
                        Icons.print_rounded,
                        'library_panel',
                      ),
                    _drawerTile(
                      'My Timetable & Free Slots',
                      Icons.schedule_rounded,
                      'timetable',
                    ),
                    _drawerTile(
                      'Points & Perks Catalog',
                      Icons.card_giftcard_rounded,
                      'rewards',
                    ),
                    _drawerTile(
                      'Campus Chat Hub',
                      Icons.chat_bubble_outline,
                      'chat',
                    ),
                    _drawerTile(
                      'Attendance Check-In',
                      Icons.fact_check_outlined,
                      'attendance',
                    ),
                    _drawerTile(
                      'Minutes of Meeting (MoM)',
                      Icons.assignment_outlined,
                      'mom',
                    ),
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
                    color: isDark
                        ? AppleTokens.darkBorder
                        : AppleTokens.lightConcrete,
                  ),
                ),
              ),
              child: isAuthed
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
                              foregroundColor: AppleTokens.primaryTeal,
                              side: const BorderSide(
                                color: AppleTokens.borderSubtle,
                              ),
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
                              backgroundColor: AppleTokens.primaryTeal,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppleTokens.radius8),
        ),
        tileColor: isActive
            ? (isDark ? AppleTokens.darkSurfaceElevated : AppleTokens.lightMint)
            : Colors.transparent,
        leading: Icon(
          icon,
          color: isActive
              ? AppleTokens.primaryTeal
              : (isDark
                    ? AppleTokens.darkTextSecondary
                    : AppleTokens.neutralBrown),
          size: 20,
        ),
        title: Text(
          title,
          style: _sansText(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive
                ? AppleTokens.primaryTeal
                : (isDark
                      ? AppleTokens.darkTextPrimary
                      : AppleTokens.neutralDark),
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
