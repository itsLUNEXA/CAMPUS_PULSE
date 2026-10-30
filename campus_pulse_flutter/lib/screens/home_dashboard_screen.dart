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
      if (widget.authState.isAuthenticated) {
        events = await client.event
            .getRecommendedEvents(limit: 3)
            .timeout(const Duration(seconds: 8));
      } else {
        events = await client.event
            .listEvents(limit: 3, offset: 0)
            .timeout(const Duration(seconds: 8));
      }
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
                                color: isDark
                                    ? AppleTokens.darkTextPrimary
                                    : AppleTokens.darkNavy,
                                letterSpacing: -0.5,
                              ),
                            ),
                            Text(
                              todayStr,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.textMutedGrey,
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
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.darkNavy,
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
                    color: isDark
                        ? AppleTokens.darkTextPrimary
                        : AppleTokens.darkNavy,
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
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.darkNavy,
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
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.darkNavy,
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
      borderRadius: BorderRadius.circular(AppleTokens.radius12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppleTokens.darkSurface : Colors.white,
          borderRadius: BorderRadius.circular(AppleTokens.radius12),
          border: Border.all(
            color: isDark ? AppleTokens.darkBorder : AppleTokens.borderSubtle,
            width: 1.0,
          ),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppleTokens.lightMint,
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
                    ),
                    child: Text(
                      'Syllabus Quiz',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppleTokens.primaryTeal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Daily Academic Challenge',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppleTokens.darkTextPrimary
                          : AppleTokens.neutralDark,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Test your course subject knowledge before 09:00 PM',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.neutralBrown,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Participant Avatars Row
                  Row(
                    children: [
                      _stackedAvatar('A', AppleTokens.lightMint),
                      _stackedAvatar('M', AppleTokens.lightMint, offset: -8),
                      _stackedAvatar('T', AppleTokens.lightMint, offset: -8),
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppleTokens.lightMint,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                        child: Text(
                          '+4 peers',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppleTokens.primaryTeal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Functional icon badge instead of decorative 3D shapes painter
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppleTokens.lightMint,
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
              ),
              child: const Center(
                child: Icon(
                  Icons.quiz_rounded,
                  size: 28,
                  color: AppleTokens.primaryTeal,
                ),
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
              fontWeight: FontWeight.w700,
              color: AppleTokens.primaryTeal,
            ),
          ),
        ),
      ),
    );
  }

  // --- 3. HORIZONTAL DATE SELECTOR STRIP ---
  Widget _buildDateSelectorStrip(
    BuildContext context,
    bool isDark,
    DateTime now,
  ) {
    const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final currentDayIndex = now.weekday % 7; // Sunday=0, Monday=1...

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(7, (i) {
          final isSelected = i == currentDayIndex;
          final dateNum = now.day - (currentDayIndex - i);

          if (isSelected) {
            // Selected Pill
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: AppleTokens.primaryTeal,
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
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
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurface : Colors.white,
              borderRadius: BorderRadius.circular(AppleTokens.radius8),
              border: Border.all(
                color: isDark
                    ? AppleTokens.darkBorder
                    : AppleTokens.borderSubtle,
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
                    color: isDark
                        ? AppleTokens.darkTextSecondary
                        : AppleTokens.neutralBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$dateNum',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark
                        ? AppleTokens.darkTextPrimary
                        : AppleTokens.neutralDark,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- 4. "YOUR PLAN" GRID ---
  Widget _buildYourPlanGrid(BuildContext context, bool isDark) {
    final firstEvent = _events.isNotEmpty ? _events.first : null;
    final secondEvent = _events.length > 1 ? _events[1] : null;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 640;
        final leftWidth = isWide
            ? (constraints.maxWidth - 16) * 0.5
            : constraints.maxWidth;
        final rightWidth = isWide
            ? (constraints.maxWidth - 16) * 0.5
            : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            // Left Card (Event Spotlight)
            SizedBox(
              width: leftWidth,
              height: 270,
              child: InkWell(
                onTap: () => widget.onNavigate('events', Container()),
                borderRadius: BorderRadius.circular(AppleTokens.radius12),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: isDark ? AppleTokens.darkSurface : Colors.white,
                    borderRadius: BorderRadius.circular(AppleTokens.radius12),
                    border: Border.all(
                      color: isDark
                          ? AppleTokens.darkBorder
                          : AppleTokens.borderSubtle,
                      width: 1.0,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x08000000),
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tag Pill
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppleTokens.lightMint,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                        child: Text(
                          firstEvent?.category ?? 'Featured Session',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppleTokens.primaryTeal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 14),

                      Text(
                        firstEvent?.title ?? 'HackPulse Prep & Coding Meet',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppleTokens.darkTextPrimary
                              : AppleTokens.neutralDark,
                          letterSpacing: -0.4,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Text(
                        firstEvent != null
                            ? '${firstEvent.startTime.day} ${_monthAbbr(firstEvent.startTime.month)} • ${firstEvent.startTime.hour}:00'
                            : '25 Nov. 14:00-15:00',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.neutralBrown,
                        ),
                      ),
                      const SizedBox(height: 4),

                      Text(
                        firstEvent?.venue ?? 'A5 Room • Innovation Hub',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppleTokens.neutralSlate,
                        ),
                      ),

                      const Spacer(),

                      // Bottom Host / Lead Avatar
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppleTokens.lightMint,
                            child: Text(
                              firstEvent?.title.isNotEmpty == true
                                  ? firstEvent!.title[0]
                                  : 'H',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: AppleTokens.primaryTeal,
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
                                  color: AppleTokens.neutralSlate,
                                ),
                              ),
                              Text(
                                '${firstEvent?.rsvpCount ?? 32} Students Attending',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: isDark
                                      ? AppleTokens.darkTextPrimary
                                      : AppleTokens.neutralDark,
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

            // Right Column: Quiz Card (Top) + Community Actions (Bottom)
            SizedBox(
              width: rightWidth,
              height: 270,
              child: Column(
                children: [
                  // Quiz Card
                  Expanded(
                    child: InkWell(
                      onTap: () => widget.onNavigate('quizzes', Container()),
                      borderRadius: BorderRadius.circular(AppleTokens.radius12),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppleTokens.darkSurface
                              : Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius12,
                          ),
                          border: Border.all(
                            color: isDark
                                ? AppleTokens.darkBorder
                                : AppleTokens.borderSubtle,
                            width: 1.0,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x08000000),
                              blurRadius: 4,
                              offset: Offset(0, 2),
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
                                      horizontal: 8,
                                      vertical: 3,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppleTokens.lightMint,
                                      borderRadius: BorderRadius.circular(
                                        AppleTokens.radius8,
                                      ),
                                    ),
                                    child: Text(
                                      'Academic',
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w600,
                                        color: AppleTokens.primaryTeal,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    secondEvent?.title ?? 'Quiz Challenge',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: isDark
                                          ? AppleTokens.darkTextPrimary
                                          : AppleTokens.neutralDark,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    _myRank != null
                                        ? 'Rank #${_myRank!.rank} • Compete & Climb'
                                        : 'Compete & Climb Ranks',
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w400,
                                      color: AppleTokens.neutralBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppleTokens.lightMint,
                                borderRadius: BorderRadius.circular(
                                  AppleTokens.radius8,
                                ),
                              ),
                              child: const Icon(
                                Icons.emoji_events_rounded,
                                color: AppleTokens.primaryTeal,
                                size: 22,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Quick Actions Card
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isDark ? AppleTokens.darkSurface : Colors.white,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius12,
                        ),
                        border: Border.all(
                          color: isDark
                              ? AppleTokens.darkBorder
                              : AppleTokens.borderSubtle,
                          width: 1.0,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x08000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _socialCircleButton(
                            icon: Icons.groups_outlined,
                            tooltip: 'Campus Clubs',
                            onTap: () =>
                                widget.onNavigate('clubs', Container()),
                          ),
                          _socialCircleButton(
                            icon: Icons.school_outlined,
                            tooltip: 'Placement Mocks',
                            onTap: () =>
                                widget.onNavigate('interview_prep', Container()),
                          ),
                          _socialCircleButton(
                            icon: Icons.people_outline_rounded,
                            tooltip: 'Find Buddies',
                            onTap: () =>
                                widget.onNavigate('study_buddies', Container()),
                          ),
                          _socialCircleButton(
                            icon: Icons.leaderboard_outlined,
                            tooltip: 'Leaderboard',
                            onTap: () =>
                                widget.onNavigate('leaderboard', Container()),
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
        borderRadius: BorderRadius.circular(AppleTokens.radius8),
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppleTokens.lightMint,
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          child: Icon(
            icon,
            color: AppleTokens.primaryTeal,
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
                color: isDark
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
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.deepNavy,
                      ),
                    ),
                    Text(
                      _monthAbbr(event.startTime.month),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isDark
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
