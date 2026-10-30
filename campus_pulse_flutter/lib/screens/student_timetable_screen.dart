import 'dart:math' as math;
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';

/// Helper model for placing classes in columns when they overlap in time.
class _ScheduledClassLayout {
  final SectionTimetable item;
  final double top;
  final double height;
  int columnIndex = 0;
  int totalColumns = 1;

  _ScheduledClassLayout({
    required this.item,
    required this.top,
    required this.height,
  });
}

/// Three states for student personal study slots:
/// - unset: Default neutral state (clean surface, not marked as free or occupied)
/// - free: Mint background, check icon, marked for peer study matching
/// - occupied: Light pastel red (#FDE2E2), dark red text (#9B1C1C), busy with personal activities
enum SlotAvailability {
  unset,
  free,
  occupied,
}

class StudentTimetableScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const StudentTimetableScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<StudentTimetableScreen> createState() => _StudentTimetableScreenState();
}

class _StudentTimetableScreenState extends State<StudentTimetableScreen> {
  String _branch = 'CSE';
  int _semester = 5;
  String _section = 'A';
  List<SectionTimetable> _classSchedule = [];
  List<StudentFreeSlot> _freeSlots = [];
  bool _isLoading = true;

  // Week and view navigation
  DateTime _selectedDate = DateTime.now();
  bool _isWeekView = true;
  bool _initializedView = false;

  // Track slots currently being saved to prevent duplicate rapid taps
  final Set<String> _savingSlotKeys = {};

  // Linked scroll controllers to keep day headers and left time column sticky
  late final ScrollController _horizontalHeaderController;
  late final ScrollController _horizontalGridController;
  late final ScrollController _verticalTimeController;
  late final ScrollController _verticalGridController;
  bool _isSyncingScroll = false;

