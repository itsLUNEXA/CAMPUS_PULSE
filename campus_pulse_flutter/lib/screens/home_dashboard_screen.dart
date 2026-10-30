import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class HomeDashboardScreen extends StatefulWidget {
  final AuthState authState;
  final RealtimeService realtimeService;
  final Function(String route, Widget screen) onNavigate;

  const HomeDashboardScreen({
    super.key,
    required this.authState,
    required this.realtimeService,
    required this.onNavigate,
  });

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  List<CampusEvent> _events = [];
  List<StudentProfile> _recommendedPartners = [];
  LeaderboardEntry? _myRank;
  bool _isLoading = true;
  bool _isRetrying = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadDashboardData();
  }

  Future<void> _loadDashboardData() async {
    if (_isRetrying && _isLoading) return;
    setState(() {
      _isLoading = true;
      _isRetrying = true;
      _errorMessage = null;
    });

    List<CampusEvent> events = [];
    List<StudentProfile> partners = [];
    LeaderboardEntry? rank;
    Object? fetchError;

    try {
      events = await client.event
          .listEvents(limit: 3, offset: 0)
          .timeout(const Duration(seconds: 8));
    } catch (e) {
      fetchError = e;
    }

    try {
      partners = await client.student
          .discoverStudents(limit: 3, offset: 0)
          .timeout(const Duration(seconds: 8));
    } catch (_) {}

    if (widget.authState.isAuthenticated) {
      try {
        rank = await client.leaderboard.getMyRank().timeout(
          const Duration(seconds: 5),
        );
      } catch (_) {}
    }

    if (mounted) {
      setState(() {
        _events = events;
        _recommendedPartners = partners;
        _myRank = rank;
        _isLoading = false;
        _isRetrying = false;
        if (events.isEmpty && fetchError != null) {
          _errorMessage = _classifyError(fetchError);
        }
      });
    }
  }

  String _classifyError(Object error) {
    final str = error.toString().toLowerCase();
    if (str.contains('timeout')) {
      return 'Request timed out. Please check your connection and retry.';
    }
    if (str.contains('socketexception') ||
        str.contains('connection refused') ||
        str.contains('failed host lookup') ||
        str.contains('clientexception')) {
      return 'Unable to reach Campus Pulse server. Please ensure the backend server is running on http://localhost:8080.';
    }
    return 'Could not load campus data. Tap Retry to try again.';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final student = widget.authState.currentProfile;
    final studentName = student?.fullName ?? 'Student';
    final initial = studentName.isNotEmpty ? studentName[0].toUpperCase() : 'S';
    final now = DateTime.now();
    final todayStr = 'Today, ${now.day} ${_monthAbbr(now.month)}';

    return RefreshIndicator(
      onRefresh: _loadDashboardData,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space24,
          vertical: AppleTokens.space24,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 880),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. GREETING & PROFILE HEADER (Reference matching)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: AppleTokens.pastelYellow,
                          child: Text(
                            initial,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppleTokens.darkNavy,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello, $studentName',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              todayStr,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isDark ? AppleTokens.darkTextSecondary : AppleTokens.textMutedGrey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.search_rounded,
                        size: 24,
                        color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                      ),
                      onPressed: () => widget.onNavigate('events', Container()),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // 2. DAILY CHALLENGE TOP CARD (Soft Lavender with 3D Geometric shapes)
                _buildDailyChallengeCard(context, isDark),
                const SizedBox(height: 20),

                // 3. HORIZONTAL DATE SELECTOR STRIP (Reference matching)
                _buildDateSelectorStrip(context, isDark, now),
                const SizedBox(height: 28),

                // 4. "YOUR PLAN" / "YOUR CAMPUS" SECTION (Pastel Yellow, Blue & Pink cards)
                Text(
                  'Your plan',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                  ),
                ),
                const SizedBox(height: 16),
                _buildYourPlanGrid(context, isDark),
                const SizedBox(height: 36),

                // 5. UPCOMING EVENTS FEED
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Upcoming Campus Events',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                      ),
                    ),
                    TextButton(
                      onPressed: () => widget.onNavigate('events', Container()),
                      child: Text(
                        'View All Events',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(32),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_errorMessage != null)
                  AppleCard(
                    padding: const EdgeInsets.all(AppleTokens.space24),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.wifi_off_rounded,
                            size: 32,
                            color: AppleTokens.error,
                          ),
                          const SizedBox(height: AppleTokens.space12),
                          Text(
                            _errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 13),
                          ),
                          const SizedBox(height: AppleTokens.space16),
                          AppleButton(
                            label: _isRetrying ? 'Retrying...' : 'Retry',
                            icon: _isRetrying ? null : Icons.refresh_rounded,
                            onPressed: _isRetrying ? null : _loadDashboardData,
                            height: 36,
                          ),
                        ],
                      ),
                    ),
                  )
                else if (_events.isEmpty)
                  _emptyState(context, 'No events currently listed.')
                else
                  Column(
                    children: _events
                        .map((e) => _eventRow(context, e, isDark))
                        .toList(),
                  ),

                const SizedBox(height: 36),

                // 6. STUDY MATCH RECOMMENDATIONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Suggested Study Partners',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          widget.onNavigate('study_buddies', Container()),
                      child: Text(
                        'Find More Partners',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.darkNavy,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                if (_recommendedPartners.isEmpty && !_isLoading)
                  _emptyState(
                    context,
                    'No study partners found matching current filters.',
                  )
                else
                  Wrap(
                    spacing: AppleTokens.space16,
                    runSpacing: AppleTokens.space16,
                    children: _recommendedPartners
                        .map((p) => _partnerCard(context, p, isDark))
                        .toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- 2. DAILY CHALLENGE CARD ---
  Widget _buildDailyChallengeCard(BuildContext context, bool isDark) {
    return InkWell(
      onTap: () => widget.onNavigate('quizzes', Container()),
      borderRadius: BorderRadius.circular(28),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: AppleTokens.softLavender,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppleTokens.softLavender.withValues(alpha: 0.35),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Daily\nchallenge',
                    style: GoogleFonts.inter(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: AppleTokens.darkNavy,
                      height: 1.15,
                      letterSpacing: -0.6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Test your knowledge before 09:00 PM',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppleTokens.darkNavy.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Participant Avatars Row
                  Row(
                    children: [
                      _stackedAvatar('A', AppleTokens.pastelPink),
                      _stackedAvatar('M', AppleTokens.pastelYellow, offset: -8),
                      _stackedAvatar('T', AppleTokens.pastelBlue, offset: -8),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppleTokens.darkNavy.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          '+4',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppleTokens.darkNavy,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 3D Shapes Geometric Illustration
            SizedBox(
              width: 110,
              height: 110,
              child: CustomPaint(
                painter: _DailyChallengeShapesPainter(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stackedAvatar(String text, Color bg, {double offset = 0}) {
    return Transform.translate(
      offset: Offset(offset, 0),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: bg,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppleTokens.darkNavy,
            ),
          ),
        ),
      ),
    );
  }

  // --- 3. HORIZONTAL DATE SELECTOR STRIP ---
  Widget _buildDateSelectorStrip(BuildContext context, bool isDark, DateTime now) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final currentDayIndex = now.weekday % 7; // Sunday=0, Monday=1...

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (i) {
          final isSelected = i == currentDayIndex;
          final dateNum = now.day - (currentDayIndex - i);

          if (isSelected) {
            // Selected Black/Navy Pill with Notification Dot
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: AppleTokens.darkNavy,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    days[i],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '$dateNum',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            );
          }

          // Unselected Date Pill
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurface : AppleTokens.warmWhite,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isDark ? AppleTokens.darkBorder : AppleTokens.borderPastel,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 11),
                Text(
                  days[i],
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? AppleTokens.darkTextSecondary : AppleTokens.textMutedGrey,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$dateNum',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.darkNavy,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- 4. "YOUR PLAN" GRID (Yellow, Blue, Pink Cards) ---
  Widget _buildYourPlanGrid(BuildContext context, bool isDark) {
    final firstEvent = _events.isNotEmpty ? _events.first : null;
    final secondEvent = _events.length > 1 ? _events[1] : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final leftWidth = isWide ? (constraints.maxWidth - 16) * 0.5 : constraints.maxWidth;
        final rightWidth = isWide ? (constraints.maxWidth - 16) * 0.5 : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Left Card: Pastel Yellow (Event Spotlight)
            SizedBox(
              width: leftWidth,
              height: 270,
              child: InkWell(
                onTap: () => widget.onNavigate('events', Container()),
                borderRadius: BorderRadius.circular(28),
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: AppleTokens.pastelYellow,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: AppleTokens.pastelYellow.withValues(alpha: 0.35),
                        blurRadius: 18,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.55),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          firstEvent?.category ?? 'Featured Session',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppleTokens.darkNavy,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      Text(
                        firstEvent?.title ?? 'HackPulse Prep & Coding Meet',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.darkNavy,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 10),

                      Text(
                        firstEvent != null
                            ? '${firstEvent.startTime.day} ${_monthAbbr(firstEvent.startTime.month)} • ${firstEvent.startTime.hour}:00'
                            : '25 Nov. 14:00-15:00',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppleTokens.darkNavy.withValues(alpha: 0.8),
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        firstEvent?.venue ?? 'A5 Room • Innovation Hub',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppleTokens.darkNavy.withValues(alpha: 0.7),
                        ),
                      ),

                      const Spacer(),

                      // Bottom Host / Lead Avatar
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Text(
                              firstEvent?.title.isNotEmpty == true ? firstEvent!.title[0] : 'H',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: AppleTokens.darkNavy,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Host / Trainer',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: AppleTokens.darkNavy.withValues(alpha: 0.6),
                                ),
                              ),
                              Text(
                                '${firstEvent?.rsvpCount ?? 32} Students Attending',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppleTokens.darkNavy,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Right Column: Blue Card (Top) + Pink Card (Bottom)
            SizedBox(
              width: rightWidth,
              height: 270,
              child: Column(
                children: [
                  // Blue Card (Quiz / Academic Challenge)
                  Expanded(
                    child: InkWell(
                      onTap: () => widget.onNavigate('quizzes', Container()),
                      borderRadius: BorderRadius.circular(24),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: AppleTokens.pastelBlue,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppleTokens.pastelBlue.withValues(alpha: 0.3),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withValues(alpha: 0.55),
                                      borderRadius: BorderRadius.circular(999),
                                    ),
                                    child: Text(
                                      'Academic',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppleTokens.darkNavy,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    secondEvent?.title ?? 'Quiz Challenge',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w800,
                                      color: AppleTokens.darkNavy,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _myRank != null
                                        ? 'Rank #${_myRank!.rank} • Compete & Climb'
                                        : 'Compete & Climb Ranks',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                      color: AppleTokens.darkNavy.withValues(alpha: 0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.emoji_events_rounded,
                                color: AppleTokens.darkNavy,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Pink Card (Community Quick Actions)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: AppleTokens.pastelPink,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: AppleTokens.pastelPink.withValues(alpha: 0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _socialCircleButton(
                            icon: Icons.chat_bubble_outline_rounded,
                            tooltip: 'Study Requests',
                            onTap: () => widget.onNavigate('study_requests', Container()),
                          ),
                          _socialCircleButton(
                            icon: Icons.people_outline_rounded,
                            tooltip: 'Find Buddies',
                            onTap: () => widget.onNavigate('study_buddies', Container()),
                          ),
                          _socialCircleButton(
                            icon: Icons.leaderboard_outlined,
                            tooltip: 'Leaderboard',
                            onTap: () => widget.onNavigate('leaderboard', Container()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _socialCircleButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Container(
          width: 42,
          height: 42,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppleTokens.darkNavy,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _eventRow(BuildContext context, CampusEvent event, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space12),
      child: AppleCard(
        onTap: () => widget.onNavigate('event_detail', Container()),
        padding: const EdgeInsets.all(AppleTokens.space16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color:
                    isDark
                        ? AppleTokens.darkSurfaceElevated
                        : AppleTokens.palePurple,
                borderRadius: BorderRadius.circular(AppleTokens.radius12),
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${event.startTime.day}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color:
                            isDark
                                ? AppleTokens.darkTextPrimary
                                : AppleTokens.deepNavy,
                      ),
                    ),
                    Text(
                      _monthAbbr(event.startTime.month),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color:
                            isDark
                                ? AppleTokens.darkAccentPurple
                                : AppleTokens.accentPurple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppleTokens.space16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: (isDark
                              ? AppleTokens.darkBorder
                              : AppleTokens.lightNeutral),
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius999,
                          ),
                        ),
                        child: Text(
                          event.category,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        event.venue,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.people_outline,
                  size: 16,
                  color: AppleTokens.secondaryText,
                ),
                const SizedBox(width: 4),
                Text(
                  '${event.rsvpCount} RSVPs',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _partnerCard(
    BuildContext context,
    StudentProfile student,
    bool isDark,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: AppleTokens.primaryBlue,
                  child: Text(
                    student.fullName.isNotEmpty
                        ? student.fullName[0].toUpperCase()
                        : 'S',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(width: AppleTokens.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        '${student.branch} • Year ${student.academicYear}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppleTokens.space12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: student.subjectInterests.map((s) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppleTokens.darkSurfaceElevated
                        : AppleTokens.lightNeutral,
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: Text(
                    s,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context, String message) {
    return AppleCard(
      padding: const EdgeInsets.all(AppleTokens.space32),
      child: Center(
        child: Text(
          message,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  String _monthAbbr(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];
    return months[(month - 1).clamp(0, 11)];
  }
}

/// Custom painter for the 3D pastel geometric illustration on the Daily Challenge card
class _DailyChallengeShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // 1. Dark Grey-Slate Ring/Cylinder on left
    final cylinderPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF5A6075), Color(0xFF35394B)],
      ).createShader(Rect.fromLTWH(w * 0.05, h * 0.22, w * 0.42, h * 0.42));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.05, h * 0.22, w * 0.42, h * 0.42),
        const Radius.circular(16),
      ),
      cylinderPaint,
    );
    final holePaint = Paint()..color = const Color(0xFF2B2E3D);
    canvas.drawCircle(Offset(w * 0.26, h * 0.43), w * 0.1, holePaint);

    // 2. Yellow Upright Torus on Top Right
    final yellowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFD56B), Color(0xFFFF9E1B)],
      ).createShader(Rect.fromLTWH(w * 0.45, h * 0.02, w * 0.48, h * 0.48));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.45, h * 0.02, w * 0.48, h * 0.48),
        const Radius.circular(22),
      ),
      yellowPaint,
    );
    final yellowHolePaint = Paint()..color = const Color(0xFFD47C00);
    canvas.drawCircle(Offset(w * 0.69, h * 0.26), w * 0.12, yellowHolePaint);

    // 3. Pastel Lilac / Clay Sphere/Block in Center
    final lilacPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE2D6FF), Color(0xFFBCA6F8)],
      ).createShader(Rect.fromLTWH(w * 0.42, h * 0.32, w * 0.38, h * 0.38));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.42, h * 0.32, w * 0.38, h * 0.38),
        const Radius.circular(14),
      ),
      lilacPaint,
    );

    // 4. Yellow Mini Torus / Ring at bottom left
    final miniYellowPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFFFE082), Color(0xFFFFB300)],
      ).createShader(Rect.fromLTWH(w * 0.08, h * 0.66, w * 0.28, h * 0.28));
    canvas.drawCircle(Offset(w * 0.22, h * 0.8), w * 0.14, miniYellowPaint);
    final miniHolePaint = Paint()..color = AppleTokens.softLavender;
    canvas.drawCircle(Offset(w * 0.22, h * 0.8), w * 0.06, miniHolePaint);

    // 5. Dark Graphite Pill at Bottom Right
    final darkPillPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF6B6E7E), Color(0xFF383B47)],
      ).createShader(Rect.fromLTWH(w * 0.44, h * 0.52, w * 0.42, h * 0.44));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(w * 0.44, h * 0.52, w * 0.42, h * 0.44),
        const Radius.circular(18),
      ),
      darkPillPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
