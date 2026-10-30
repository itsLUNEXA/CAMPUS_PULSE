import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';

class EventsFeedScreen extends StatefulWidget {
  final AuthState authState;
  final RealtimeService realtimeService;
  final Function(CampusEvent event) onSelectEvent;
  final VoidCallback onCreateEvent;

  const EventsFeedScreen({
    super.key,
    required this.authState,
    required this.realtimeService,
    required this.onSelectEvent,
    required this.onCreateEvent,
  });

  @override
  State<EventsFeedScreen> createState() => _EventsFeedScreenState();
}

class _EventsFeedScreenState extends State<EventsFeedScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Tech',
    'Sports',
    'Cultural',
    'Workshop',
    'Hackathon',
  ];
  final TextEditingController _searchCtrl = TextEditingController();

  List<CampusEvent> _events = [];
  final Set<int> _myRsvpdEventIds = {};
  bool _isLoading = true;
  bool _isRetrying = false;
  int _currentRequestId = 0;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadEvents();
    widget.realtimeService.addListener(_onRealtimeUpdate);
  }

  @override
  void dispose() {
    widget.realtimeService.removeListener(_onRealtimeUpdate);
    _searchCtrl.dispose();
    super.dispose();
  }

  void _onRealtimeUpdate() {
    if (widget.realtimeService.recentRsvps.isNotEmpty) {
      final latest = widget.realtimeService.recentRsvps.first;
      setState(() {
        for (int i = 0; i < _events.length; i++) {
          if (_events[i].id == latest.eventId) {
            _events[i] = _events[i].copyWith(rsvpCount: latest.rsvpCount);
          }
        }
      });
    }
  }

  TextStyle _serifHeadline({
    double fontSize = 28,
    FontWeight fontWeight = FontWeight.w700,
    Color? color,
  }) {
    try {
      return GoogleFonts.newsreader(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        letterSpacing: -0.5,
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
    FontWeight fontWeight = FontWeight.w400,
    Color? color,
    double? height,
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
        fontFamily: '-apple-system, Roboto, sans-serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      );
    }
  }

  Future<void> _loadEvents() async {
    if (_isRetrying && _isLoading) return;

    final thisRequestId = ++_currentRequestId;
    setState(() {
      _isLoading = true;
      _isRetrying = true;
      _errorMessage = null;
    });

    try {
      final events = await client.event
          .listEvents(
            category: _selectedCategory,
            limit: 50,
            offset: 0,
          )
          .timeout(const Duration(seconds: 10));

      final rsvpdIds = <int>{};
      if (widget.authState.isAuthenticated) {
        try {
          final ids = await client.event.getMyRsvpdEventIds().timeout(
            const Duration(seconds: 5),
          );
          rsvpdIds.addAll(ids);
        } catch (_) {}
      }

      if (thisRequestId != _currentRequestId) return;

      if (mounted) {
        setState(() {
          _events = events;
          _myRsvpdEventIds.clear();
          _myRsvpdEventIds.addAll(rsvpdIds);
          _isLoading = false;
          _isRetrying = false;
        });
      }
    } catch (e) {
      if (thisRequestId != _currentRequestId) return;
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isRetrying = false;
          _errorMessage = _classifyError(e);
        });
      }
    }
  }

  String _classifyError(Object error) {
    final str = error.toString().toLowerCase();
    if (str.contains('timeout')) {
      return 'Request timed out. Please check your network and retry.';
    }
    if (str.contains('socketexception') ||
        str.contains('connection refused') ||
        str.contains('failed host lookup') ||
        str.contains('clientexception')) {
      return 'Unable to reach Campus Pulse server. Please ensure the backend server is running on http://localhost:8080.';
    }
    if (str.contains('500') || str.contains('internalservererror')) {
      return 'Server error occurred while loading events. Please check the backend server logs.';
    }
    return 'Could not load campus events. Tap Retry to try again.';
  }

  void _toggleRsvp(CampusEvent event) async {
    if (!widget.authState.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to RSVP for events.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final isCurrentlyRsvpd = _myRsvpdEventIds.contains(event.id);

    setState(() {
      if (isCurrentlyRsvpd) {
        _myRsvpdEventIds.remove(event.id);
        _updateEventCount(event.id!, -1);
      } else {
        _myRsvpdEventIds.add(event.id!);
        _updateEventCount(event.id!, 1);
      }
    });

    try {
      if (isCurrentlyRsvpd) {
        await client.event.cancelRsvp(event.id!);
      } else {
        await client.event.rsvpEvent(event.id!);
      }
    } catch (_) {
      setState(() {
        if (isCurrentlyRsvpd) {
          _myRsvpdEventIds.add(event.id!);
          _updateEventCount(event.id!, 1);
        } else {
          _myRsvpdEventIds.remove(event.id);
          _updateEventCount(event.id!, -1);
        }
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to update RSVP. Please try again.'),
            backgroundColor: AppleTokens.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  void _updateEventCount(int eventId, int delta) {
    for (int i = 0; i < _events.length; i++) {
      if (_events[i].id == eventId) {
        final newCount = (_events[i].rsvpCount + delta).clamp(0, 10000);
        _events[i] = _events[i].copyWith(rsvpCount: newCount);
      }
    }
  }

  String _getCategoryFallbackImage(String category) {
    switch (category.toLowerCase()) {
      case 'tech':
        return 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&w=800&q=80';
      case 'hackathon':
        return 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80';
      case 'sports':
        return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?auto=format&fit=crop&w=800&q=80';
      case 'cultural':
        return 'https://images.unsplash.com/photo-1514525253161-7a46d19cd819?auto=format&fit=crop&w=800&q=80';
      case 'workshop':
        return 'https://images.unsplash.com/photo-1531482615713-2afd69097998?auto=format&fit=crop&w=800&q=80';
      default:
        return 'https://images.unsplash.com/photo-1523240795612-9a054b0db644?auto=format&fit=crop&w=800&q=80';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final filteredEvents = _events.where((e) {
      final query = _searchCtrl.text.trim().toLowerCase();
      if (query.isEmpty) return true;
      return e.title.toLowerCase().contains(query) ||
          e.description.toLowerCase().contains(query) ||
          e.venue.toLowerCase().contains(query);
    }).toList();

    return RefreshIndicator(
      onRefresh: _loadEvents,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space24,
          vertical: AppleTokens.space32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Hero Header
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Campus Events Feed',
                            style: _serifHeadline(
                              fontSize: 32,
                              color:
                                  isDark
                                      ? AppleTokens.darkTextPrimary
                                      : AppleTokens.deepNavy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Discover upcoming hackathons, tech talks, cultural galas, and tournaments across campus.',
                            style: _sansText(
                              fontSize: 15,
                              color:
                                  isDark
                                      ? AppleTokens.darkTextSecondary
                                      : AppleTokens.bodyText,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (widget.authState.isAuthenticated) ...[
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add_rounded, size: 18),
                        label: const Text('Create Event'),
                        onPressed: widget.onCreateEvent,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isDark
                                  ? AppleTokens.palePurple
                                  : AppleTokens.deepNavy,
                          foregroundColor:
                              isDark ? AppleTokens.deepNavy : Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: AppleTokens.space24),

                // Search & Filter Controls
                Container(
                  padding: const EdgeInsets.all(AppleTokens.space16),
                  decoration: BoxDecoration(
                    color:
                        isDark ? AppleTokens.darkSurface : AppleTokens.cardBg,
                    borderRadius: BorderRadius.circular(AppleTokens.radius16),
                    border: Border.all(
                      color:
                          isDark ? AppleTokens.darkBorder : AppleTokens.border,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Bar
                      TextField(
                        controller: _searchCtrl,
                        onChanged: (_) => setState(() {}),
                        style: _sansText(
                          fontSize: 14,
                          color:
                              isDark
                                  ? AppleTokens.darkTextPrimary
                                  : AppleTokens.deepNavy,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Search events by title, keyword, or venue...',
                          prefixIcon: const Icon(
                            Icons.search_rounded,
                            size: 20,
                          ),
                          suffixIcon:
                              _searchCtrl.text.isNotEmpty
                                  ? IconButton(
                                    icon: const Icon(
                                      Icons.clear_rounded,
                                      size: 18,
                                    ),
                                    onPressed: () {
                                      _searchCtrl.clear();
                                      setState(() {});
                                    },
                                  )
                                  : null,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          filled: true,
                          fillColor:
                              isDark
                                  ? AppleTokens.darkSurfaceElevated
                                  : AppleTokens.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(999),
                            borderSide: BorderSide(
                              color:
                                  isDark
                                      ? AppleTokens.darkBorder
                                      : AppleTokens.border,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(999),
                            borderSide: BorderSide(
                              color:
                                  isDark
                                      ? AppleTokens.darkBorder
                                      : AppleTokens.border,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(999),
                            borderSide: const BorderSide(
                              color: AppleTokens.accentPurple,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppleTokens.space12),

                      // Category Filter Pills
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              _categories.map((category) {
                                final isSelected =
                                    _selectedCategory == category;
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FilterChip(
                                    selected: isSelected,
                                    label: Text(category),
                                    labelStyle: _sansText(
                                      fontSize: 13,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.w600
                                              : FontWeight.w500,
                                      color:
                                          isSelected
                                              ? AppleTokens.deepForest
                                              : (isDark
                                                  ? AppleTokens.darkTextSecondary
                                                  : AppleTokens.mutedGrey),
                                    ),
                                    backgroundColor:
                                        isDark
                                            ? AppleTokens.darkSurfaceElevated
                                            : AppleTokens.warmWhite,
                                    selectedColor: AppleTokens.sageGreen,
                                    checkmarkColor: AppleTokens.deepForest,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(999),
                                      side: BorderSide(
                                        color:
                                            isSelected
                                                ? AppleTokens.sageGreen
                                                : (isDark
                                                    ? AppleTokens.darkBorder
                                                    : AppleTokens.lightConcrete),
                                      ),
                                    ),
                                    onSelected: (selected) {
                                      setState(() {
                                        _selectedCategory = category;
                                      });
                                      _loadEvents();
                                    },
                                  ),
                                );
                              }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space24),

                // Main Content View
                if (_isLoading && _events.isEmpty)
                  _skeletonGrid(isDark)
                else if (_errorMessage != null && _events.isEmpty)
                  _errorState(context)
                else if (filteredEvents.isEmpty)
                  _emptyState(context)
                else
                  _responsiveGrid(filteredEvents, isDark),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Responsive Image-First Grid
  Widget _responsiveGrid(List<CampusEvent> events, bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final int crossAxisCount;
        if (width >= 980) {
          crossAxisCount = 3;
        } else if (width >= 640) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        // Calculate card width
        const spacing = 20.0;
        final totalSpacing = spacing * (crossAxisCount - 1);
        final cardWidth = (width - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children:
              events.map((event) {
                return SizedBox(
                  width: cardWidth,
                  child: _buildImageFirstEventCard(event, isDark),
                );
              }).toList(),
        );
      },
    );
  }

  Widget _buildImageFirstEventCard(CampusEvent event, bool isDark) {
    final isRsvpd = _myRsvpdEventIds.contains(event.id);
    final imageUrl =
        (event.bannerUrl != null && event.bannerUrl!.isNotEmpty)
            ? event.bannerUrl!
            : _getCategoryFallbackImage(event.category);

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.darkSurface : AppleTokens.cardBg,
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
        border: Border.all(
          color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(
              0xFF10111C,
            ).withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => widget.onSelectEvent(event),
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 16:9 Cover Image with Badges
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppleTokens.palePurple,
                              AppleTokens.softBlue,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.event_available_rounded,
                            size: 44,
                            color: AppleTokens.accentPurple,
                          ),
                        ),
                      );
                    },
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        color:
                            isDark
                                ? AppleTokens.darkSurfaceElevated
                                : AppleTokens.palePurple.withValues(alpha: 0.3),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    },
                  ),

                  // Category Pill Overlay (Top-Left)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.94),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Text(
                        event.category.toUpperCase(),
                        style: _sansText(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.deepNavy,
                        ),
                      ),
                    ),
                  ),

                  // Bookmark / RSVP Floating Action (Top-Right)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _toggleRsvp(event),
                        borderRadius: BorderRadius.circular(999),
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.94),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.12),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Icon(
                            isRsvpd
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            size: 18,
                            color:
                                isRsvpd
                                    ? AppleTokens.accentPurple
                                    : AppleTokens.deepNavy,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Card Content Area
            Padding(
              padding: const EdgeInsets.all(AppleTokens.space16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Event Title (limited to 2 lines)
                  Text(
                    event.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _serifHeadline(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color:
                          isDark
                              ? AppleTokens.darkTextPrimary
                              : AppleTokens.deepNavy,
                    ),
                  ),
                  const SizedBox(height: 6),

                  // Description snippet
                  Text(
                    event.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: _sansText(
                      fontSize: 13,
                      color:
                          isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.bodyText,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Location and Date metadata
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 14,
                        color:
                            isDark
                                ? AppleTokens.darkAccentPurple
                                : AppleTokens.accentPurple,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          _formatDate(event.startTime),
                          style: _sansText(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.bodyText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Icon(
                        Icons.location_on_rounded,
                        size: 14,
                        color:
                            isDark
                                ? AppleTokens.darkAccentPurple
                                : AppleTokens.accentPurple,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          event.venue,
                          style: _sansText(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color:
                                isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.bodyText,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Footer Row: RSVP Count & RSVP Action Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isDark
                                  ? AppleTokens.darkSurfaceElevated
                                  : AppleTokens.palePurple,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.people_outline_rounded,
                              size: 13,
                              color:
                                  isDark
                                      ? AppleTokens.darkAccentPurple
                                      : AppleTokens.deepNavy,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${event.rsvpCount} Attending',
                              style: _sansText(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color:
                                    isDark
                                        ? AppleTokens.darkTextPrimary
                                        : AppleTokens.deepNavy,
                              ),
                            ),
                          ],
                        ),
                      ),

                      ElevatedButton(
                        onPressed: () => _toggleRsvp(event),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isRsvpd
                                  ? AppleTokens.softSage
                                  : AppleTokens.burntAmber,
                          foregroundColor:
                              isRsvpd
                                  ? AppleTokens.deepForest
                                  : Colors.white,
                          side:
                              isRsvpd
                                  ? const BorderSide(
                                    color: AppleTokens.sageGreen,
                                    width: 1.2,
                                  )
                                  : BorderSide.none,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          isRsvpd ? 'Going ✓' : 'RSVP',
                          style: _sansText(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color:
                                isRsvpd
                                    ? AppleTokens.deepForest
                                    : Colors.white,
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
      ),
    );
  }

  Widget _errorState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppleTokens.space32),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.darkSurface : AppleTokens.cardBg,
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
        border: Border.all(
          color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 40,
              color: AppleTokens.error,
            ),
            const SizedBox(height: AppleTokens.space12),
            Text(
              _errorMessage ?? 'Failed to load events.',
              textAlign: TextAlign.center,
              style: _sansText(fontSize: 14),
            ),
            const SizedBox(height: AppleTokens.space16),
            ElevatedButton.icon(
              label: Text(_isRetrying ? 'Retrying...' : 'Retry'),
              icon:
                  _isRetrying
                      ? const SizedBox(
                        width: 14,
                        height: 14,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                      : const Icon(Icons.refresh_rounded, size: 16),
              onPressed: _isRetrying ? null : _loadEvents,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isDark ? AppleTokens.palePurple : AppleTokens.deepNavy,
                foregroundColor: isDark ? AppleTokens.deepNavy : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(AppleTokens.space40),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.darkSurface : AppleTokens.cardBg,
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
        border: Border.all(
          color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? AppleTokens.darkSurfaceElevated
                        : AppleTokens.palePurple,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.event_busy_rounded,
                size: 40,
                color:
                    isDark
                        ? AppleTokens.darkAccentPurple
                        : AppleTokens.accentPurple,
              ),
            ),
            const SizedBox(height: AppleTokens.space20),
            Text(
              'No Events Found',
              style: _serifHeadline(
                fontSize: 22,
                color:
                    isDark
                        ? AppleTokens.darkTextPrimary
                        : AppleTokens.deepNavy,
              ),
            ),
            const SizedBox(height: AppleTokens.space8),
            Text(
              'Try selecting another category or clear your search query.',
              style: _sansText(
                fontSize: 14,
                color:
                    isDark
                        ? AppleTokens.darkTextSecondary
                        : AppleTokens.bodyText,
              ),
            ),
            const SizedBox(height: AppleTokens.space16),
            OutlinedButton(
              onPressed: () {
                setState(() {
                  _selectedCategory = 'All';
                  _searchCtrl.clear();
                });
                _loadEvents();
              },
              child: const Text('Reset Filters'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skeletonGrid(bool isDark) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final int crossAxisCount =
            width >= 980
                ? 3
                : width >= 640
                ? 2
                : 1;
        const spacing = 20.0;
        final cardWidth =
            (width - (spacing * (crossAxisCount - 1))) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: List.generate(
            6,
            (index) => Container(
              width: cardWidth,
              decoration: BoxDecoration(
                color: isDark ? AppleTokens.darkSurface : AppleTokens.cardBg,
                borderRadius: BorderRadius.circular(AppleTokens.radius16),
                border: Border.all(
                  color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Container(
                      color:
                          isDark
                              ? AppleTokens.darkSurfaceElevated
                              : AppleTokens.palePurple.withValues(alpha: 0.3),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppleTokens.space16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 18,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.black12,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 140,
                          height: 14,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white10 : Colors.black12,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    final hour =
        local.hour > 12
            ? local.hour - 12
            : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[local.month - 1]} ${local.day}, ${local.year} • $hour:$minute $ampm';
  }
}
