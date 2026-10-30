import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

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

  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  final List<String> _defaultTimeSlots = [
    '08:00 - 09:00',
    '09:00 - 10:00',
    '10:00 - 11:00',
    '11:00 - 12:00',
    '12:00 - 13:00',
    '13:00 - 14:00',
    '14:00 - 15:00',
    '15:00 - 16:00',
    '16:00 - 17:00',
    '17:00 - 18:00',
  ];

  @override
  void initState() {
    super.initState();
    final profile = widget.authState.currentProfile;
    if (profile != null) {
      _branch = profile.branch;
      _semester = profile.academicYear * 2 - 1;
    }
    _loadSchedule();
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

  bool _isSlotMarkedFree(String day, String slotLabel) {
    final entry = _freeSlots.firstWhere(
      (s) => s.dayOfWeek == day && s.slotLabel == slotLabel,
      orElse: () => StudentFreeSlot(
        authUserId: widget.authState.currentProfile?.authUserId ?? UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
        dayOfWeek: day,
        slotLabel: slotLabel,
        startTime: slotLabel.split(' - ').first,
        endTime: slotLabel.split(' - ').last,
        isFree: true,
      ),
    );
    return entry.isFree;
  }

  Future<void> _toggleFreeSlot(String day, String slotLabel) async {
    final current = _isSlotMarkedFree(day, slotLabel);
    final parts = slotLabel.split(' - ');
    final updated = await client.timetable.updateFreeSlot(
      dayOfWeek: day,
      slotLabel: slotLabel,
      startTime: parts.first,
      endTime: parts.last,
      isFree: !current,
    );

    setState(() {
      _freeSlots.removeWhere((s) => s.dayOfWeek == day && s.slotLabel == slotLabel);
      _freeSlots.add(updated);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppleTokens.darkBackground : AppleTokens.warmWhite,
      appBar: AppBar(
        title: Text(
          'My Timetable & Free Slots',
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w800,
            color: isDark ? AppleTokens.white : AppleTokens.darkNavy,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppleTokens.space24),
        children: [
          // Selector Card
          AppleCard(
            padding: const EdgeInsets.all(20),
            child: Wrap(
              spacing: 16,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                _dropdown('Branch', _branch, ['CSE', 'ECE', 'Mechanical', 'Civil', 'IT'], (v) {
                  setState(() => _branch = v!);
                  _loadSchedule();
                }),
                _dropdown('Semester', _semester, [1, 2, 3, 4, 5, 6, 7, 8], (v) {
                  setState(() => _semester = v!);
                  _loadSchedule();
                }),
                _dropdown('Section', _section, ['A', 'B', 'C', 'D'], (v) {
                  setState(() => _section = v!);
                  _loadSchedule();
                }),
                AppleButton(
                  label: 'Find Matched Buddies',
                  variant: AppleButtonVariant.secondary,
                  onPressed: () => widget.onNavigate('study_buddies', Container()),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Helper info
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppleTokens.softLavender.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: AppleTokens.darkNavy, size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Tap any time slot to mark yourself FREE or BUSY. Our smart algorithm pairs you with peers free at the exact same hour.',
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppleTokens.darkNavy),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Weekly Grid
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            ..._days.map((day) => _buildDaySchedule(day, isDark)),
        ],
      ),
    );
  }

  Widget _buildDaySchedule(String day, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            day,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: AppleTokens.darkNavy),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _defaultTimeSlots.map((slot) {
                final isFree = _isSlotMarkedFree(day, slot);
                final classInfo = _classSchedule.firstWhere(
                  (c) => c.dayOfWeek.toLowerCase() == day.toLowerCase() && c.startTime == slot.split(' - ').first,
                  orElse: () => SectionTimetable(
                    branch: _branch,
                    academicYear: 3,
                    semester: _semester,
                    section: _section,
                    dayOfWeek: day,
                    startTime: '',
                    endTime: '',
                    subject: '',
                    room: '',
                  ),
                );
                final hasClass = classInfo.subject.isNotEmpty;

                return GestureDetector(
                  onTap: () => _toggleFreeSlot(day, slot),
                  child: Container(
                    width: 130,
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: hasClass
                          ? (isDark ? AppleTokens.darkSurface : AppleTokens.paleLavender)
                          : (isFree ? AppleTokens.pastelYellow : Colors.grey.shade200),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isFree ? AppleTokens.pastelYellow : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          slot,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: AppleTokens.darkNavy),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          hasClass ? classInfo.subject : (isFree ? 'FREE SLOT ✓' : 'Busy'),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                            color: hasClass ? AppleTokens.softLavender : AppleTokens.darkNavy,
                          ),
                        ),
                        if (hasClass)
                          Text(classInfo.room, style: const TextStyle(fontSize: 10, color: AppleTokens.textMutedGrey)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dropdown<T>(String label, T val, List<T> items, ValueChanged<T?> onChanged) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        DropdownButton<T>(
          value: val,
          underline: const SizedBox(),
          items: items.map((i) => DropdownMenuItem(value: i, child: Text('$i'))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

