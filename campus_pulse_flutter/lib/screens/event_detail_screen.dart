import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import '../widgets/confirmation_dialog.dart';
import '../widgets/copy_button.dart';

class EventDetailScreen extends StatefulWidget {
  final CampusEvent event;
  final AuthState authState;
  final VoidCallback onBack;

  const EventDetailScreen({
    super.key,
    required this.event,
    required this.authState,
    required this.onBack,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  late CampusEvent _currentEvent;
  bool _isRsvpd = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentEvent = widget.event;
    _checkRsvpStatus();
  }

  Future<void> _checkRsvpStatus() async {
    if (!widget.authState.isAuthenticated) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final isRsvpd = await client.event.hasUserRsvpd(_currentEvent.id!);
      final refreshed = await client.event.getEvent(_currentEvent.id!);
      if (mounted) {
        setState(() {
          _isRsvpd = isRsvpd;
          if (refreshed != null) _currentEvent = refreshed;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _handleRsvp() async {
    if (!widget.authState.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to register for events.')),
      );
      return;
    }

    if (_currentEvent.approvalStatus != 'approved') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registrations are only open for approved events.'),
        ),
      );
      return;
    }

    final isExpired =
        _currentEvent.registrationDeadline != null &&
        DateTime.now().toUtc().isAfter(_currentEvent.registrationDeadline!);
    if (isExpired && !_isRsvpd) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registration deadline for this event has passed.'),
        ),
      );
      return;
    }

    if (_isRsvpd) {
      // Cancellation with accessible confirmation modal (UX feature 14.17)
      final confirmed = await ConfirmationDialog.show(
        context,
        title: 'Cancel Event Registration?',
        message:
            'Are you sure you want to cancel your registration for "${_currentEvent.title}"? Your seat will be made available to other students.',
        confirmLabel: 'Cancel Registration',
        isDestructive: true,
      );
      if (!confirmed) return;

      setState(() => _isLoading = true);
      try {
        await client.event.cancelRegistration(_currentEvent.id!);
        final updated = await client.event.getEvent(_currentEvent.id!);
        setState(() {
          _isRsvpd = false;
          if (updated != null) _currentEvent = updated;
          _isLoading = false;
        });
      } catch (_) {
        setState(() => _isLoading = false);
      }
    } else {
      if (_currentEvent.isTeamEvent) {
        _showTeamRegistrationDialog();
        return;
      }

      setState(() => _isLoading = true);
      try {
        await client.event.registerForEvent(_currentEvent.id!);
        final updated = await client.event.getEvent(_currentEvent.id!);
        setState(() {
          _isRsvpd = true;
          if (updated != null) _currentEvent = updated;
          _isLoading = false;
        });
      } catch (e) {
        setState(() => _isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
          );
        }
      }
    }
  }

  void _showTeamRegistrationDialog() {
    final teamNameCtrl = TextEditingController();
    final memberCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Team Registration (${_currentEvent.minTeamSize}-${_currentEvent.maxTeamSize} Members)',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: teamNameCtrl,
              decoration: const InputDecoration(labelText: 'Team Name *'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: memberCtrl,
              decoration: const InputDecoration(
                labelText: 'Teammate Name(s) (comma separated)',
                hintText: 'e.g. John Doe, Jane Smith',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final teamName = teamNameCtrl.text.trim();
              if (teamName.isEmpty) return;

              final memberNames = memberCtrl.text
                  .split(',')
                  .map((s) => s.trim())
                  .where((s) => s.isNotEmpty)
                  .toList();

              Navigator.pop(ctx);
              setState(() => _isLoading = true);
              try {
                await client.event.registerForEvent(
                  _currentEvent.id!,
                  teamName: teamName,
                  teamMemberNames: memberNames,
                );
                final updated = await client.event.getEvent(_currentEvent.id!);
                if (mounted) {
                  setState(() {
                    _isRsvpd = true;
                    if (updated != null) _currentEvent = updated;
                    _isLoading = false;
                  });
                }
              } catch (e) {
                if (mounted) {
                  setState(() => _isLoading = false);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.toString().replaceAll('Exception: ', '')),
                    ),
                  );
                }
              }
            },
            child: const Text('Confirm Registration'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back Button
              AppleButton(
                label: 'Back to Events',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back_rounded,
                height: 38,
                onPressed: widget.onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              // Review Status Banner (for Pending or Rejected Events)
              if (_currentEvent.approvalStatus == 'pending') ...[
                Container(
                  padding: const EdgeInsets.all(AppleTokens.space16),
                  decoration: BoxDecoration(
                    color: AppleTokens.lightMint.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(AppleTokens.radius12),
                    border: Border.all(
                      color: AppleTokens.primaryTeal.withValues(alpha: 0.4),
                    ),
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.hourglass_top_rounded,
                        color: AppleTokens.primaryTeal,
                        size: 22,
                      ),
                      SizedBox(width: AppleTokens.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Submitted for Admin Approval',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: AppleTokens.primaryTeal,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'This event is currently awaiting administrative review and is not visible in the public feed. Registrations will open once approved.',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppleTokens.deepForest,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space16),
              ] else if (_currentEvent.approvalStatus == 'rejected') ...[
                Container(
                  padding: const EdgeInsets.all(AppleTokens.space16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDE2E2),
                    borderRadius: BorderRadius.circular(AppleTokens.radius12),
                    border: Border.all(color: const Color(0xFFFCA5A5)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.cancel_rounded,
                        color: Color(0xFF9B1C1C),
                        size: 22,
                      ),
                      SizedBox(width: AppleTokens.space12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Event Submission Rejected',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                color: Color(0xFF9B1C1C),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Reason: ${_currentEvent.rejectionReason ?? "Event details did not meet campus activity criteria."}',
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF9B1C1C),
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space16),
              ],

              // Banner Image if available
              if (_currentEvent.bannerUrl != null &&
                  _currentEvent.bannerUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppleTokens.radius16),
                  child: Image.network(
                    _currentEvent.bannerUrl!,
                    height: 260,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => const SizedBox.shrink(),
                  ),
                ),
              if (_currentEvent.bannerUrl != null)
                const SizedBox(height: AppleTokens.space24),

              // Event Info Card
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category & RSVP Count
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppleTokens.darkSurfaceElevated
                                : AppleTokens.palePurple,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius999,
                            ),
                          ),
                          child: Text(
                            _currentEvent.category.toUpperCase(),
                            style: TextStyle(
                              color: isDark
                                  ? AppleTokens.darkTextPrimary
                                  : AppleTokens.deepNavy,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.people_outline_rounded,
                          size: 18,
                          color: isDark
                              ? AppleTokens.darkAccentPurple
                              : AppleTokens.accentPurple,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${_currentEvent.rsvpCount} Attending',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: isDark
                                ? AppleTokens.darkTextPrimary
                                : AppleTokens.deepNavy,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppleTokens.space16),

                    // Title
                    Text(
                      _currentEvent.title,
                      style: GoogleFonts.newsreader(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                        color: isDark
                            ? AppleTokens.darkTextPrimary
                            : AppleTokens.deepNavy,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space24),

                    // Metadata Grid
                    Container(
                      padding: const EdgeInsets.all(AppleTokens.space16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppleTokens.darkSurfaceElevated
                            : AppleTokens.background,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius12,
                        ),
                        border: Border.all(
                          color: isDark
                              ? AppleTokens.darkBorder
                              : AppleTokens.border,
                        ),
                      ),
                      child: Column(
                        children: [
                          _metaRow(
                            Icons.calendar_today_rounded,
                            'Schedule',
                            '${_formatDate(_currentEvent.startTime)}${_currentEvent.endTime != null ? " – ${_formatTime(_currentEvent.endTime!)}" : ""}',
                          ),
                          const SizedBox(height: AppleTokens.space12),
                          _metaRow(
                            Icons.location_on_rounded,
                            'Venue',
                            _currentEvent.venue,
                          ),
                          const SizedBox(height: AppleTokens.space12),
                          _metaRow(
                            Icons.person_rounded,
                            'Organizer',
                            _currentEvent.organizerName,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space24),

                    // Description
                    Text(
                      'About This Event',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space8),
                    Text(
                      _currentEvent.description,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: isDark
                            ? AppleTokens.darkTextSecondary
                            : AppleTokens.secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space32),

                    // Actions Row
                    Wrap(
                      spacing: AppleTokens.space16,
                      runSpacing: AppleTokens.space12,
                      children: [
                        if (_currentEvent.approvalStatus == 'approved')
                          AppleButton(
                            label: _isRsvpd
                                ? 'Cancel Registration'
                                : 'Register for Event',
                            variant: _isRsvpd
                                ? AppleButtonVariant.outline
                                : AppleButtonVariant.primary,
                            icon: _isRsvpd
                                ? Icons.check_circle_outline
                                : Icons.bookmark_border,
                            isLoading: _isLoading,
                            height: 44,
                            onPressed: _handleRsvp,
                          )
                        else
                          AppleButton(
                            label: _currentEvent.approvalStatus == 'pending'
                                ? 'Pending Admin Approval'
                                : 'Registration Closed (Rejected)',
                            variant: AppleButtonVariant.subtle,
                            icon: _currentEvent.approvalStatus == 'pending'
                                ? Icons.hourglass_top_rounded
                                : Icons.block_rounded,
                            height: 44,
                            onPressed: null,
                          ),
                        CopyButton(
                          textToCopy:
                              'CAMPULSE Event: ${_currentEvent.title} on ${_formatDate(_currentEvent.startTime)} at ${_currentEvent.venue}',
                          label: 'Share Event',
                        ),
                      ],
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

  Widget _metaRow(IconData icon, String label, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: isDark
              ? AppleTokens.darkAccentPurple
              : AppleTokens.accentPurple,
        ),
        const SizedBox(width: AppleTokens.space12),
        Text(
          '$label: ',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: isDark ? AppleTokens.darkTextPrimary : AppleTokens.deepNavy,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              color: isDark
                  ? AppleTokens.darkTextSecondary
                  : AppleTokens.bodyText,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    return '${local.day}/${local.month}/${local.year} at $hour:$minute $ampm';
  }

  String _formatTime(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    return '$hour:$minute $ampm';
  }
}
