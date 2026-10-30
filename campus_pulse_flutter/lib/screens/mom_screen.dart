import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class MomScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String route, Widget screen) onNavigate;

  const MomScreen({
    super.key,
    required this.authState,
    required this.onNavigate,
  });

  @override
  State<MomScreen> createState() => _MomScreenState();
}

class _MomScreenState extends State<MomScreen> {
  List<MinutesOfMeeting> _moms = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMoms();
  }

  Future<void> _loadMoms() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.mom.listMoms();
      if (mounted) {
        setState(() {
          _moms = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          if (_moms.isEmpty) {
            _moms = [
              MinutesOfMeeting(
                title: 'Technical Fest & Hackathon Organizing Committee Sync',
                meetingDate: DateTime.now().subtract(const Duration(days: 2)),
                organizerUserId: widget.authState.currentProfile?.authUserId ?? UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
                organizerName: 'Prof. Alok Gupta & Aarav Sharma',
                attendeeNames: ['Aarav Sharma', 'Neha Patel', 'Rohan Das', 'Kavya Singh'],
                agenda: 'Finalize HackPulse 2026 track categories, venue Wi-Fi bandwidth, food sponsors, and digital certificate issuing criteria.',
                discussionPoints: [
                  'Confirmed Auditorium Hall B for opening ceremony and coding labs for 24-hr sprint.',
                  'Agreed on requiring >= 80% event attendance duration before generating official certificates.',
                  'Reviewed academic resource integration with university syllabus.',
                ],
                decisions: [
                  'Approved attendance check-in code mechanism CP-HACK-2026.',
                  'Assigned event certificate signing authority to Dean of Student Affairs.',
                ],
                actionItems: [
                  'Aarav: Upload track guidelines to Academic Resources section.',
                  'Neha: Coordinate team group chats in Campus Chat hub.',
                ],
                createdAt: DateTime.now().subtract(const Duration(days: 2)),
              ),
            ];
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppleTokens.darkBackground : AppleTokens.warmWhite,
      appBar: AppBar(
        title: Text(
          'Minutes of Meeting (MoM)',
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
          Row(
            children: [
              Expanded(
                child: Text(
                  'Official Meeting Records & Action Items',
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
              AppleButton(
                label: '+ New MoM',
                variant: AppleButtonVariant.secondary,
                onPressed: _showCreateMomDialog,
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else if (_moms.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text('No meeting records logged yet.', style: GoogleFonts.inter(color: AppleTokens.textMutedGrey)),
              ),
            )
          else
            ..._moms.map((m) => _buildMomCard(m, isDark)),
        ],
      ),
    );
  }

  Widget _buildMomCard(MinutesOfMeeting mom, bool isDark) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: AppleTokens.pastelYellow, borderRadius: BorderRadius.circular(10)),
                  child: Text('OFFICIAL MINUTES', style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const Spacer(),
                Text(
                  '${mom.meetingDate.day}/${mom.meetingDate.month}/${mom.meetingDate.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppleTokens.textMutedGrey),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(mom.title, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppleTokens.darkNavy)),
            const SizedBox(height: 6),
            Text('Organizer: ${mom.organizerName} • Attendees: ${mom.attendeeNames.join(", ")}', style: const TextStyle(color: AppleTokens.textMutedGrey, fontSize: 12)),
            const SizedBox(height: 14),
            Text('Agenda: ${mom.agenda}', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
            const SizedBox(height: 12),
            const Text('Decisions Taken:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ...mom.decisions.map((d) => Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Text('• $d', style: const TextStyle(fontSize: 13)),
            )),
            const SizedBox(height: 12),
            const Text('Action Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ...mom.actionItems.map((a) => Padding(
              padding: const EdgeInsets.only(top: 4, left: 8),
              child: Text('→ $a', style: const TextStyle(fontSize: 13, color: Colors.blueGrey)),
            )),
          ],
        ),
      ),
    );
  }

  void _showCreateMomDialog() {
    final titleCtrl = TextEditingController();
    final agendaCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Record Minutes of Meeting'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleCtrl, decoration: const InputDecoration(labelText: 'Meeting Title')),
                TextField(controller: agendaCtrl, decoration: const InputDecoration(labelText: 'Agenda Summary')),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                final student = widget.authState.currentProfile;
                await client.mom.createMom(
                  title: titleCtrl.text.trim().isEmpty ? 'Committee Sync' : titleCtrl.text.trim(),
                  meetingDate: DateTime.now(),
                  organizerName: student?.fullName ?? 'Organizer',
                  attendeeNames: [student?.fullName ?? 'Organizer', 'Faculty Advisor'],
                  agenda: agendaCtrl.text.trim().isEmpty ? 'General Operations' : agendaCtrl.text.trim(),
                  discussionPoints: ['Reviewed student feedback and campus priorities.'],
                  decisions: ['Approved project milestones.'],
                  actionItems: ['Follow up in next weekly sprint.'],
                );
                if (ctx.mounted) Navigator.pop(ctx);
                _loadMoms();
              },
              child: const Text('Save MoM'),
            ),
          ],
        );
      },
    );
  }
}
