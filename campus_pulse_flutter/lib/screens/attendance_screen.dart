import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class AttendanceScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const AttendanceScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final _codeController = TextEditingController();
  List<AttendanceRecord> _myHistory = [];
  bool _isLoading = true;
  String? _statusMessage;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _loadHistory() async {
    setState(() => _isLoading = true);
    try {
      final records = await client.attendance.getMyAttendanceHistory();
      if (mounted) {
        setState(() {
          _myHistory = records;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _checkIn() async {
    final code = _codeController.text.trim();
    if (code.isEmpty) return;

    final profile = widget.authState.currentProfile;
    final studentName = profile?.fullName ?? 'Student';

    setState(() {
      _isLoading = true;
      _statusMessage = null;
    });

    try {
      // Event #1 is demo default event
      await client.attendance.checkInWithCode(
        eventId: 1,
        enteredCode: code,
        studentName: studentName,
      );
      if (mounted) {
        setState(() {
          _statusMessage =
              'Check-in confirmed! You are now eligible for event certificate.';
          _isError = false;
          _codeController.clear();
        });
        _loadHistory();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _statusMessage = e.toString().contains('Exception:')
              ? e.toString().split('Exception:').last.trim()
              : 'Failed to verify check-in code. Please check code and ensure you have RSVPed.';
          _isError = true;
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.darkBackground
          : AppleTokens.warmWhite,
      appBar: AppBar(
        title: Text(
          'Event Attendance & Check-In',
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
          // Check-In Banner Card
          AppleCard(
            backgroundColor: AppleTokens.pastelYellow,
            padding: const EdgeInsets.all(AppleTokens.space24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.qr_code_scanner_rounded,
                      color: AppleTokens.darkNavy,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Live Event Check-In',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppleTokens.darkNavy,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter the event check-in code announced by the organizer or displayed on the venue screen to confirm your participation.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppleTokens.darkNavy.withValues(alpha: 0.8),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius16,
                          ),
                        ),
                        child: TextField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            hintText: 'Enter code (e.g. HACK2026)',
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    AppleButton(
                      label: 'Confirm',
                      variant: AppleButtonVariant.primary,
                      onPressed: _checkIn,
                    ),
                  ],
                ),
                if (_statusMessage != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _isError
                          ? Colors.red.shade100
                          : Colors.green.shade100,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isError
                              ? Icons.error_outline
                              : Icons.check_circle_outline,
                          color: _isError
                              ? Colors.red.shade800
                              : Colors.green.shade800,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _statusMessage!,
                            style: TextStyle(
                              color: _isError
                                  ? Colors.red.shade900
                                  : Colors.green.shade900,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Attendance History
          Text(
            'My Attendance History',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: isDark ? AppleTokens.white : AppleTokens.darkNavy,
            ),
          ),
          const SizedBox(height: 12),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_myHistory.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  'No event attendances recorded yet. Join campus events and confirm participation to unlock verified certificates.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(color: AppleTokens.textMutedGrey),
                ),
              ),
            )
          else
            ..._myHistory.map((rec) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: AppleCard(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: rec.status == 'attended'
                            ? Colors.green.shade100
                            : AppleTokens.paleLavender,
                        child: Icon(
                          rec.status == 'attended'
                              ? Icons.check
                              : Icons.access_time_rounded,
                          color: rec.status == 'attended'
                              ? Colors.green.shade800
                              : AppleTokens.darkNavy,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Event #${rec.eventId} Participation',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            Text(
                              'Status: ${rec.status.toUpperCase()} • Code: ${rec.checkInCode ?? "Manual"}',
                              style: const TextStyle(
                                color: AppleTokens.textMutedGrey,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${rec.markedAt.day}/${rec.markedAt.month}/${rec.markedAt.year}',
                        style: const TextStyle(
                          color: AppleTokens.textMutedGrey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        ],
      ),
    );
  }
}
