import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';

/// Design tokens matching the Pastel Mobile Reference (media_1793301247002_85f7d33a.jpg)
class MindlyTokens {
  static const Color background = Color(0xFFFAFAF8); // Warm White: #FAFAF8
  static const Color lavender = Color(0xFFE6DFFF); // Lavender Background: #E6DFFF
  static const Color palePurple = Color(0xFFF1EDFF); // Pale Lavender: #F1EDFF
  static const Color warmCream = Color(0xFFFFC45B); // Pastel Yellow: #FFC45B
  static const Color softBlue = Color(0xFFA9CCFF); // Pastel Blue: #A9CCFF
  static const Color accentPurple = Color(0xFFB9A0FF); // Soft Lavender: #B9A0FF
  static const Color deepNavy = Color(0xFF10111C); // Dark Navy: #10111C
  static const Color bodyText = Color(0xFF777783); // Secondary Text: #777783
  static const Color cardBg = Color(0xFFFFFFFF); // White: #FFFFFF
  static const Color border = Color(0xFFE9E6EF); // Border: #E9E6EF
  static const Color yellowAccent = Color(0xFFFFC45B); // Pastel Yellow: #FFC45B
  static const Color yellowSoft = Color(0xFFFFF3D6);
  static const Color pastelPink = Color(0xFFF18CE5); // Pastel Pink: #F18CE5
  static const Color pastelBlue = Color(0xFFA9CCFF);
  static const Color pastelYellow = Color(0xFFFFC45B);
  static const Color softLavender = Color(0xFFB9A0FF);
  static const Color lavenderBg = Color(0xFFE6DFFF);
  static const Color deepForest = Color(0xFF10111C);
  static const Color burntAmber = Color(0xFFB9A0FF);
  static const Color sageGreen = Color(0xFFB9A0FF);
}

class WelcomeOnboardingScreen extends StatefulWidget {
  final VoidCallback onGetStarted;
  final VoidCallback onBrowseEvents;
  final void Function(String route)? onNavigate;

  const WelcomeOnboardingScreen({
    super.key,
    required this.onGetStarted,
    required this.onBrowseEvents,
    this.onNavigate,
  });

  @override
  State<WelcomeOnboardingScreen> createState() =>
      _WelcomeOnboardingScreenState();
}

class _WelcomeOnboardingScreenState extends State<WelcomeOnboardingScreen> {
  final ScrollController _scrollController = ScrollController();

  // Section global keys for smooth anchor scrolling
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();
  final GlobalKey _studyBuddyKey = GlobalKey();
  final GlobalKey _communityKey = GlobalKey();
  final GlobalKey _leaderboardKey = GlobalKey();

