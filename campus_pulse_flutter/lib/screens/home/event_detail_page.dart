import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../services/auth_state.dart';
import '../../theme/app_theme.dart';

class EventDetailPage extends StatefulWidget {
  final CampusEvent event;

  const EventDetailPage({super.key, required this.event});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late CampusEvent _event;
  StreamSubscription<RsvpUpdate>? _rsvpSub;
  bool _isRsvping = false;
  bool _hasRsvped = false;

  @override
  void initState() {
    super.initState();
    _event = widget.event;

    // Listen to real-time WebSocket RSVP updates
    _rsvpSub = ClientService.instance.rsvpUpdates.listen((update) {
      if (update.eventId == _event.id && mounted) {
        setState(() {
          _event.rsvpCount = update.rsvpCount;
        });
      }
    });
  }

  @override
  void dispose() {
    _rsvpSub?.cancel();
    super.dispose();
  }

  Future<void> _handleRsvp() async {
    if (_hasRsvped || _isRsvping) return;

    final student = AuthState.instance.currentStudent;
    final studentId = student?.id ?? 1;

    setState(() => _isRsvping = true);

    try {
      final update = await ClientService.instance.rsvp(_event.id ?? 0, studentId);
      if (mounted) {
        setState(() {
          _event.rsvpCount = update.rsvpCount;
          _hasRsvped = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🎉 RSVP Confirmed! Count updated live via WebSocket.'),
            backgroundColor: AppTheme.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('RSVP Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isRsvping = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat('EEEE, MMMM d, yyyy • h:mm a').format(_event.startTime);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category & RSVP Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.primary.withOpacity(0.4)),
                  ),
                  child: Text(
                    _event.category.toUpperCase(),
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderDark),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.bolt, color: AppTheme.success, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        '${_event.rsvpCount} Attending (Live)',
                        style: const TextStyle(
                          color: AppTheme.success,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Title
            Text(
              _event.title,
              style: const TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 12),

            // Organizer Info
            Row(
              children: [
                const Icon(Icons.verified_user_outlined, size: 16, color: AppTheme.accent),
                const SizedBox(width: 6),
                Text(
                  'Organized by ${_event.createdBy}',
                  style: const TextStyle(color: AppTheme.accent, fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Details Box
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.schedule_rounded, color: AppTheme.primary, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Date & Time', style: TextStyle(color: AppTheme.textMuted, fontSize: 11)),
                            const SizedBox(height: 2),
                            Text(dateFormatted, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: AppTheme.borderDark, height: 24),
                  Row(
                    children: [
                      const Icon(Icons.location_on_rounded, color: AppTheme.accent, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Campus Venue', style: TextStyle(color: AppTheme.textMuted, fontSize: 11)),
                            const SizedBox(height: 2),
                            Text(_event.venue, style: const TextStyle(color: AppTheme.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            const Text(
              'About the Event',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _event.description,
              style: const TextStyle(
                color: AppTheme.textSecondary,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 40),

            // RSVP Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: _hasRsvped || _isRsvping ? null : _handleRsvp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _hasRsvped ? AppTheme.surfaceDark : AppTheme.primary,
                  side: _hasRsvped ? const BorderSide(color: AppTheme.success) : BorderSide.none,
                ),
                icon: _isRsvping
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(
                        _hasRsvped ? Icons.check_circle_rounded : Icons.bookmark_add_rounded,
                        color: _hasRsvped ? AppTheme.success : Colors.white,
                      ),
                label: Text(
                  _hasRsvped ? 'You Are Attending (RSVP Confirmed)' : 'RSVP for Event',
                  style: TextStyle(
                    color: _hasRsvped ? AppTheme.success : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
