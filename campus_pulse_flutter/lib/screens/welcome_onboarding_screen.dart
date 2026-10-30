import 'dart:ui';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../theme/apple_tokens.dart';

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

class _WelcomeOnboardingScreenState extends State<WelcomeOnboardingScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();

  // Section global keys for smooth anchor scrolling
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _eventsKey = GlobalKey();

  // Live campus events from backend
  List<CampusEvent> _liveEvents = [];
  bool _isLoadingEvents = true;
  bool _eventsError = false;

  // Floating animation controller for lightweight 3D depth
  late final AnimationController _floatController;
  late final Animation<double> _floatAnimation;

  // Mouse parallax offset on desktop
  Offset _pointerOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3600),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(
        parent: _floatController,
        curve: Curves.easeInOut,
      ),
    );

    _loadLiveContent();
  }

  @override
  void dispose() {
    _floatController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadLiveContent() async {
    try {
      final events = await client.event
          .listEvents(limit: 3, offset: 0)
          .timeout(const Duration(seconds: 4));
      if (mounted) {
        setState(() {
          _liveEvents = events;
          _isLoadingEvents = false;
          _eventsError = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoadingEvents = false;
          _eventsError = true;
        });
      }
    }
  }

  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppleTokens.primaryTeal,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
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
                      const SizedBox(width: 8),
                      Text(
                        'CAMPULSE',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.neutralDark,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, size: 20),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const Divider(color: AppleTokens.borderSubtle, height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.stars_rounded,
                  size: 20,
                  color: AppleTokens.primaryTeal,
                ),
                title: const Text('Features'),
                onTap: () {
                  Navigator.pop(ctx);
                  _scrollToKey(_featuresKey);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.alt_route_rounded,
                  size: 20,
                  color: AppleTokens.primaryTeal,
                ),
                title: const Text('How It Works'),
                onTap: () {
                  Navigator.pop(ctx);
                  _scrollToKey(_howItWorksKey);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.info_outline_rounded,
                  size: 20,
                  color: AppleTokens.primaryTeal,
                ),
                title: const Text('About'),
                onTap: () {
                  Navigator.pop(ctx);
                  _scrollToKey(_aboutKey);
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(
                  Icons.event_outlined,
                  size: 20,
                  color: AppleTokens.primaryTeal,
                ),
                title: const Text('Campus Events'),
                onTap: () {
                  Navigator.pop(ctx);
                  widget.onBrowseEvents();
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        widget.onNavigate?.call('auth');
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppleTokens.primaryText,
                        side: const BorderSide(color: AppleTokens.borderSubtle),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                      ),
                      child: const Text('Log In'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        widget.onGetStarted();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppleTokens.primaryButton,
                        foregroundColor: AppleTokens.primaryButtonText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                      ),
                      child: const Text('Sign Up'),
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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 960;
    final disableMotion = MediaQuery.of(context).disableAnimations;

    return Scaffold(
      backgroundColor: AppleTokens.pageBackground,
      body: Stack(
        children: [
          // Main Scrollable Page Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Top spacing to account for sticky frosted navbar
                const SizedBox(height: 70),

                // 1. HERO SECTION (Two-column desktop with 3D Depth Illustration)
                _buildHeroSection(context, isDesktop, disableMotion),

                // 2. FEATURES SECTION (Interactive Grid with hover lift & 3D tilt)
                _buildFeaturesSection(context, isDesktop),

                // 3. HOW IT WORKS (Connected 3-Step Journey)
                _buildHowItWorksSection(context, isDesktop),

                // 4. ABOUT SECTION (Narrow reading column & verified pillars)
                _buildAboutSection(context, isDesktop),

                // 5. REAL LIVE EVENTS (Real-time backend queries)
                _buildUpcomingEventsSection(context, isDesktop),

                // 6. FINAL CALL TO ACTION (Mint gradient banner)
                _buildFinalCtaSection(context, isDesktop),

                // 7. FOOTER
                _buildFooter(context, isDesktop),
              ],
            ),
          ),

          // Pinned Sticky Frosted Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildStickyNavbar(context, isDesktop),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // STICKY FROSTED NAVBAR
  // ==========================================
  Widget _buildStickyNavbar(BuildContext context, bool isDesktop) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          width: double.infinity,
          height: 68,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.88),
            border: const Border(
              bottom: BorderSide(
                color: AppleTokens.borderSubtle,
                width: 1.0,
              ),
            ),
          ),
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 1200),
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 32 : 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo / Wordmark
                  InkWell(
                    onTap: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                      );
                    },
                    borderRadius: BorderRadius.circular(AppleTokens.radius8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: AppleTokens.primaryTeal,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppleTokens.primaryTeal.withValues(
                                  alpha: 0.25,
                                ),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              'C',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'CAMPULSE',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.4,
                            color: AppleTokens.neutralDark,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Desktop Navigation Links
                  if (isDesktop)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _navHoverLink(
                          'Features',
                          () => _scrollToKey(_featuresKey),
                        ),
                        const SizedBox(width: 8),
                        _navHoverLink(
                          'How It Works',
                          () => _scrollToKey(_howItWorksKey),
                        ),
                        const SizedBox(width: 8),
                        _navHoverLink('About', () => _scrollToKey(_aboutKey)),
                        const SizedBox(width: 8),
                        _navHoverLink('Events', widget.onBrowseEvents),
                      ],
                    ),

                  // Desktop Auth CTA / Mobile Hamburger
                  if (isDesktop)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => widget.onNavigate?.call('auth'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppleTokens.primaryText,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          child: Text(
                            'Log In',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppleTokens.primaryText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: widget.onGetStarted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppleTokens.primaryButton,
                            foregroundColor: AppleTokens.primaryButtonText,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 11,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppleTokens.radius8,
                              ),
                            ),
                          ),
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppleTokens.primaryButtonText,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    IconButton(
                      icon: const Icon(
                        Icons.menu_rounded,
                        color: AppleTokens.neutralDark,
                      ),
                      tooltip: 'Menu',
                      onPressed: () => _showMobileMenu(context),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navHoverLink(String label, VoidCallback onTap) {
    return _HoverNavButton(label: label, onTap: onTap);
  }

  // ==========================================
  // 1. HERO SECTION WITH 3D DEPTH
  // ==========================================
  Widget _buildHeroSection(
    BuildContext context,
    bool isDesktop,
    bool disableMotion,
  ) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: isDesktop ? 60 : 36,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Left Column: Copy & Actions
                    Expanded(
                      flex: 11,
                      child: _buildHeroLeftContent(context, isDesktop),
                    ),
                    const SizedBox(width: 48),
                    // Right Column: Interactive 3D Depth Campus Illustration
                    Expanded(
                      flex: 10,
                      child: _build3DCampusIllustration(
                        disableMotion,
                        isDesktop,
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildHeroLeftContent(context, isDesktop),
                    const SizedBox(height: 32),
                    _build3DCampusIllustration(disableMotion, isDesktop),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildHeroLeftContent(BuildContext context, bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Subtle Brand Role Badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: AppleTokens.lightMint,
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
            border: Border.all(
              color: AppleTokens.primaryTeal.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.school_rounded,
                size: 16,
                color: AppleTokens.primaryTeal,
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Campus Community Platform',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: AppleTokens.primaryTeal,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),

        // Hero Headline
        RichText(
          textAlign: isDesktop ? TextAlign.start : TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 48 : 34,
              fontWeight: FontWeight.w800,
              color: AppleTokens.neutralDark,
              letterSpacing: -1.0,
              height: 1.15,
            ),
            children: const [
              TextSpan(text: 'Your campus,\n'),
              TextSpan(
                text: 'connected.',
                style: TextStyle(
                  color: AppleTokens.primaryTeal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // Description
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 520),
          child: Text(
            'Find campus events, share verified lecture notes, join course channels, and connect with peer study partners—all in one place.',
            textAlign: isDesktop ? TextAlign.start : TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 17 : 15,
              fontWeight: FontWeight.w400,
              color: AppleTokens.neutralBrown,
              height: 1.55,
            ),
          ),
        ),
        const SizedBox(height: 32),

        // Actions
        Wrap(
          spacing: 14,
          runSpacing: 12,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: widget.onGetStarted,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppleTokens.primaryButton,
                foregroundColor: AppleTokens.primaryButtonText,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppleTokens.radius8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Get Started',
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.primaryButtonText,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded, size: 16),
                ],
              ),
            ),
            OutlinedButton(
              onPressed: () => widget.onNavigate?.call('auth'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppleTokens.primaryText,
                backgroundColor: Colors.white,
                side: const BorderSide(
                  color: AppleTokens.borderSubtle,
                  width: 1.2,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppleTokens.radius8),
                ),
              ),
              child: Text(
                'Log In',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppleTokens.primaryText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Real trust highlights
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _trustPill(
              'Verified Student Accounts',
              Icons.verified_user_outlined,
            ),
            _trustPill('Syllabus-Aligned Quizzes', Icons.check_circle_outline),
            _trustPill('Official Class Timetables', Icons.schedule_outlined),
          ],
        ),
      ],
    );
  }

  Widget _trustPill(String label, IconData icon) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppleTokens.primaryTeal),
        const SizedBox(width: 5),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppleTokens.neutralBrown,
          ),
        ),
      ],
    );
  }

  // --- Lightweight 3D-Style Campus Illustration ---
  Widget _build3DCampusIllustration(bool disableMotion, bool isDesktop) {
    return MouseRegion(
      onHover: (event) {
        if (!disableMotion && isDesktop) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null && box.hasSize) {
            final center = box.size.center(Offset.zero);
            setState(() {
              _pointerOffset = Offset(
                ((event.localPosition.dx - center.dx) / 50).clamp(-10.0, 10.0),
                ((event.localPosition.dy - center.dy) / 50).clamp(-10.0, 10.0),
              );
            });
          }
        }
      },
      onExit: (_) {
        if (!disableMotion) {
          setState(() => _pointerOffset = Offset.zero);
        }
      },
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, _) {
          final floatOffset = disableMotion ? 0.0 : _floatAnimation.value;
          final pX = (disableMotion || !isDesktop) ? 0.0 : _pointerOffset.dx;
          final pY = (disableMotion || !isDesktop) ? 0.0 : _pointerOffset.dy;

          return SizedBox(
            height: isDesktop ? 400 : 360,
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                // Soft background radial aura
                Positioned(
                  top: 30,
                  child: Container(
                    width: isDesktop ? 300 : 260,
                    height: isDesktop ? 300 : 260,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          AppleTokens.lightMint.withValues(alpha: 0.6),
                          AppleTokens.lightCyan.withValues(alpha: 0.2),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                // Card 1: Floating Event Ticket Card (Top Left)
                Positioned(
                  top: 15 + floatOffset + (pY * 0.4),
                  left: isDesktop ? 10 + (pX * 0.4) : 0,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-0.06)
                      ..rotateX(0.04),
                    child: _buildEventTicketCard(isDesktop),
                  ),
                ),

                // Card 2: Lecture Notes & PYQs Card (Center)
                Positioned(
                  top: 130 - (floatOffset * 0.8) + (pY * 0.7),
                  right: isDesktop ? 10 - (pX * 0.6) : 0,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(0.05)
                      ..rotateX(-0.03),
                    child: _buildStudyBookCard(isDesktop),
                  ),
                ),

                // Card 3: Peer Study Buddy Card (Bottom Left)
                Positioned(
                  bottom: 25 + floatOffset - (pY * 0.5),
                  left: isDesktop ? 20 + (pX * 0.5) : 10,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(-0.04)
                      ..rotateX(0.03),
                    child: _buildStudyBuddyCard(isDesktop),
                  ),
                ),

                // Card 4: Quiz & Leaderboard Badge Card (Bottom Right)
                Positioned(
                  bottom: 10 - (floatOffset * 0.6) + (pY * 0.3),
                  right: isDesktop ? 20 - (pX * 0.4) : 10,
                  child: Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateY(0.04)
                      ..rotateX(0.02),
                    child: _buildQuizRankBadge(isDesktop),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEventTicketCard(bool isDesktop) {
    return Container(
      width: isDesktop ? 230 : 200,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppleTokens.radius14),
        border: Border.all(color: AppleTokens.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppleTokens.primaryTeal.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'WORKSHOP',
                  style: GoogleFonts.inter(
                    fontSize: 8.5,
                    fontWeight: FontWeight.w800,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  'Nov 12 · 10 AM',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    color: AppleTokens.neutralBrown,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'HackPulse 2026',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w800,
              color: AppleTokens.neutralDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Main Auditorium',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppleTokens.neutralBrown,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppleTokens.pageBackground,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppleTokens.borderSubtle),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 11,
                  color: AppleTokens.primaryTeal,
                ),
                const SizedBox(width: 4),
                Text(
                  'RSVP Confirmed',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyBookCard(bool isDesktop) {
    return Container(
      width: isDesktop ? 230 : 205,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppleTokens.radius14),
        border: Border.all(color: AppleTokens.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 42,
            decoration: BoxDecoration(
              color: AppleTokens.lightCyan,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppleTokens.primaryTeal.withValues(alpha: 0.3),
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.menu_book_rounded,
                color: AppleTokens.primaryTeal,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Data Structures',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: AppleTokens.neutralDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Sem 5 · Notes & PYQs',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: AppleTokens.neutralBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      size: 11,
                      color: AppleTokens.primaryTeal,
                    ),
                    const SizedBox(width: 3),
                    Flexible(
                      child: Text(
                        'Verified PDF',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudyBuddyCard(bool isDesktop) {
    return Container(
      width: isDesktop ? 220 : 190,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppleTokens.radius14),
        border: Border.all(color: AppleTokens.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              SizedBox(
                width: 48,
                height: 22,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      child: _avatarCircle('AS', AppleTokens.primaryTeal),
                    ),
                    Positioned(
                      left: 14,
                      child: _avatarCircle('PP', AppleTokens.tealHover),
                    ),
                    Positioned(
                      left: 28,
                      child: _avatarCircle('+3', AppleTokens.neutralBrown),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'CSE Study Hub',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppleTokens.neutralDark,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: AppleTokens.freeBackground,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: AppleTokens.freeBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  size: 11,
                  color: AppleTokens.freeText,
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    'Free for Study',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.freeText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarCircle(String text, Color bg) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 1.5),
      ),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 7.5,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildQuizRankBadge(bool isDesktop) {
    return Container(
      width: isDesktop ? 200 : 175,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppleTokens.radius14),
        border: Border.all(color: AppleTokens.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: AppleTokens.primaryTeal.withValues(alpha: 0.1),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppleTokens.lightMint,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.emoji_events_rounded,
                color: AppleTokens.primaryTeal,
                size: 15,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Rank #1 in Year 3',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: AppleTokens.neutralDark,
                  ),
                ),
                Text(
                  'Operating Systems · 98%',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 9.5,
                    color: AppleTokens.neutralBrown,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================
  // 2. FEATURES SECTION
  // ==========================================
  Widget _buildFeaturesSection(BuildContext context, bool isDesktop) {
    final features = [
      _FeatureData(
        icon: Icons.event_available_rounded,
        title: 'Events & Registration',
        description:
            'Discover upcoming workshops, guest lectures, cultural fests, and club activities. RSVP with a tap and track live attendance.',
        containerColor: AppleTokens.lightMint,
        actionLabel: 'Browse Events',
        onAction: widget.onBrowseEvents,
      ),
      _FeatureData(
        icon: Icons.menu_book_rounded,
        title: 'Library & Notes',
        description:
            'Access verified course notes, reference PDFs, and past semester exam papers contributed by students and faculty.',
        containerColor: AppleTokens.lightCyan,
        actionLabel: 'Open Library',
        onAction: () => widget.onNavigate?.call('academic_resources'),
      ),
      _FeatureData(
        icon: Icons.forum_rounded,
        title: 'Community Rooms',
        description:
            'Join dedicated branch, course, and project discussion channels to collaborate with classmates in real time.',
        containerColor: AppleTokens.lightBlue,
        actionLabel: 'Explore Rooms',
        onAction: () => widget.onNavigate?.call('chat'),
      ),
      _FeatureData(
        icon: Icons.group_rounded,
        title: 'Study Buddy',
        description:
            'Find matching study partners in your branch and year based on shared subjects, timetable free slots, and hostel location.',
        containerColor: AppleTokens.lightMint,
        actionLabel: 'Find Buddies',
        onAction: () => widget.onNavigate?.call('study_buddies'),
      ),
      _FeatureData(
        icon: Icons.quiz_rounded,
        title: 'Syllabus-Based Quizzes',
        description:
            'Reinforce core subject understanding through timed practice quizzes strictly mapped to your university syllabus.',
        containerColor: AppleTokens.lightLavender,
        actionLabel: 'Take Quizzes',
        onAction: () => widget.onNavigate?.call('quiz_selection'),
      ),
      _FeatureData(
        icon: Icons.leaderboard_rounded,
        title: 'Course & Year Leaderboards',
        description:
            'Track quiz results, earned study badges, and academic rankings within your department and graduation year.',
        containerColor: AppleTokens.lightCyan,
        actionLabel: 'View Leaderboard',
        onAction: () => widget.onNavigate?.call('leaderboard'),
      ),
    ];

    return Container(
      key: _featuresKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppleTokens.primaryTeal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Platform Capabilities',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.primaryTeal,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Everything you need to thrive on campus.',
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 30 : 24,
                  fontWeight: FontWeight.w800,
                  color: AppleTokens.neutralDark,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Purpose-built academic and social tools designed specifically for college student collaboration.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppleTokens.neutralBrown,
                ),
              ),
              const SizedBox(height: 36),

              // Responsive Feature Cards Grid
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 960
                      ? 3
                      : (constraints.maxWidth >= 600 ? 2 : 1);
                  final itemWidth =
                      (constraints.maxWidth - ((crossAxisCount - 1) * 20)) /
                      crossAxisCount;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: features.map((f) {
                      return SizedBox(
                        width: itemWidth,
                        child: _InteractiveFeatureCard(data: f),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 3. HOW IT WORKS (Connected Journey)
  // ==========================================
  Widget _buildHowItWorksSection(BuildContext context, bool isDesktop) {
    final steps = [
      _JourneyStep(
        number: '01',
        title: 'Create your account',
        description:
            'Sign up with your college email to verify your student identity and securely join your campus network.',
        icon: Icons.person_add_alt_1_rounded,
      ),
      _JourneyStep(
        number: '02',
        title: 'Add your course and year',
        description:
            'Specify your branch, semester, and section to unlock your section timetable, syllabus quizzes, and matching notes.',
        icon: Icons.school_rounded,
      ),
      _JourneyStep(
        number: '03',
        title: 'Explore activities & study resources',
        description:
            'RSVP to workshops, access verified exam papers, coordinate peer study slots, and test your knowledge.',
        icon: Icons.rocket_launch_rounded,
      ),
    ];

    return Container(
      key: _howItWorksKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppleTokens.primaryTeal,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Step-by-Step',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.primaryTeal,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'How It Works',
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 30 : 24,
                  fontWeight: FontWeight.w800,
                  color: AppleTokens.neutralDark,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Three simple steps to unlock your personalized college experience.',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppleTokens.neutralBrown,
                ),
              ),
              const SizedBox(height: 40),

              // Connected Step Cards
              LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 840;
                  final itemWidth = isWide
                      ? (constraints.maxWidth - 40) / 3
                      : constraints.maxWidth;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: steps.map((s) {
                      return SizedBox(
                        width: itemWidth,
                        child: Container(
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            color: AppleTokens.pageBackground,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius16,
                            ),
                            border: Border.all(
                              color: AppleTokens.borderSubtle,
                              width: 1.0,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: AppleTokens.primaryTeal,
                                      borderRadius: BorderRadius.circular(
                                        AppleTokens.radius12,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        s.number,
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    s.icon,
                                    color: AppleTokens.primaryTeal.withValues(
                                      alpha: 0.6,
                                    ),
                                    size: 24,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(
                                s.title,
                                style: GoogleFonts.inter(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w800,
                                  color: AppleTokens.neutralDark,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                s.description,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppleTokens.neutralBrown,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 4. ABOUT SECTION
  // ==========================================
  Widget _buildAboutSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _aboutKey,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(AppleTokens.radius8),
                  border: Border.all(
                    color: AppleTokens.primaryTeal.withValues(alpha: 0.25),
                  ),
                ),
                child: Text(
                  'Academic Mission',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Built specifically for student life.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 32 : 26,
                  fontWeight: FontWeight.w800,
                  color: AppleTokens.neutralDark,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'CAMPULSE eliminates the noise and fragmentation of commercial social apps. We centralize official section timetables, verified lecture resources, peer study slot coordination, and event registrations into one intuitive platform.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppleTokens.neutralBrown,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Every student belongs to an authenticated college community where academic resources are shared openly and peer study matching happens seamlessly.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: AppleTokens.neutralBrown,
                  height: 1.65,
                ),
              ),
              const SizedBox(height: 32),

              // Community Verified Pillars Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppleTokens.radius14),
                  border: Border.all(color: AppleTokens.borderSubtle),
                ),
                child: Wrap(
                  spacing: 24,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    _aboutPillar(
                      Icons.verified_rounded,
                      'Verified Students Only',
                    ),
                    _aboutPillar(Icons.block_rounded, 'Zero Commercial Ads'),
                    _aboutPillar(Icons.lock_outline_rounded, 'Privacy First'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _aboutPillar(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppleTokens.primaryTeal),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppleTokens.neutralDark,
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // 5. REAL UPCOMING EVENTS
  // ==========================================
  Widget _buildUpcomingEventsSection(BuildContext context, bool isDesktop) {
    return Container(
      key: _eventsKey,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 60,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 16,
                runSpacing: 12,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 24,
                            decoration: BoxDecoration(
                              color: AppleTokens.primaryTeal,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Campus Calendar',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppleTokens.primaryTeal,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upcoming Campus Events',
                        style: GoogleFonts.inter(
                          fontSize: isDesktop ? 28 : 22,
                          fontWeight: FontWeight.w800,
                          color: AppleTokens.neutralDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Real-time activities published by campus organizers.',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppleTokens.neutralBrown,
                        ),
                      ),
                    ],
                  ),
                  TextButton.icon(
                    onPressed: widget.onBrowseEvents,
                    icon: const Icon(Icons.arrow_forward_rounded, size: 16),
                    label: const Text('View All'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppleTokens.primaryTeal,
                      textStyle: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Content based on real events query
              if (_isLoadingEvents)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(
                      color: AppleTokens.primaryTeal,
                    ),
                  ),
                )
              else if (_eventsError || _liveEvents.isEmpty)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: AppleTokens.pageBackground,
                    borderRadius: BorderRadius.circular(AppleTokens.radius14),
                    border: Border.all(color: AppleTokens.borderSubtle),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.event_note_rounded,
                        size: 36,
                        color: AppleTokens.neutralBrown,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No events scheduled this week.',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.neutralDark,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Campus organizers publish activities regularly. Check back soon!',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppleTokens.neutralBrown,
                        ),
                      ),
                    ],
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final count = constraints.maxWidth >= 900
                        ? 3
                        : (constraints.maxWidth >= 600 ? 2 : 1);
                    final itemWidth =
                        (constraints.maxWidth - ((count - 1) * 20)) / count;

                    return Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: _liveEvents.map((event) {
                        return SizedBox(
                          width: itemWidth,
                          child: _buildRichEventCard(event),
                        );
                      }).toList(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRichEventCard(CampusEvent event) {
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
    final monthStr = months[(event.startTime.month - 1).clamp(0, 11)];

    return InkWell(
      onTap: widget.onBrowseEvents,
      borderRadius: BorderRadius.circular(AppleTokens.radius14),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppleTokens.radius14),
          border: Border.all(
            color: AppleTokens.borderSubtle,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category & Date Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppleTokens.lightMint,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      event.category.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        color: AppleTokens.primaryTeal,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppleTokens.pageBackground,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppleTokens.borderSubtle),
                  ),
                  child: Text(
                    '${event.startTime.day} $monthStr',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.neutralDark,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Event Title
            Text(
              event.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppleTokens.neutralDark,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 10),

            // Location Row
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  size: 15,
                  color: AppleTokens.neutralBrown,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    event.venue,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppleTokens.neutralBrown,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Functional action link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${event.rsvpCount} Students RSVPed',
                  style: GoogleFonts.inter(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: AppleTokens.primaryTeal,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // 6. FINAL CALL TO ACTION SECTION
  // ==========================================
  Widget _buildFinalCtaSection(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 64,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 48 : 24,
              vertical: isDesktop ? 52 : 36,
            ),
            decoration: BoxDecoration(
              gradient: AppleTokens.subtleMintGradient,
              borderRadius: BorderRadius.circular(AppleTokens.radius20),
              border: Border.all(
                color: AppleTokens.primaryTeal.withValues(alpha: 0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppleTokens.primaryTeal.withValues(alpha: 0.08),
                  blurRadius: 30,
                  offset: const Offset(0, 12),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Make the most of your campus.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: isDesktop ? 34 : 26,
                    fontWeight: FontWeight.w800,
                    color: AppleTokens.neutralDark,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 12),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 580),
                  child: Text(
                    'Join your classmates on CAMPULSE to discover upcoming activities, exchange study materials, and prepare for exams together.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppleTokens.neutralBrown,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Wrap(
                  spacing: 14,
                  runSpacing: 12,
                  alignment: WrapAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onGetStarted,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppleTokens.primaryButton,
                        foregroundColor: AppleTokens.primaryButtonText,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 28,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                      ),
                      child: Text(
                        'Create Student Account',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.primaryButtonText,
                        ),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: widget.onBrowseEvents,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppleTokens.primaryText,
                        backgroundColor: Colors.white,
                        side: const BorderSide(
                          color: AppleTokens.borderSubtle,
                          width: 1.2,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                      ),
                      child: Text(
                        'Browse Events',
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppleTokens.primaryText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // 7. FOOTER
  // ==========================================
  Widget _buildFooter(BuildContext context, bool isDesktop) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 32 : 20,
        vertical: 48,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppleTokens.borderSubtle,
            width: 1.0,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.start,
                spacing: 32,
                runSpacing: 24,
                children: [
                  // Col 1: Brand
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 280),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: AppleTokens.primaryTeal,
                                borderRadius: BorderRadius.circular(
                                  AppleTokens.radius8,
                                ),
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
                            const SizedBox(width: 8),
                            Text(
                              'CAMPULSE',
                              style: GoogleFonts.inter(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.4,
                                color: AppleTokens.neutralDark,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Discover. Connect. Compete.',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppleTokens.primaryTeal,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'The dedicated campus network for students, study groups, and faculty.',
                          style: GoogleFonts.inter(
                            fontSize: 12.5,
                            color: AppleTokens.neutralBrown,
                            height: 1.45,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Col 2: Platform Links
                  _footerLinkColumn('Platform', [
                    _FooterLinkItem(
                      'Features',
                      () => _scrollToKey(_featuresKey),
                    ),
                    _FooterLinkItem(
                      'How It Works',
                      () => _scrollToKey(_howItWorksKey),
                    ),
                    _FooterLinkItem('About', () => _scrollToKey(_aboutKey)),
                    _FooterLinkItem('Events', widget.onBrowseEvents),
                  ]),

                  // Col 3: Academic Tools
                  _footerLinkColumn('Academics', [
                    _FooterLinkItem(
                      'Library & Notes',
                      () => widget.onNavigate?.call('academic_resources'),
                    ),
                    _FooterLinkItem(
                      'Syllabus Quizzes',
                      () => widget.onNavigate?.call('quiz_selection'),
                    ),
                    _FooterLinkItem(
                      'Leaderboards',
                      () => widget.onNavigate?.call('leaderboard'),
                    ),
                    _FooterLinkItem(
                      'Section Timetable',
                      () => widget.onNavigate?.call('timetable'),
                    ),
                  ]),

                  // Col 4: Support & Legal
                  _footerLinkColumn('Support', [
                    _FooterLinkItem(
                      'FAQ & Help',
                      () => widget.onNavigate?.call('faq'),
                    ),
                    _FooterLinkItem(
                      'Contact Support',
                      () => widget.onNavigate?.call('contact'),
                    ),
                    _FooterLinkItem(
                      'Sign In',
                      () => widget.onNavigate?.call('auth'),
                    ),
                  ]),
                ],
              ),
              const Divider(color: AppleTokens.borderSubtle, height: 44),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 8,
                children: [
                  Text(
                    '© 2026 CAMPULSE. All rights reserved.',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppleTokens.neutralBrown,
                    ),
                  ),
                  Text(
                    'College Community Network',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppleTokens.neutralBrown,
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

  Widget _footerLinkColumn(String heading, List<_FooterLinkItem> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppleTokens.neutralDark,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 12),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: InkWell(
              onTap: link.onTap,
              borderRadius: BorderRadius.circular(4),
              child: Text(
                link.label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: AppleTokens.neutralBrown,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==========================================
// INTERACTIVE FEATURE CARD WIDGET
// ==========================================
class _InteractiveFeatureCard extends StatefulWidget {
  final _FeatureData data;

  const _InteractiveFeatureCard({required this.data});

  @override
  State<_InteractiveFeatureCard> createState() =>
      _InteractiveFeatureCardState();
}

class _InteractiveFeatureCardState extends State<_InteractiveFeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Transform.translate(
        offset: Offset(0.0, _isHovered ? -4.0 : 0.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_isHovered ? -0.015 : 0.0)
            ..rotateY(_isHovered ? 0.015 : 0.0),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppleTokens.radius14),
            border: Border.all(
              color: _isHovered
                  ? AppleTokens.primaryTeal.withValues(alpha: 0.6)
                  : AppleTokens.borderSubtle,
              width: _isHovered ? 1.4 : 1.0,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? AppleTokens.primaryTeal.withValues(alpha: 0.1)
                    : Colors.black.withValues(alpha: 0.04),
                blurRadius: _isHovered ? 20 : 8,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.data.containerColor,
                  borderRadius: BorderRadius.circular(AppleTokens.radius12),
                ),
                child: Center(
                  child: Icon(
                    widget.data.icon,
                    size: 24,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Text(
                widget.data.title,
                style: GoogleFonts.inter(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppleTokens.neutralDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.data.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppleTokens.neutralBrown,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: widget.data.onAction,
                borderRadius: BorderRadius.circular(6),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.data.actionLabel,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: _isHovered
                            ? AppleTokens.primaryTeal
                            : AppleTokens.neutralDark,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: _isHovered
                          ? AppleTokens.primaryTeal
                          : AppleTokens.neutralDark,
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

// ==========================================
// HOVER NAVBAR BUTTON
// ==========================================
class _HoverNavButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _HoverNavButton({required this.label, required this.onTap});

  @override
  State<_HoverNavButton> createState() => _HoverNavButtonState();
}

class _HoverNavButtonState extends State<_HoverNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: BorderRadius.circular(AppleTokens.radius8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: _isHovered
                ? AppleTokens.lightMint.withValues(alpha: 0.5)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
          ),
          child: Text(
            widget.label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _isHovered
                  ? AppleTokens.primaryTeal
                  : AppleTokens.neutralBrown,
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// MODELS
// ==========================================
class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  final Color containerColor;
  final String actionLabel;
  final VoidCallback onAction;

  _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
    required this.containerColor,
    required this.actionLabel,
    required this.onAction,
  });
}

class _JourneyStep {
  final String number;
  final String title;
  final String description;
  final IconData icon;

  _JourneyStep({
    required this.number,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class _FooterLinkItem {
  final String label;
  final VoidCallback onTap;

  _FooterLinkItem(this.label, this.onTap);
}