  // Live data fetched from Serverpod backend
  List<CampusEvent> _liveEvents = [];
  List<StudentProfile> _liveStudents = [];
  List<LeaderboardEntry> _liveLeaderboard = [];
  bool _isLoadingData = true;
  String _selectedEventCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadLiveContent();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadLiveContent() async {
    try {
      final results = await Future.wait([
        client.event
            .listEvents(limit: 6, offset: 0)
            .timeout(const Duration(seconds: 4)),
        client.student
            .discoverStudents(limit: 4, offset: 0)
            .timeout(const Duration(seconds: 4)),
        client.leaderboard
            .getLeaderboard(limit: 4, offset: 0)
            .timeout(const Duration(seconds: 4)),
      ]);

      if (mounted) {
        setState(() {
          _liveEvents = results[0] as List<CampusEvent>;
          _liveStudents = results[1] as List<StudentProfile>;
          _liveLeaderboard = results[2] as List<LeaderboardEntry>;
          _isLoadingData = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingData = false;
        });
      }
    }
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  TextStyle _serifHeadline({
    double fontSize = 48,
    FontWeight fontWeight = FontWeight.w600,
    Color color = MindlyTokens.deepNavy,
    double height = 1.15,
  }) {
    try {
      return GoogleFonts.newsreader(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: -0.6,
      );
    } catch (_) {
      return TextStyle(
        fontFamily: 'serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
        letterSpacing: -0.6,
      );
    }
  }

  TextStyle _sansText({
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w400,
    Color color = MindlyTokens.bodyText,
    double height = 1.5,
  }) {
    try {
      return GoogleFonts.inter(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    } catch (_) {
      return TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final isTablet = width >= 600 && width < 900;

    return Scaffold(
      backgroundColor: MindlyTokens.background,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // 1. TOP NAVBAR (Mindly layout)
            _buildNavbar(context, isDesktop),

            // 2. HERO SECTION with delicate grid, pastel glow, headline & layered cards
            _buildHeroSection(context, isDesktop, isTablet, width),

            // 3. HOW IT WORKS (Section 1)
            _buildHowItWorksSection(context, isDesktop),

            // 4. EXPLORE CAMPUS EVENTS (Section 2)
            _buildEventsSection(context, isDesktop),

            // 5. FIND YOUR STUDY BUDDY (Section 3)
            _buildStudyBuddySection(context, isDesktop),

            // 6. CAMPUS COMMUNITY & QUIZZES (Section 4)
            _buildCommunitySection(context, isDesktop),

            // 7. LIVE LEADERBOARD (Section 5)
            _buildLeaderboardSection(context, isDesktop),

            // 8. FINAL CTA (Section 6)
            _buildFinalCtaSection(context),

            // 9. FOOTER
            _buildFooter(context, isDesktop),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 1. NAVBAR
  // ==========================================
  Widget _buildNavbar(BuildContext context, bool isDesktop) {
    final width = MediaQuery.of(context).size.width;
    final showFullNav = width >= 980;
    final isMobile = width < 600;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 40 : 12,
        vertical: 14,
      ),
      constraints: const BoxConstraints(maxWidth: 1280),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Brand Logo
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: InkWell(
                onTap: () {
                  _scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeOut,
                  );
                },
                borderRadius: BorderRadius.circular(8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: MindlyTokens.deepForest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.bolt_rounded,
                          color: MindlyTokens.sageGreen,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Campus Pulse',
                        overflow: TextOverflow.ellipsis,
                        style: _serifHeadline(
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.w700,
                          color: MindlyTokens.deepForest,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Desktop Center Nav Links
          if (showFullNav)
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _navLink('How It Works', () => _scrollToKey(_howItWorksKey)),
                    const SizedBox(width: 16),
                    _navLink(
                      'Campus Community',
                      () => _scrollToKey(_communityKey),
                    ),
                    const SizedBox(width: 16),
                    _navLink('Events', () => _scrollToKey(_eventsKey)),
                    const SizedBox(width: 16),
                    _navLink('About', () => widget.onNavigate?.call('faq')),
                  ],
                ),
              ),
            ),

          // Right Auth Actions
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: widget.onGetStarted,
                style: TextButton.styleFrom(
                  foregroundColor: MindlyTokens.deepForest,
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 8 : 14,
                    vertical: isMobile ? 6 : 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Log In',
                  style: _sansText(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.deepForest,
                  ),
                ),
              ),
              SizedBox(width: isMobile ? 6 : 8),
              ElevatedButton(
                onPressed: widget.onGetStarted,
                style: ElevatedButton.styleFrom(
                  backgroundColor: MindlyTokens.burntAmber,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 20,
                    vertical: isMobile ? 7 : 10,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Get Started',
                  style: _sansText(
                    fontSize: isMobile ? 12 : 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Text(
          label,
          style: _sansText(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: MindlyTokens.deepNavy,
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 2. HERO SECTION
  // ==========================================
  Widget _buildHeroSection(
    BuildContext context,
    bool isDesktop,
    bool isTablet,
    double screenWidth,
  ) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          // A. Ambient Pastel Mesh Glows (Lavender bottom-left, Warm Cream bottom-right)
          Positioned(
            left: -120,
            bottom: 40,
            child: Container(
              width: 520,
              height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    MindlyTokens.lavender.withValues(alpha: 0.55),
                    MindlyTokens.palePurple.withValues(alpha: 0.25),
                    MindlyTokens.background.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.55, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            right: -100,
            bottom: 60,
            child: Container(
              width: 560,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    MindlyTokens.warmCream.withValues(alpha: 0.65),
                    MindlyTokens.softBlue.withValues(alpha: 0.20),
                    MindlyTokens.background.withValues(alpha: 0.0),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // B. Delicate Faint Grid across the hero
          Positioned.fill(
            child: CustomPaint(
              painter: _HeroGridPainter(),
            ),
          ),

          // C. Floating Decorative Circles
          // Top-Right Lavender Heart/Pulse Pill
          Positioned(
            right: isDesktop ? screenWidth * 0.18 : 24,
            top: 60,
            child: _buildFloatingLavenderBadge(),
          ),

          // Middle-Left Warm Yellow Spark Circle
          Positioned(
            left: isDesktop ? screenWidth * 0.18 : 16,
            top: 200,
            child: _buildFloatingYellowBadge(),
          ),

          // D. Foreground Content: Headline, Subtitle, CTAs, and Layered Cards
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36),
              // Headline
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Text(
                  'Your campus life deserves\na place to connect',
                  textAlign: TextAlign.center,
                  style: _serifHeadline(
                    fontSize: isDesktop ? 54 : (isTablet ? 42 : 32),
                    fontWeight: FontWeight.w600,
                    height: 1.15,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Subtitle
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Discover campus events, find your study buddies, share knowledge, and stay connected with your college community — all in one calm, judgment-free space.',
                    textAlign: TextAlign.center,
                    style: _sansText(
                      fontSize: isDesktop ? 16 : 14,
                      color: MindlyTokens.bodyText,
                      height: 1.6,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Pill CTA Buttons
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 14,
                runSpacing: 12,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      widget.onBrowseEvents();
                      widget.onNavigate?.call('events');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MindlyTokens.burntAmber,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      'Explore Campus',
                      style: _sansText(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      widget.onGetStarted();
                      widget.onNavigate?.call('study_buddies');
                    },
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: MindlyTokens.deepForest,
                      side: const BorderSide(
                        color: MindlyTokens.border,
                        width: 1.2,
                      ),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 26,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      'Join Your Community',
                      style: _sansText(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MindlyTokens.deepForest,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 48),

              // F. Layered Cards Stack
              _buildHeroCardStack(context, isDesktop, screenWidth),
            ],
          ),
        ],
      ),
    );
  }

  // Floating Decorative Badges
  Widget _buildFloatingLavenderBadge() {
    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: MindlyTokens.palePurple, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: MindlyTokens.palePurple,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.favorite_rounded,
              size: 20,
              color: MindlyTokens.accentPurple,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingYellowBadge() {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: MindlyTokens.warmCream, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: MindlyTokens.yellowAccent,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.auto_awesome_rounded,
              size: 16,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlobMascot() {
    return Container(
      width: 72,
      height: 64,
      decoration: BoxDecoration(
        color: MindlyTokens.lavender,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(36),
          topRight: Radius.circular(36),
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: MindlyTokens.accentPurple.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Eye 1
          Container(
            width: 8,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: MindlyTokens.deepNavy,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          // Eye 2
          Container(
            width: 8,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: MindlyTokens.deepNavy,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }

  // Layered Cards Composition
  Widget _buildHeroCardStack(
    BuildContext context,
    bool isDesktop,
    double screenWidth,
  ) {
    if (!isDesktop) {
      // Mobile / Tablet layout: Clean horizontal scroll or single center card
      return SizedBox(
        height: 380,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          children: [
            _buildCenterCard(width: 300, isElevated: true),
            const SizedBox(width: 16),
            _buildLeftStudyCard(width: 290, rotation: 0),
            const SizedBox(width: 16),
            _buildRightDiscussionCard(width: 290, rotation: 0),
          ],
        ),
      );
    }

    // Desktop: Exact Mindly layered rotated composition
    return SizedBox(
      height: 420,
      child: Center(
        child: SizedBox(
          width: 880,
          height: 420,
          child: Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              // Cute Blob Mascot peeking behind left card
              Positioned(
                left: 70,
                bottom: 230,
                child: _buildBlobMascot(),
              ),

              // 1. Left Card (-6.5 degrees)
              Positioned(
                left: 40,
                bottom: -20,
                child: Transform.rotate(
                  angle: -0.11,
                  alignment: Alignment.bottomCenter,
                  child: _buildLeftStudyCard(width: 300, rotation: -0.11),
                ),
              ),

              // 2. Right Card (+6.5 degrees)
              Positioned(
                right: 40,
                bottom: -20,
                child: Transform.rotate(
                  angle: 0.11,
                  alignment: Alignment.bottomCenter,
                  child: _buildRightDiscussionCard(width: 300, rotation: 0.11),
                ),
              ),

              // 3. Center Featured Event Card (Upright, elevated, on top)
              Positioned(
                bottom: 0,
                child: _buildCenterCard(width: 330, isElevated: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Center Hero Card: Featured Campus Event / Question
  Widget _buildCenterCard({required double width, bool isElevated = true}) {
    final featuredEvent = _liveEvents.isNotEmpty ? _liveEvents.first : null;

    return Container(
      width: width,
      height: 380,
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
      decoration: BoxDecoration(
        color: MindlyTokens.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        border: Border.all(color: MindlyTokens.border, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isElevated ? 0.08 : 0.03),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top circular icon badge
          Container(
            width: 36,
            height: 36,
            decoration: const BoxDecoration(
              color: MindlyTokens.palePurple,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.event_available_rounded,
                size: 18,
                color: MindlyTokens.accentPurple,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Centered Serif Headline
          Text(
            featuredEvent?.title ??
                'HackPulse 2026: Campus 36-Hour Hackathon',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: _serifHeadline(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),

          // Short description
          Text(
            featuredEvent?.description ??
                'Build innovative solutions for campus sustainability and productivity with top mentors.',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _sansText(
              fontSize: 13,
              color: MindlyTokens.bodyText,
              height: 1.45,
            ),
          ),

          const Spacer(),

          // Bottom Metadata row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: MindlyTokens.background,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 6,
              children: [
                const Icon(
                  Icons.people_alt_outlined,
                  size: 13,
                  color: MindlyTokens.bodyText,
                ),
                Text(
                  '${featuredEvent?.rsvpCount ?? 42} attending',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.bodyText,
                  ),
                ),
                const Text(
                  '•',
                  style: TextStyle(color: MindlyTokens.bodyText, fontSize: 11),
                ),
                Text(
                  featuredEvent?.category ?? 'Hackathon',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.accentPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Left Hero Card: Study-Buddy Request
  Widget _buildLeftStudyCard({required double width, required double rotation}) {
    return Container(
      width: width,
      height: 360,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: MindlyTokens.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: MindlyTokens.lavender,
            child: const Text(
              'A',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: MindlyTokens.deepNavy,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Serif question / request
          Text(
            'Looking for a DSA & OS study buddy for LeetCode contests?',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: _serifHeadline(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'Preparing for summer engineering internships. Daily practice on dynamic programming and graphs.',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _sansText(fontSize: 12, color: MindlyTokens.bodyText),
          ),

          const Spacer(),

          // Bottom metadata
          Text(
            'Available evenings • 3rd Year CSE',
            style: _sansText(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: MindlyTokens.bodyText,
            ),
          ),
        ],
      ),
    );
  }

  // Right Hero Card: Campus Discussion
  Widget _buildRightDiscussionCard({
    required double width,
    required double rotation,
  }) {
    return Container(
      width: width,
      height: 360,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: MindlyTokens.cardBg,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Avatar
          CircleAvatar(
            radius: 18,
            backgroundColor: MindlyTokens.softBlue,
            child: const Text(
              'P',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: MindlyTokens.deepNavy,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Serif question
          Text(
            'How do you balance OS coursework with semester placement prep?',
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: _serifHeadline(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            'Tips on managing lab submissions, mock interviews, and revision schedules effectively.',
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _sansText(fontSize: 12, color: MindlyTokens.bodyText),
          ),

          const Spacer(),

          // Bottom metadata
          Text(
            '18 answers • 520 views • Placement Talk',
            style: _sansText(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: MindlyTokens.bodyText,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 3. SECTION 1: HOW IT WORKS
  // ==========================================
  Widget _buildHowItWorksSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _howItWorksKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              // Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: MindlyTokens.palePurple,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'HOW IT WORKS',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: MindlyTokens.accentPurple,
                  ),
                ),
              ),
              const SizedBox(height: 18),

              Text(
                'Everything you need to thrive on campus',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: isDesktop ? 38 : 28),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'Three simple pillars designed to keep you informed, connected, and academically motivated throughout your degree.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15),
                ),
              ),
              const SizedBox(height: 48),

              // 3 Pastel Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 840;
                  final cardWidth = isWide
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _buildPillarCard(
                        width: cardWidth,
                        step: '01',
                        title: 'Discover Campus Events',
                        description:
                            'Never miss hackathons, club meetups, sports tournaments, or guest lectures. Instant one-tap RSVP with live updates.',
                        badgeColor: MindlyTokens.lavender,
                        icon: Icons.calendar_today_rounded,
                      ),
                      _buildPillarCard(
                        width: cardWidth,
                        step: '02',
                        title: 'Match Study Buddies',
                        description:
                            'Find peers with matching subjects (DSA, OS, DBMS) and campus proximity using deterministic compatibility algorithms.',
                        badgeColor: MindlyTokens.warmCream,
                        icon: Icons.people_outline_rounded,
                      ),
                      _buildPillarCard(
                        width: cardWidth,
                        step: '03',
                        title: 'Compete & Climb Ranks',
                        description:
                            'Test your subject mastery with verified academic quizzes. Real-time WebSocket leaderboards reflect your hard work instantly.',
                        badgeColor: MindlyTokens.softBlue,
                        icon: Icons.emoji_events_outlined,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPillarCard({
    required double width,
    required String step,
    required String title,
    required String description,
    required Color badgeColor,
    required IconData icon,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: MindlyTokens.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: MindlyTokens.deepNavy, size: 22),
              ),
              Text(
                step,
                style: _serifHeadline(
                  fontSize: 22,
                  color: MindlyTokens.bodyText.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Text(
            title,
            style: _serifHeadline(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: _sansText(fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 4. SECTION 2: EXPLORE CAMPUS EVENTS
  // ==========================================
  Widget _buildEventsSection(BuildContext context, bool isDesktop) {
    final filteredEvents = _selectedEventCategory == 'All'
        ? _liveEvents
        : _liveEvents
            .where((e) => e.category == _selectedEventCategory)
            .toList();

    return Container(
      key: _eventsKey,
      width: double.infinity,
      color: MindlyTokens.background,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Text(
                'Explore Campus Events',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: isDesktop ? 38 : 28),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'Join hackathons, tech talks, cultural galas, and sports tournaments organized by student councils and clubs.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15),
                ),
              ),
              const SizedBox(height: 32),

              // Category Filter Pills
              Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: [
                  'All',
                  'Tech',
                  'Sports',
                  'Cultural',
                  'Workshop',
                  'Hackathon',
                ].map((cat) {
                  final isSelected = _selectedEventCategory == cat;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedEventCategory = cat;
                      });
                    },
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? MindlyTokens.deepNavy
                            : Colors.white,
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected
                              ? MindlyTokens.deepNavy
                              : MindlyTokens.border,
                        ),
                      ),
                      child: Text(
                        cat,
                        style: _sansText(
                          fontSize: 13,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                          color: isSelected
                              ? Colors.white
                              : MindlyTokens.deepNavy,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),

              // Events Grid
              if (_isLoadingData)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (filteredEvents.isEmpty)
                Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: MindlyTokens.border),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.event_busy_rounded,
                        size: 40,
                        color: MindlyTokens.bodyText,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No events found in "$_selectedEventCategory"',
                        style: _sansText(fontSize: 15),
                      ),
                    ],
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth >= 760;
                    final cardWidth = isWide
                        ? (constraints.maxWidth - 24) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: 24,
                      runSpacing: 24,
                      children: filteredEvents.map((event) {
                        return _buildEventCard(cardWidth, event);
                      }).toList(),
                    );
                  },
                ),

              const SizedBox(height: 36),
              OutlinedButton(
                onPressed: widget.onBrowseEvents,
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: MindlyTokens.deepNavy,
                  side: const BorderSide(color: MindlyTokens.border, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'View All Events in Feed',
                  style: _sansText(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.deepNavy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventCard(double width, CampusEvent event) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: MindlyTokens.palePurple,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  event.category,
                  style: _sansText(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.accentPurple,
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.people_alt_outlined,
                    size: 14,
                    color: MindlyTokens.bodyText,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${event.rsvpCount} RSVPs',
                    style: _sansText(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: MindlyTokens.bodyText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            event.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _serifHeadline(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            event.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: _sansText(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 15,
                color: MindlyTokens.bodyText,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  event.venue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: _sansText(fontSize: 12, color: MindlyTokens.bodyText),
                ),
              ),
              const SizedBox(width: 12),
              InkWell(
                onTap: widget.onBrowseEvents,
                child: Text(
                  'RSVP →',
                  style: _sansText(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: MindlyTokens.accentPurple,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 5. SECTION 3: FIND YOUR STUDY BUDDY
  // ==========================================
  Widget _buildStudyBuddySection(BuildContext context, bool isDesktop) {
    return Container(
      key: _studyBuddyKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: MindlyTokens.warmCream,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'PEER MATCHING',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFB28100),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Find Your Study Buddy',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: isDesktop ? 38 : 28),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'Connect with classmates sharing your subjects, branch, and academic goals. No guesswork — pure deterministic alignment.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15),
                ),
              ),
              const SizedBox(height: 48),

              // Students Cards Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 760;
                  final cardWidth = isWide
                      ? (constraints.maxWidth - 24) / 2
                      : constraints.maxWidth;

                  final students = _liveStudents.isNotEmpty
                      ? _liveStudents
                      : [
                          StudentProfile(
                            authUserId: UuidValue.fromString(
                              '550e8400-e29b-41d4-a716-446655440021',
                            ),
                            fullName: 'Priya Patel',
                            email: 'priya.patel@campus.edu',
                            branch: 'CSE',
                            academicYear: 3,
                            hostelOrArea: 'Kaveri Hostel Block B',
                            bio:
                                'Passionate about Algorithms, System Design and Open Source.',
                            subjectInterests: [
                              'DSA',
                              'Operating Systems',
                              'System Design',
                            ],
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                          StudentProfile(
                            authUserId: UuidValue.fromString(
                              '550e8400-e29b-41d4-a716-446655440022',
                            ),
                            fullName: 'Rohan Mehta',
                            email: 'rohan.mehta@campus.edu',
                            branch: 'IT',
                            academicYear: 3,
                            hostelOrArea: 'Ganga Hostel Block A',
                            bio:
                                'Full-stack developer building real-time collaboration tools.',
                            subjectInterests: [
                              'DBMS',
                              'Computer Networks',
                              'Web Technologies',
                            ],
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                          ),
                        ];

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: students.map((s) {
                      return _buildStudentCard(cardWidth, s);
                    }).toList(),
                  );
                },
              ),

              const SizedBox(height: 36),
              ElevatedButton(
                onPressed: () {
                  if (widget.onNavigate != null) {
                    widget.onNavigate!('study_buddies');
                  } else {
                    widget.onGetStarted();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MindlyTokens.deepNavy,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'Browse All Study Partners',
                  style: _sansText(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStudentCard(double width, StudentProfile student) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: MindlyTokens.background,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: MindlyTokens.lavender,
                child: Text(
                  student.fullName.isNotEmpty
                      ? student.fullName.substring(0, 1).toUpperCase()
                      : 'S',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: MindlyTokens.deepNavy,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.fullName,
                      style: _serifHeadline(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${student.branch} • Year ${student.academicYear} • ${student.hostelOrArea}',
                      style: _sansText(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          if (student.bio != null && student.bio!.isNotEmpty)
            Text(
              student.bio!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: _sansText(fontSize: 13, height: 1.45),
            ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: student.subjectInterests.map((sub) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: MindlyTokens.border),
                ),
                child: Text(
                  sub,
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: MindlyTokens.deepNavy,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 6. SECTION 4: CAMPUS COMMUNITY & QUIZZES
  // ==========================================
  Widget _buildCommunitySection(BuildContext context, bool isDesktop) {
    return Container(
      key: _communityKey,
      width: double.infinity,
      color: MindlyTokens.background,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: MindlyTokens.softBlue,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'CAMPUS COMMUNITY & CHALLENGES',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0056B3),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Master Core Engineering Subjects',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: isDesktop ? 38 : 28),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'Timed academic quizzes authored with verified answer explanations. Test your skills in DBMS, Data Structures, and Operating Systems.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15),
                ),
              ),
              const SizedBox(height: 48),

              // 3 Quiz Challenge Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 840;
                  final cardWidth = isWide
                      ? (constraints.maxWidth - 48) / 3
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 24,
                    runSpacing: 24,
                    children: [
                      _buildQuizCard(
                        width: cardWidth,
                        subject: 'DBMS',
                        difficulty: 'Medium',
                        questionsCount: 5,
                        description:
                            'Transactions, ACID guarantees, normalization forms (1NF-BCNF), and SQL execution plans.',
                        color: MindlyTokens.palePurple,
                      ),
                      _buildQuizCard(
                        width: cardWidth,
                        subject: 'Data Structures and Algorithms',
                        difficulty: 'Hard',
                        questionsCount: 5,
                        description:
                            'AVL balance factors, Dijkstra shortest path, amortized array bounds, and dynamic programming.',
                        color: MindlyTokens.warmCream,
                      ),
                      _buildQuizCard(
                        width: cardWidth,
                        subject: 'Operating Systems',
                        difficulty: 'Medium',
                        questionsCount: 5,
                        description:
                            'Process scheduling, semaphore concurrency, deadlocks, and virtual memory paging models.',
                        color: MindlyTokens.softBlue,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuizCard({
    required double width,
    required String subject,
    required String difficulty,
    required int questionsCount,
    required String description,
    required Color color,
  }) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(26),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MindlyTokens.border, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  difficulty,
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: MindlyTokens.deepNavy,
                  ),
                ),
              ),
              Text(
                '$questionsCount Questions',
                style: _sansText(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: MindlyTokens.bodyText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            subject,
            style: _serifHeadline(fontSize: 19, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: _sansText(fontSize: 13, height: 1.45),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (widget.onNavigate != null) {
                widget.onNavigate!('quizzes');
              } else {
                widget.onGetStarted();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MindlyTokens.deepNavy,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            ),
            child: Text(
              'Start Challenge →',
              style: _sansText(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 7. SECTION 5: LIVE LEADERBOARD
  // ==========================================
  Widget _buildLeaderboardSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _leaderboardKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 84,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: MindlyTokens.palePurple,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'REAL-TIME RECOGNITION',
                  style: _sansText(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: MindlyTokens.accentPurple,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                'Live Campus Leaderboard',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: isDesktop ? 38 : 28),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 580),
                child: Text(
                  'Celebrate top academic achievements, problem-solving streaks, and quiz excellence updated live via WebSocket streams.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15),
                ),
              ),
              const SizedBox(height: 40),

              // Leaderboard preview card
              Container(
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: MindlyTokens.background,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: MindlyTokens.border, width: 1.0),
                ),
                child: Column(
                  children: _liveLeaderboard.isNotEmpty
                      ? _liveLeaderboard.take(3).toList().asMap().entries.map((entry) {
                          final idx = entry.key;
                          final row = entry.value;
                          final medalColor = idx == 0
                              ? const Color(0xFFFFD700)
                              : (idx == 1
                                  ? const Color(0xFFC0C0C0)
                                  : const Color(0xFFCD7F32));
                          return Column(
                            children: [
                              if (idx > 0)
                                const Divider(
                                  color: MindlyTokens.border,
                                  height: 24,
                                ),
                              _buildLeaderboardRow(
                                rank: row.rank,
                                name: row.studentName,
                                branch: '${row.branch} • ${row.quizzesTaken} challenges',
                                score: '${row.score} pts',
                                medalColor: medalColor,
                              ),
                            ],
                          );
                        }).toList()
                      : [
                          _buildLeaderboardRow(
                            rank: 1,
                            name: 'Aarav Sharma',
                            branch: 'CSE • Year 3',
                            score: '2,480 pts',
                            medalColor: const Color(0xFFFFD700),
                          ),
                          const Divider(color: MindlyTokens.border, height: 24),
                          _buildLeaderboardRow(
                            rank: 2,
                            name: 'Priya Patel',
                            branch: 'CSE • Year 3',
                            score: '2,310 pts',
                            medalColor: const Color(0xFFC0C0C0),
                          ),
                          const Divider(color: MindlyTokens.border, height: 24),
                          _buildLeaderboardRow(
                            rank: 3,
                            name: 'Rohan Mehta',
                            branch: 'IT • Year 3',
                            score: '2,150 pts',
                            medalColor: const Color(0xFFCD7F32),
                          ),
                        ],
                ),
              ),

              const SizedBox(height: 32),
              OutlinedButton(
                onPressed: () {
                  if (widget.onNavigate != null) {
                    widget.onNavigate!('leaderboard');
                  } else {
                    widget.onGetStarted();
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: MindlyTokens.deepNavy,
                  side: const BorderSide(color: MindlyTokens.border, width: 1.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 26,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  'View Full Leaderboard',
                  style: _sansText(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: MindlyTokens.deepNavy,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeaderboardRow({
    required int rank,
    required String name,
    required String branch,
    required String score,
    required Color medalColor,
  }) {
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: medalColor.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: medalColor == const Color(0xFFFFD700)
                    ? const Color(0xFFB28100)
                    : MindlyTokens.deepNavy,
                fontSize: 14,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: _serifHeadline(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(branch, style: _sansText(fontSize: 12)),
            ],
          ),
        ),
        Text(
          score,
          style: _sansText(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: MindlyTokens.deepNavy,
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 8. SECTION 6: FINAL CTA
  // ==========================================
  Widget _buildFinalCtaSection(BuildContext context) {
    return Container(
      width: double.infinity,
      color: MindlyTokens.background,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 96),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 960),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 56),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: MindlyTokens.border, width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 32,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                'Make more of your campus life.',
                textAlign: TextAlign.center,
                style: _serifHeadline(fontSize: 38),
              ),
              const SizedBox(height: 14),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Text(
                  'Join your classmates on Campus Pulse. Sign in with your campus email and unlock events, study partners, and academic challenges today.',
                  textAlign: TextAlign.center,
                  style: _sansText(fontSize: 15, height: 1.55),
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 14,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: widget.onGetStarted,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MindlyTokens.deepNavy,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      'Get Started Free',
                      style: _sansText(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  OutlinedButton(
                    onPressed: widget.onBrowseEvents,
                    style: OutlinedButton.styleFrom(
                      backgroundColor: MindlyTokens.background,
                      foregroundColor: MindlyTokens.deepNavy,
                      side: const BorderSide(
                        color: MindlyTokens.border,
                        width: 1.2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                    ),
                    child: Text(
                      'Explore Events Feed',
                      style: _sansText(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: MindlyTokens.deepNavy,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 9. FOOTER
  // ==========================================
  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 48 : 24,
        vertical: 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1120),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: MindlyTokens.deepNavy,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.bolt_rounded,
                            color: MindlyTokens.palePurple,
                            size: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Campus Pulse',
                        style: _serifHeadline(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      _footerLink(
                        'Events',
                        () => widget.onNavigate?.call('events'),
                      ),
                      _footerLink(
                        'Study Matching',
                        () => widget.onNavigate?.call('study_buddies'),
                      ),
                      _footerLink(
                        'Quizzes',
                        () => widget.onNavigate?.call('quizzes'),
                      ),
                      _footerLink(
                        'Help & FAQ',
                        () => widget.onNavigate?.call('faq'),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(color: MindlyTokens.border, height: 48),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '© 2026 Campus Pulse. Built with Flutter & Serverpod. All rights reserved.',
                    style: _sansText(fontSize: 12, color: MindlyTokens.bodyText),
                  ),
                  Text(
                    'Apple Human Interface Guidelines & WCAG AAA Compliant',
                    style: _sansText(fontSize: 12, color: MindlyTokens.bodyText),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _footerLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Text(
          label,
          style: _sansText(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: MindlyTokens.bodyText,
          ),
        ),
      ),
    );
  }
}

/// Custom painter for the delicate, faint grid background across the hero
class _HeroGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF9CAF88).withValues(alpha: 0.18)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const double gridSize = 72.0;

    // Draw vertical grid lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw horizontal grid lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