  static const List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  static const List<String> _shortDaysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  static const List<String> _monthNames = [
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

  static const double _hourHeight = 64.0;
  static const double _timeColumnWidth =
      68.0; // 68px width prevents label clipping
  static const double _headerHeight = 56.0;

  @override
  void initState() {
    super.initState();
    _horizontalHeaderController = ScrollController();
    _horizontalGridController = ScrollController();
    _verticalTimeController = ScrollController();
    _verticalGridController = ScrollController();

    // Link horizontal controllers
    _horizontalGridController.addListener(() {
      if (_isSyncingScroll) return;
      if (_horizontalHeaderController.hasClients &&
          _horizontalHeaderController.offset !=
              _horizontalGridController.offset) {
        _isSyncingScroll = true;
        _horizontalHeaderController.jumpTo(_horizontalGridController.offset);
        _isSyncingScroll = false;
      }
    });

    _horizontalHeaderController.addListener(() {
      if (_isSyncingScroll) return;
      if (_horizontalGridController.hasClients &&
          _horizontalGridController.offset !=
              _horizontalHeaderController.offset) {
        _isSyncingScroll = true;
        _horizontalGridController.jumpTo(_horizontalHeaderController.offset);
        _isSyncingScroll = false;
      }
    });

    // Link vertical controllers
    _verticalGridController.addListener(() {
      if (_isSyncingScroll) return;
      if (_verticalTimeController.hasClients &&
          _verticalTimeController.offset != _verticalGridController.offset) {
        _isSyncingScroll = true;
        _verticalTimeController.jumpTo(_verticalGridController.offset);
        _isSyncingScroll = false;
      }
    });

    _verticalTimeController.addListener(() {
      if (_isSyncingScroll) return;
      if (_verticalGridController.hasClients &&
          _verticalGridController.offset != _verticalTimeController.offset) {
        _isSyncingScroll = true;
        _verticalGridController.jumpTo(_verticalTimeController.offset);
        _isSyncingScroll = false;
      }
    });

    final profile = widget.authState.currentProfile;
    if (profile != null) {
      _branch = profile.branch;
      _semester = profile.academicYear * 2 - 1;
    }
    _loadSchedule();
  }

  @override
  void dispose() {
    _horizontalHeaderController.dispose();
    _horizontalGridController.dispose();
    _verticalTimeController.dispose();
    _verticalGridController.dispose();
    super.dispose();
  }

  Future<void> _loadSchedule() async {
    setState(() => _isLoading = true);
    try {
      final schedule = await client.timetable.getSectionTimetable(
        branch: _branch,
        semester: _semester,
        section: _section,
      );
      final free = await client.timetable.getMyFreeSlots();

      if (mounted) {
        setState(() {
          _classSchedule = schedule;
          _freeSlots = free;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // --- Date Math Helpers ---

  DateTime _getMonday(DateTime date) {
    final clean = DateTime(date.year, date.month, date.day);
    return clean.subtract(Duration(days: date.weekday - 1));
  }

  List<DateTime> _getCurrentWeekDays() {
    final monday = _getMonday(_selectedDate);
    return List.generate(7, (i) => monday.add(Duration(days: i)));
  }

  String _formatWeekRange(List<DateTime> weekDays) {
    final first = weekDays.first;
    final last = weekDays.last;
    final firstMonth = _monthNames[first.month - 1];
    final lastMonth = _monthNames[last.month - 1];

    if (first.month == last.month) {
      return '$firstMonth ${first.day} – ${last.day}, ${first.year}';
    } else if (first.year == last.year) {
      return '$firstMonth ${first.day} – $lastMonth ${last.day}, ${first.year}';
    } else {
      return '$firstMonth ${first.day}, ${first.year} – $lastMonth ${last.day}, ${last.year}';
    }
  }

  String _formatDayRange(DateTime date) {
    final dayName = _daysOfWeek[date.weekday - 1];
    final month = _monthNames[date.month - 1];
    return '$dayName, $month ${date.day}, ${date.year}';
  }

  /// Keep time labels correct: 12 PM is noon, 12 AM is midnight.
  String _formatHourLabel(int hour) {
    if (hour == 0 || hour == 24) return '12 AM';
    if (hour < 12) return '$hour AM';
    if (hour == 12) return '12 PM';
    return '${hour - 12} PM';
  }

  String _formatTimeString(String timeStr) {
    final parts = timeStr.trim().split(':');
    if (parts.isEmpty) return timeStr;
    final h = int.tryParse(parts[0]);
    if (h == null) return timeStr;
    final m = parts.length > 1 ? parts[1].padLeft(2, '0') : '00';
    final period = (h >= 12 && h < 24) ? 'PM' : 'AM';
    final displayH = h == 0 ? 12 : (h > 12 ? h - 12 : h);
    return '$displayH:$m $period';
  }

  int _getMinHour() {
    int minH = 8;
    for (final c in _classSchedule) {
      final parts = c.startTime.split(':');
      if (parts.isNotEmpty) {
        final h = int.tryParse(parts[0]);
        if (h != null && h < minH && h >= 6) {
          minH = h;
        }
      }
    }
    return minH;
  }

  int _getMaxHour() {
    int maxH = 18;
    for (final c in _classSchedule) {
      final parts = c.endTime.split(':');
      if (parts.isNotEmpty) {
        final h = int.tryParse(parts[0]);
        if (h != null && h > maxH && h <= 22) {
          maxH = h;
        }
      }
    }
    return maxH;
  }

  // --- Slot Availability Lookup & Cycling ---

  String _slotLabelForHour(int hour) {
    final start = hour.toString().padLeft(2, '0');
    final end = (hour + 1).toString().padLeft(2, '0');
    return '$start:00 - $end:00';
  }

  /// Returns current slot availability without ever fabricating "free" when no record exists.
  SlotAvailability _getSlotAvailability(String day, String slotLabel) {
    for (final s in _freeSlots) {
      if (s.dayOfWeek.trim().toLowerCase() == day.trim().toLowerCase() &&
          s.slotLabel.trim() == slotLabel.trim()) {
        return s.isFree ? SlotAvailability.free : SlotAvailability.occupied;
      }
    }
    return SlotAvailability.unset;
  }

  /// Cycles slot availability: Unset -> Free for Study -> Occupied -> Unset
  Future<void> _cycleSlotAvailability(String day, String slotLabel) async {
    final current = _getSlotAvailability(day, slotLabel);
    final target = switch (current) {
      SlotAvailability.unset => SlotAvailability.free,
      SlotAvailability.free => SlotAvailability.occupied,
      SlotAvailability.occupied => SlotAvailability.unset,
    };
    await _applySlotAvailability(day, slotLabel, target);
  }

  /// Applies targeted slot availability with optimistic update and rollback on error
  Future<void> _applySlotAvailability(
    String day,
    String slotLabel,
    SlotAvailability target,
  ) async {
    final key = '$day-$slotLabel';
    if (_savingSlotKeys.contains(key)) return;

    final previousSlots = List<StudentFreeSlot>.from(_freeSlots);

    // Optimistic UI update
    setState(() {
      _savingSlotKeys.add(key);
      _freeSlots.removeWhere(
        (s) =>
            s.dayOfWeek.trim().toLowerCase() == day.trim().toLowerCase() &&
            s.slotLabel.trim() == slotLabel.trim(),
      );
      if (target == SlotAvailability.free) {
        final parts = slotLabel.split(' - ');
        _freeSlots.add(
          StudentFreeSlot(
            authUserId:
                widget.authState.currentProfile?.authUserId ??
                UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
            dayOfWeek: day,
            slotLabel: slotLabel,
            startTime: parts.first,
            endTime: parts.last,
            isFree: true,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
      } else if (target == SlotAvailability.occupied) {
        final parts = slotLabel.split(' - ');
        _freeSlots.add(
          StudentFreeSlot(
            authUserId:
                widget.authState.currentProfile?.authUserId ??
                UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
            dayOfWeek: day,
            slotLabel: slotLabel,
            startTime: parts.first,
            endTime: parts.last,
            isFree: false,
            updatedAt: DateTime.now().toUtc(),
          ),
        );
      }
    });

    try {
      if (target == SlotAvailability.unset) {
        await client.timetable.clearFreeSlot(
          dayOfWeek: day,
          slotLabel: slotLabel,
        );
      } else {
        final parts = slotLabel.split(' - ');
        final updated = await client.timetable.updateFreeSlot(
          dayOfWeek: day,
          slotLabel: slotLabel,
          startTime: parts.first,
          endTime: parts.last,
          isFree: target == SlotAvailability.free,
        );
        if (mounted) {
          setState(() {
            _freeSlots.removeWhere(
              (s) =>
                  s.dayOfWeek.trim().toLowerCase() ==
                      day.trim().toLowerCase() &&
                  s.slotLabel.trim() == slotLabel.trim(),
            );
            _freeSlots.add(updated);
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _freeSlots = previousSlots;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to update slot: $e'),
            backgroundColor: AppleTokens.occupiedText,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _savingSlotKeys.remove(key);
        });
      }
    }
  }

  void _showSlotActionSheet(String day, String slotLabel) {
    final current = _getSlotAvailability(day, slotLabel);
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.neutralDark : AppleTokens.warmWhite,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '$day · $slotLabel',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: isDark
                            ? AppleTokens.white
                            : AppleTokens.neutralDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(ctx),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Set your availability for study matching:',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppleTokens.neutralBrown,
                  ),
                ),
                const SizedBox(height: 16),
                _actionSheetOption(
                  title: 'Free for Study',
                  subtitle:
                      'Open for peer study buddy matching during this hour',
                  icon: Icons.check_circle_outline,
                  bgColor: AppleTokens.freeBackground,
                  borderColor: AppleTokens.freeBorder,
                  textColor: AppleTokens.freeText,
                  isSelected: current == SlotAvailability.free,
                  onTap: () {
                    Navigator.pop(ctx);
                    _applySlotAvailability(
                      day,
                      slotLabel,
                      SlotAvailability.free,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _actionSheetOption(
                  title: 'Occupied',
                  subtitle: 'Personal work, labs, or busy hours',
                  icon: Icons.block,
                  bgColor: AppleTokens.occupiedBackground,
                  borderColor: AppleTokens.occupiedBorder,
                  textColor: AppleTokens.occupiedText,
                  isSelected: current == SlotAvailability.occupied,
                  onTap: () {
                    Navigator.pop(ctx);
                    _applySlotAvailability(
                      day,
                      slotLabel,
                      SlotAvailability.occupied,
                    );
                  },
                ),
                const SizedBox(height: 10),
                _actionSheetOption(
                  title: 'Unset / Clear Slot',
                  subtitle: 'Reset slot to default neutral state',
                  icon: Icons.refresh_rounded,
                  bgColor: isDark
                      ? AppleTokens.darkSurface
                      : AppleTokens.borderSubtle.withValues(alpha: 0.2),
                  borderColor: AppleTokens.borderSubtle,
                  textColor: isDark
                      ? AppleTokens.white
                      : AppleTokens.neutralDark,
                  isSelected: current == SlotAvailability.unset,
                  onTap: () {
                    Navigator.pop(ctx);
                    _applySlotAvailability(
                      day,
                      slotLabel,
                      SlotAvailability.unset,
                    );
                  },
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionSheetOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? textColor : borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: textColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: textColor.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) Icon(Icons.check, size: 18, color: textColor),
          ],
        ),
      ),
    );
  }

  bool _doesClassOverlapHour(String day, int hour) {
    final slotStart = hour * 60;
    final slotEnd = (hour + 1) * 60;

    for (final c in _classSchedule) {
      if (c.dayOfWeek.trim().toLowerCase() != day.toLowerCase()) continue;
      final startParts = c.startTime.split(':');
      final endParts = c.endTime.split(':');
      final startM =
          (int.tryParse(startParts[0]) ?? 0) * 60 +
          (startParts.length > 1 ? (int.tryParse(startParts[1]) ?? 0) : 0);
      final endM =
          (int.tryParse(endParts[0]) ?? 0) * 60 +
          (endParts.length > 1 ? (int.tryParse(endParts[1]) ?? 0) : 0);

      if (startM < slotEnd && endM > slotStart) {
        return true;
      }
    }
    return false;
  }

  // --- Overlap Resolution Layout Algorithm ---

  List<_ScheduledClassLayout> _computeDayLayout(
    List<SectionTimetable> classes,
    int minHour,
    double hourHeight,
  ) {
    if (classes.isEmpty) return [];

    final layouts = <_ScheduledClassLayout>[];
    for (final c in classes) {
      final startParts = c.startTime.split(':');
      final endParts = c.endTime.split(':');
      final startH = int.tryParse(startParts[0]) ?? minHour;
      final startM = startParts.length > 1
          ? (int.tryParse(startParts[1]) ?? 0)
          : 0;
      final endH = int.tryParse(endParts[0]) ?? (startH + 1);
      final endM = endParts.length > 1 ? (int.tryParse(endParts[1]) ?? 0) : 0;

      final startMinutes = (startH - minHour) * 60.0 + startM;
      final endMinutes = (endH - minHour) * 60.0 + endM;
      final durationMinutes = (endMinutes - startMinutes).clamp(20.0, 480.0);

      final top = (startMinutes / 60.0) * hourHeight;
      final height = (durationMinutes / 60.0) * hourHeight;

      layouts.add(
        _ScheduledClassLayout(
          item: c,
          top: top,
          height: height,
        ),
      );
    }

    // Sort by top, then by height descending
    layouts.sort((a, b) {
      final cmp = a.top.compareTo(b.top);
      if (cmp != 0) return cmp;
      return b.height.compareTo(a.height);
    });

    // Cluster overlapping items
    final clusters = <List<_ScheduledClassLayout>>[];
    List<_ScheduledClassLayout> currentCluster = [];
    double clusterMaxBottom = -1;

    for (final l in layouts) {
      final bottom = l.top + l.height;
      if (currentCluster.isEmpty) {
        currentCluster.add(l);
        clusterMaxBottom = bottom;
      } else if (l.top < clusterMaxBottom - 1) {
        currentCluster.add(l);
        if (bottom > clusterMaxBottom) clusterMaxBottom = bottom;
      } else {
        clusters.add(currentCluster);
        currentCluster = [l];
        clusterMaxBottom = bottom;
      }
    }
    if (currentCluster.isNotEmpty) clusters.add(currentCluster);

    // Assign side-by-side columns within each cluster
    for (final cluster in clusters) {
      final colEnds = <double>[];
      for (final item in cluster) {
        int assignedCol = -1;
        for (int i = 0; i < colEnds.length; i++) {
          if (item.top >= colEnds[i] - 1) {
            assignedCol = i;
            colEnds[i] = item.top + item.height;
            break;
          }
        }
        if (assignedCol == -1) {
          assignedCol = colEnds.length;
          colEnds.add(item.top + item.height);
        }
        item.columnIndex = assignedCol;
      }
      final totalCols = colEnds.length;
      for (final item in cluster) {
        item.totalColumns = totalCols;
      }
    }

    return layouts;
  }

  // --- Dialogs ---

  void _showClassDetails(SectionTimetable c) {
    showDialog(
      context: context,
      builder: (ctx) {
        final isDark = Theme.of(ctx).brightness == Brightness.dark;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: isDark
              ? AppleTokens.neutralDark
              : AppleTokens.warmWhite,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 440),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                        color: AppleTokens.classBackground,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppleTokens.classBorder),
                      ),
                      child: Text(
                        'Official Class',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  c.subject,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppleTokens.white : AppleTokens.neutralDark,
                  ),
                ),
                const SizedBox(height: 16),
                _detailRow(
                  Icons.schedule_outlined,
                  'Time',
                  '${_formatTimeString(c.startTime)} – ${_formatTimeString(c.endTime)}',
                ),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.meeting_room_outlined,
                  'Room',
                  c.room.isNotEmpty ? c.room : 'Not specified',
                ),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.person_outline,
                  'Faculty',
                  (c.faculty != null && c.faculty!.isNotEmpty)
                      ? c.faculty!
                      : 'Department Faculty',
                ),
                const SizedBox(height: 10),
                _detailRow(Icons.calendar_today_outlined, 'Day', c.dayOfWeek),
                const SizedBox(height: 10),
                _detailRow(
                  Icons.school_outlined,
                  'Section',
                  '${c.branch} Sem ${c.semester}-${c.section}',
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppleTokens.borderSubtle.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppleTokens.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.lock_outline,
                        size: 16,
                        color: AppleTokens.neutralBrown,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Official academic classes are managed by faculty and administrators. They are read-only for students.',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppleTokens.neutralBrown,
                            height: 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppleButton(
                    label: 'Done',
                    variant: AppleButtonVariant.primary,
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppleTokens.primaryTeal),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppleTokens.neutralBrown,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppleTokens.neutralDark,
            ),
          ),
        ),
      ],
    );
  }

  // --- Build ---

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    if (!_initializedView) {
      _isWeekView = !isMobile;
      _initializedView = true;
    }

    final weekDays = _getCurrentWeekDays();
    final minHour = _getMinHour();
    final maxHour = _getMaxHour();
    final totalHours = maxHour - minHour;
    final gridHeight = totalHours * _hourHeight;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.neutralDark
          : AppleTokens.surfaceMuted,
      body: SafeArea(
        child: Column(
          children: [
            // Top Toolbar & Controls
            _buildHeader(isDark, isMobile, weekDays),

            // Compact Horizontal Legend
            _buildLegend(isDark, isMobile),

            // Notice if no official timetable is available
            if (!_isLoading && _classSchedule.isEmpty)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppleTokens.purple.withValues(alpha: 0.5),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 18,
                      color: AppleTokens.primaryTeal,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'No official classes found for $_branch Sem $_semester-$_section. You can still set your personal free and occupied study hours below.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppleTokens.neutralDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // If Day view, show a day selector strip
            if (!_isWeekView) _buildDaySelectorStrip(isDark, weekDays),

            // Main Timetable Content
            Expanded(
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: AppleTokens.primaryTeal,
                      ),
                    )
                  : _isWeekView
                  ? _buildWeeklyCalendar(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      weekDays: weekDays,
                      minHour: minHour,
                      maxHour: maxHour,
                      totalHours: totalHours,
                      gridHeight: gridHeight,
                    )
                  : _buildDayCalendar(
                      isDark: isDark,
                      screenWidth: screenWidth,
                      activeDate: _selectedDate,
                      minHour: minHour,
                      maxHour: maxHour,
                      totalHours: totalHours,
                      gridHeight: gridHeight,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Compact Horizontal Legend ---

  Widget _buildLegend(bool isDark, bool isMobile) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 16,
        vertical: 4,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.neutralBlack : AppleTokens.warmWhite,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppleTokens.borderSubtle),
      ),
      child: Wrap(
        spacing: 12,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 10,
            runSpacing: 6,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              _legendItem(
                label: 'Class',
                bgColor: AppleTokens.classBackground,
                borderColor: AppleTokens.classBorder,
                textColor: AppleTokens.classText,
                icon: Icons.school_outlined,
              ),
              _legendItem(
                label: 'Free for Study',
                bgColor: AppleTokens.freeBackground,
                borderColor: AppleTokens.freeBorder,
                textColor: AppleTokens.freeText,
                icon: Icons.check_circle_outline,
              ),
              _legendItem(
                label: 'Occupied',
                bgColor: AppleTokens.occupiedBackground,
                borderColor: AppleTokens.occupiedBorder,
                textColor: AppleTokens.occupiedText,
                icon: Icons.block,
              ),
              _legendItem(
                label: 'Unset',
                bgColor: isDark ? AppleTokens.darkSurface : Colors.white,
                borderColor: AppleTokens.unsetSlotBorder,
                textColor: AppleTokens.neutralBrown,
                icon: Icons.crop_square_rounded,
              ),
            ],
          ),
          if (!isMobile)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.touch_app_outlined,
                  size: 13,
                  color: AppleTokens.neutralBrown,
                ),
                const SizedBox(width: 4),
                Text(
                  'Tap slot: Unset → Free → Occupied',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppleTokens.neutralBrown,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _legendItem({
    required String label,
    required Color bgColor,
    required Color borderColor,
    required Color textColor,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  // --- Header & Toolbar ---

  Widget _buildHeader(bool isDark, bool isMobile, List<DateTime> weekDays) {
    final titleColor = isDark ? AppleTokens.white : AppleTokens.neutralDark;
    final rangeText = _isWeekView
        ? _formatWeekRange(weekDays)
        : _formatDayRange(_selectedDate);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 12 : 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.neutralBlack : AppleTokens.warmWhite,
        border: Border(bottom: BorderSide(color: AppleTokens.borderSubtle)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Title, Academic Selectors & Study Buddy action
          Row(
            children: [
              Text(
                'Timetable',
                style: GoogleFonts.inter(
                  fontSize: isMobile ? 20 : 24,
                  fontWeight: FontWeight.w800,
                  color: titleColor,
                ),
              ),
              const SizedBox(width: 16),
              if (!isMobile) ...[
                _dropdown(
                  'Branch',
                  _branch,
                  ['CSE', 'ECE', 'Mechanical', 'Civil', 'IT'],
                  (v) {
                    setState(() => _branch = v!);
                    _loadSchedule();
                  },
                ),
                const SizedBox(width: 10),
                _dropdown('Sem', _semester, [1, 2, 3, 4, 5, 6, 7, 8], (v) {
                  setState(() => _semester = v!);
                  _loadSchedule();
                }),
                const SizedBox(width: 10),
                _dropdown('Sec', _section, ['A', 'B', 'C', 'D'], (v) {
                  setState(() => _section = v!);
                  _loadSchedule();
                }),
              ],
              const Spacer(),
              AppleButton(
                label: isMobile ? 'Buddies' : 'Find Matched Buddies',
                variant: AppleButtonVariant.secondary,
                icon: Icons.people_outline,
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                onPressed: () =>
                    widget.onNavigate('study_buddies', Container()),
              ),
            ],
          ),

          if (isMobile) ...[
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _dropdown(
                    'Branch',
                    _branch,
                    ['CSE', 'ECE', 'Mechanical', 'Civil', 'IT'],
                    (v) {
                      setState(() => _branch = v!);
                      _loadSchedule();
                    },
                  ),
                  const SizedBox(width: 8),
                  _dropdown('Sem', _semester, [1, 2, 3, 4, 5, 6, 7, 8], (v) {
                    setState(() => _semester = v!);
                    _loadSchedule();
                  }),
                  const SizedBox(width: 8),
                  _dropdown('Sec', _section, ['A', 'B', 'C', 'D'], (v) {
                    setState(() => _section = v!);
                    _loadSchedule();
                  }),
                ],
              ),
            ),
          ],

          const SizedBox(height: 10),

          // Row 2: Date navigation controls, Today button, Range label, Day/Week switch
          Wrap(
            spacing: 12,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            children: [
              // Navigation controls: Today, <, >, Range label
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Today button
                  InkWell(
                    onTap: () {
                      setState(() => _selectedDate = DateTime.now());
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppleTokens.lightMint,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppleTokens.primaryTeal.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'Today',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Previous arrow
                  IconButton(
                    icon: const Icon(Icons.chevron_left, size: 22),
                    color: AppleTokens.neutralDark,
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    tooltip: _isWeekView ? 'Previous Week' : 'Previous Day',
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.subtract(
                          Duration(days: _isWeekView ? 7 : 1),
                        );
                      });
                    },
                  ),
                  const SizedBox(width: 4),

                  // Next arrow
                  IconButton(
                    icon: const Icon(Icons.chevron_right, size: 22),
                    color: AppleTokens.neutralDark,
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                    tooltip: _isWeekView ? 'Next Week' : 'Next Day',
                    onPressed: () {
                      setState(() {
                        _selectedDate = _selectedDate.add(
                          Duration(days: _isWeekView ? 7 : 1),
                        );
                      });
                    },
                  ),
                  const SizedBox(width: 12),

                  // Date range label
                  Text(
                    rangeText,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppleTokens.white
                          : AppleTokens.neutralDark,
                    ),
                  ),
                ],
              ),

              // Day / Week toggle switch
              Container(
                decoration: BoxDecoration(
                  color: isDark
                      ? AppleTokens.neutralDark
                      : AppleTokens.borderSubtle.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppleTokens.borderSubtle),
                ),
                padding: const EdgeInsets.all(2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _toggleButton(
                      label: 'Day',
                      isActive: !_isWeekView,
                      onTap: () => setState(() => _isWeekView = false),
                    ),
                    _toggleButton(
                      label: 'Week',
                      isActive: _isWeekView,
                      onTap: () => setState(() => _isWeekView = true),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _toggleButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppleTokens.primaryTeal : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: isActive ? Colors.white : AppleTokens.neutralBrown,
          ),
        ),
      ),
    );
  }

  Widget _dropdown<T>(
    String label,
    T val,
    List<T> items,
    ValueChanged<T?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppleTokens.borderSubtle.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppleTokens.borderSubtle),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$label: ',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppleTokens.neutralBrown,
            ),
          ),
          DropdownButton<T>(
            value: val,
            underline: const SizedBox(),
            isDense: true,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppleTokens.neutralDark,
            ),
            items: items
                .map(
                  (i) => DropdownMenuItem(
                    value: i,
                    child: Text('$i'),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  // --- Day View Selector Strip ---

  Widget _buildDaySelectorStrip(bool isDark, List<DateTime> weekDays) {
    final now = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.neutralBlack : AppleTokens.warmWhite,
        border: Border(bottom: BorderSide(color: AppleTokens.borderSubtle)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: weekDays.map((d) {
            final isSelected =
                d.year == _selectedDate.year &&
                d.month == _selectedDate.month &&
                d.day == _selectedDate.day;
            final isToday =
                d.year == now.year && d.month == now.month && d.day == now.day;
            final shortDay = _shortDaysOfWeek[d.weekday - 1];

            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: InkWell(
                onTap: () => setState(() => _selectedDate = d),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppleTokens.primaryTeal
                        : (isToday
                              ? AppleTokens.lightMint
                              : Colors.transparent),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isSelected
                          ? AppleTokens.primaryTeal
                          : (isToday
                                ? AppleTokens.purple
                                : AppleTokens.borderSubtle),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        shortDay,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: isSelected
                              ? Colors.white
                              : (isToday
                                    ? AppleTokens.primaryTeal
                                    : AppleTokens.neutralBrown),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${d.day}',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: isSelected
                              ? Colors.white
                              : (isToday
                                    ? AppleTokens.primaryTeal
                                    : AppleTokens.neutralDark),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // --- Weekly Calendar View with Pinned Headers & Left Time Column ---

  Widget _buildWeeklyCalendar({
    required bool isDark,
    required double screenWidth,
    required List<DateTime> weekDays,
    required int minHour,
    required int maxHour,
    required int totalHours,
    required double gridHeight,
  }) {
    // 7 columns width calculation (min 130px ensures cards are readable)
    const minDayColWidth = 130.0;
    final availableForDays = math.max(0.0, screenWidth - _timeColumnWidth - 32);
    final dayWidth = math.max(minDayColWidth, availableForDays / 7);
    final totalDaysWidth = dayWidth * 7;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? AppleTokens.neutralBlack : AppleTokens.warmWhite,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppleTokens.borderSubtle),
      ),
      child: Column(
        children: [
          // 1. PINNED STICKY TOP ROW (Corner Box + Day Headers)
          Row(
            children: [
              // Corner box for Time column
              SizedBox(
                width: _timeColumnWidth,
                height: _headerHeight,
                child: Center(
                  child: Text(
                    'Time',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.neutralBrown,
                    ),
                  ),
                ),
              ),
              Container(
                width: 1,
                height: _headerHeight,
                color: AppleTokens.borderSubtle,
              ),
              // Pinned Day Headers (scrolls horizontally linked with the grid)
              Expanded(
                child: SingleChildScrollView(
                  controller: _horizontalHeaderController,
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  child: SizedBox(
                    width: totalDaysWidth,
                    height: _headerHeight,
                    child: Row(
                      children: List.generate(7, (i) {
                        return _buildDayHeaderCell(
                          date: weekDays[i],
                          dayIndex: i,
                          dayWidth: dayWidth,
                          isDark: isDark,
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Divider below header row
          Container(height: 1, color: AppleTokens.borderSubtle),

          // 2. VERTICALLY SCROLLABLE GRID BODY
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pinned Left Time Column (width 68px, unclipped labels)
                SizedBox(
                  width: _timeColumnWidth,
                  child: SingleChildScrollView(
                    controller: _verticalTimeController,
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    child: SizedBox(
                      height: gridHeight,
                      child: Stack(
                        children: List.generate(totalHours + 1, (i) {
                          final hour = minHour + i;
                          return Positioned(
                            top: (i * _hourHeight) - 8,
                            left: 0,
                            right: 8,
                            child: Text(
                              _formatHourLabel(hour),
                              textAlign: TextAlign.right,
                              style: GoogleFonts.inter(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppleTokens.neutralBrown,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ),

                // Vertical divider between time column and day grid
                Container(width: 1, color: AppleTokens.borderSubtle),

                // Main 2D Scrollable Grid (linked with header horizontally and time vertically)
                Expanded(
                  child: SingleChildScrollView(
                    controller: _verticalGridController,
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      controller: _horizontalGridController,
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: totalDaysWidth,
                        height: gridHeight,
                        child: Stack(
                          children: [
                            // 1. Horizontal time slot grid lines
                            ...List.generate(totalHours, (i) {
                              return Positioned(
                                top: (i + 1) * _hourHeight,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 1,
                                  color: AppleTokens.borderSubtle.withValues(
                                    alpha: 0.6,
                                  ),
                                ),
                              );
                            }),

                            // 2. Vertical day separators & subtle today highlight
                            ...List.generate(7, (i) {
                              final date = weekDays[i];
                              final now = DateTime.now();
                              final isToday =
                                  date.year == now.year &&
                                  date.month == now.month &&
                                  date.day == now.day;

                              return Positioned(
                                left: i * dayWidth,
                                top: 0,
                                bottom: 0,
                                width: dayWidth,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: isToday
                                        ? AppleTokens.primaryTeal.withValues(
                                            alpha: 0.02,
                                          )
                                        : Colors.transparent,
                                    border: Border(
                                      right: BorderSide(
                                        color: AppleTokens.borderSubtle,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),

                            // 3. Current time line indicator
                            _buildCurrentTimeIndicator(
                              weekDays: weekDays,
                              dayWidth: dayWidth,
                              minHour: minHour,
                              maxHour: maxHour,
                            ),

                            // 4. Interactive personal slot targets (Unset / Free / Occupied)
                            ...List.generate(7, (dayIdx) {
                              final dayName = _daysOfWeek[dayIdx];
                              return Positioned(
                                left: dayIdx * dayWidth,
                                top: 0,
                                width: dayWidth,
                                height: gridHeight,
                                child: Stack(
                                  children: List.generate(totalHours, (hIdx) {
                                    final hour = minHour + hIdx;
                                    final slotLabel = _slotLabelForHour(hour);
                                    final hasClass = _doesClassOverlapHour(
                                      dayName,
                                      hour,
                                    );

                                    if (hasClass) {
                                      return const SizedBox.shrink();
                                    }

                                    return Positioned(
                                      top: hIdx * _hourHeight,
                                      left: 0,
                                      right: 0,
                                      height: _hourHeight,
                                      child: _buildInteractiveSlotCell(
                                        dayName: dayName,
                                        slotLabel: slotLabel,
                                        isDark: isDark,
                                      ),
                                    );
                                  }),
                                ),
                              );
                            }),

                            // 5. Official Class Cards (positioned with overlap resolution)
                            ...List.generate(7, (dayIdx) {
                              final dayName = _daysOfWeek[dayIdx];
                              final dayClasses = _classSchedule
                                  .where(
                                    (c) =>
                                        c.dayOfWeek.trim().toLowerCase() ==
                                        dayName.toLowerCase(),
                                  )
                                  .toList();
                              final layouts = _computeDayLayout(
                                dayClasses,
                                minHour,
                                _hourHeight,
                              );

                              return Positioned(
                                left: dayIdx * dayWidth,
                                top: 0,
                                width: dayWidth,
                                height: gridHeight,
                                child: Stack(
                                  children: layouts.map((l) {
                                    final colWidth = dayWidth / l.totalColumns;
                                    final cardLeft =
                                        l.columnIndex * colWidth + 2;
                                    final cardWidth = math.max(
                                      20.0,
                                      colWidth - 4,
                                    );
                                    final cardHeight = math.max(
                                      28.0,
                                      l.height - 2,
                                    );

                                    return Positioned(
                                      left: cardLeft,
                                      top: l.top + 1,
                                      width: cardWidth,
                                      height: cardHeight,
                                      child: _buildClassCard(
                                        layout: l,
                                        isDark: isDark,
                                        isCompact:
                                            cardHeight < 46 || cardWidth < 90,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
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

  // --- Interactive Slot Cell (Unset, Free, Occupied) ---

  Widget _buildInteractiveSlotCell({
    required String dayName,
    required String slotLabel,
    required bool isDark,
  }) {
    final availability = _getSlotAvailability(dayName, slotLabel);
    final key = '$dayName-$slotLabel';
    final isSaving = _savingSlotKeys.contains(key);

    return InkWell(
      onTap: () => _cycleSlotAvailability(dayName, slotLabel),
      onLongPress: () => _showSlotActionSheet(dayName, slotLabel),
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        margin: const EdgeInsets.all(2.5),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: switch (availability) {
            SlotAvailability.free => AppleTokens.freeBackground,
            SlotAvailability.occupied => AppleTokens.occupiedBackground,
            SlotAvailability.unset =>
              isDark ? AppleTokens.darkSurface : Colors.white,
          },
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: switch (availability) {
              SlotAvailability.free => AppleTokens.freeBorder,
              SlotAvailability.occupied => AppleTokens.occupiedBorder,
              SlotAvailability.unset =>
                isDark
                    ? AppleTokens.darkBorder
                    : AppleTokens.unsetSlotBorder.withValues(alpha: 0.6),
            },
            width: availability == SlotAvailability.unset ? 0.8 : 1.2,
          ),
        ),
        child: isSaving
            ? const Center(
                child: SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              )
            : switch (availability) {
                SlotAvailability.free => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 13,
                      color: AppleTokens.freeText,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Free for Study',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.freeText,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                SlotAvailability.occupied => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.block,
                      size: 13,
                      color: AppleTokens.occupiedText,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Occupied',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.occupiedText,
                          height: 1.1,
                        ),
                      ),
                    ),
                  ],
                ),
                SlotAvailability.unset => const SizedBox.shrink(),
              },
      ),
    );
  }

  // --- Day Header Cell ---

  Widget _buildDayHeaderCell({
    required DateTime date,
    required int dayIndex,
    required double dayWidth,
    required bool isDark,
  }) {
    final now = DateTime.now();
    final isToday =
        date.year == now.year && date.month == now.month && date.day == now.day;
    final shortDay = _shortDaysOfWeek[dayIndex];

    return InkWell(
      onTap: () {
        setState(() {
          _selectedDate = date;
          _isWeekView = false;
        });
      },
      child: Container(
        width: dayWidth,
        height: _headerHeight,
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: isToday
              ? AppleTokens.lightMint.withValues(alpha: 0.35)
              : Colors.transparent,
          border: Border(
            right: BorderSide(color: AppleTokens.borderSubtle, width: 1),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              shortDay.toUpperCase(),
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
                color: isToday
                    ? AppleTokens.primaryTeal
                    : AppleTokens.neutralBrown,
              ),
            ),
            const SizedBox(height: 2),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: isToday ? AppleTokens.primaryTeal : Colors.transparent,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isToday
                      ? Colors.white
                      : (isDark ? AppleTokens.white : AppleTokens.neutralDark),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Day Calendar View ---

  Widget _buildDayCalendar({
    required bool isDark,
    required double screenWidth,
    required DateTime activeDate,
    required int minHour,
    required int maxHour,
    required int totalHours,
    required double gridHeight,
  }) {
    final dayWidth = math.max(240.0, screenWidth - _timeColumnWidth - 36);
    final dayName = _daysOfWeek[activeDate.weekday - 1];
    final dayClasses = _classSchedule
        .where((c) => c.dayOfWeek.trim().toLowerCase() == dayName.toLowerCase())
        .toList();
    final layouts = _computeDayLayout(dayClasses, minHour, _hourHeight);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isDark ? AppleTokens.neutralBlack : AppleTokens.warmWhite,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppleTokens.borderSubtle),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Pinned Left Time Column (width 68px)
            SizedBox(
              width: _timeColumnWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: 44,
                    child: Center(
                      child: Text(
                        'Time',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppleTokens.neutralBrown,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: gridHeight,
                    child: Stack(
                      children: List.generate(totalHours + 1, (i) {
                        final hour = minHour + i;
                        return Positioned(
                          top: (i * _hourHeight) - 8,
                          left: 0,
                          right: 8,
                          child: Text(
                            _formatHourLabel(hour),
                            textAlign: TextAlign.right,
                            style: GoogleFonts.inter(
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                              color: AppleTokens.neutralBrown,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),

            // Vertical divider
            Container(
              width: 1,
              height: 44 + gridHeight,
              color: AppleTokens.borderSubtle,
            ),

            // Single Day Schedule Area
            Expanded(
              child: Column(
                children: [
                  // Day title bar
                  Container(
                    height: 44,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '$dayName Schedule',
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: isDark
                                ? AppleTokens.white
                                : AppleTokens.neutralDark,
                          ),
                        ),
                        Text(
                          'Tap slots to toggle availability',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppleTokens.neutralBrown,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1, color: AppleTokens.borderSubtle),

                  // Grid Body
                  SizedBox(
                    height: gridHeight,
                    child: Stack(
                      children: [
                        // Horizontal grid lines
                        ...List.generate(totalHours, (i) {
                          return Positioned(
                            top: (i + 1) * _hourHeight,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 1,
                              color: AppleTokens.borderSubtle.withValues(
                                alpha: 0.6,
                              ),
                            ),
                          );
                        }),

                        // Interactive slot targets (Unset / Free / Occupied)
                        ...List.generate(totalHours, (hIdx) {
                          final hour = minHour + hIdx;
                          final slotLabel = _slotLabelForHour(hour);
                          final hasClass = _doesClassOverlapHour(dayName, hour);

                          if (hasClass) {
                            return const SizedBox.shrink();
                          }

                          return Positioned(
                            top: hIdx * _hourHeight,
                            left: 0,
                            right: 0,
                            height: _hourHeight,
                            child: _buildInteractiveSlotCell(
                              dayName: dayName,
                              slotLabel: slotLabel,
                              isDark: isDark,
                            ),
                          );
                        }),

                        // Official Class Cards
                        ...layouts.map((l) {
                          final colWidth = dayWidth / l.totalColumns;
                          final cardLeft = l.columnIndex * colWidth + 4;
                          final cardWidth = math.max(40.0, colWidth - 8);
                          final cardHeight = math.max(30.0, l.height - 2);

                          return Positioned(
                            left: cardLeft,
                            top: l.top + 1,
                            width: cardWidth,
                            height: cardHeight,
                            child: _buildClassCard(
                              layout: l,
                              isDark: isDark,
                              isCompact: cardHeight < 50,
                            ),
                          );
                        }),
                      ],
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

  // --- Official Class Card (Light Blue, Dark Text, Non-editable) ---

  Widget _buildClassCard({
    required _ScheduledClassLayout layout,
    required bool isDark,
    required bool isCompact,
  }) {
    final c = layout.item;
    final timeStr =
        '${_formatTimeString(c.startTime)} – ${_formatTimeString(c.endTime)}';

    return GestureDetector(
      onTap: () => _showClassDetails(c),
      child: Container(
        decoration: BoxDecoration(
          color: isDark
              ? AppleTokens.darkSurfaceElevated
              : AppleTokens.classBackground,
          borderRadius: BorderRadius.circular(6),
          border: Border(
            left: const BorderSide(color: AppleTokens.primaryTeal, width: 3.5),
            top: BorderSide(color: AppleTokens.classBorder, width: 1.2),
            right: BorderSide(color: AppleTokens.classBorder, width: 1.2),
            bottom: BorderSide(color: AppleTokens.classBorder, width: 1.2),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              c.subject,
              maxLines: isCompact ? 1 : 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: AppleTokens.classText,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              timeStr,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
                color: AppleTokens.primaryTeal,
              ),
            ),
            if (!isCompact && c.room.isNotEmpty) ...[
              const SizedBox(height: 1),
              Text(
                c.room,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  color: AppleTokens.neutralBrown,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // --- Current Time Indicator Line ---

  Widget _buildCurrentTimeIndicator({
    required List<DateTime> weekDays,
    required double dayWidth,
    required int minHour,
    required int maxHour,
  }) {
    final now = DateTime.now();
    int todayIndex = -1;
    for (int i = 0; i < weekDays.length; i++) {
      if (weekDays[i].year == now.year &&
          weekDays[i].month == now.month &&
          weekDays[i].day == now.day) {
        todayIndex = i;
        break;
      }
    }

    if (todayIndex == -1) return const SizedBox.shrink();
    if (now.hour < minHour || now.hour >= maxHour)
      return const SizedBox.shrink();

    final minutes = (now.hour - minHour) * 60.0 + now.minute;
    final top = (minutes / 60.0) * _hourHeight;

    return Positioned(
      left: todayIndex * dayWidth,
      top: top - 4,
      width: dayWidth,
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppleTokens.primaryTeal,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(
              height: 2,
              color: AppleTokens.primaryTeal,
            ),
          ),
        ],
      ),
    );
  }
}
