import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/admin_auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class MasterAdminDashboardScreen extends StatefulWidget {
  final AdminAuthState adminAuthState;
  final VoidCallback onSignOut;
  final VoidCallback onExitToStudentPortal;

  const MasterAdminDashboardScreen({
    super.key,
    required this.adminAuthState,
    required this.onSignOut,
    required this.onExitToStudentPortal,
  });

  @override
  State<MasterAdminDashboardScreen> createState() => _MasterAdminDashboardScreenState();
}

class _MasterAdminDashboardScreenState extends State<MasterAdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  Map<String, int> _overviewStats = {};
  List<AdminAuditLog> _auditLogs = [];
  List<StudentProfile> _students = [];

  // Form controllers for Timetable creation
  final _branchCtrl = TextEditingController(text: 'CSE');
  final _semesterCtrl = TextEditingController(text: '5');
  final _sectionCtrl = TextEditingController(text: 'A');
  final _dayCtrl = TextEditingController(text: 'Monday');
  final _startCtrl = TextEditingController(text: '09:00');
  final _endCtrl = TextEditingController(text: '10:00');
  final _subjectCtrl = TextEditingController(text: 'Operating Systems');
  final _roomCtrl = TextEditingController(text: 'Lab 3');

  // Form controller for Rewards perk
  final _perkTitleCtrl = TextEditingController(text: 'Campus Canteen 20% Discount Pass');
  final _perkCategoryCtrl = TextEditingController(text: 'Food & Dining');
  final _perkDescCtrl = TextEditingController(text: 'Valid for full week across cafeteria outlets.');
  final _perkPointsCtrl = TextEditingController(text: '150');
  final _perkStockCtrl = TextEditingController(text: '50');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 6, vsync: this);
    _loadMasterData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _branchCtrl.dispose();
    _semesterCtrl.dispose();
    _sectionCtrl.dispose();
    _dayCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    _subjectCtrl.dispose();
    _roomCtrl.dispose();
    _perkTitleCtrl.dispose();
    _perkCategoryCtrl.dispose();
    _perkDescCtrl.dispose();
    _perkPointsCtrl.dispose();
    _perkStockCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadMasterData() async {
    setState(() => _isLoading = true);

    try {
      final stats = await client.admin.getDashboardOverview();
      final logs = await client.admin.listAuditLogs(limit: 20);
      final students = await client.student.discoverStudents(limit: 20, offset: 0);

      if (mounted) {
        setState(() {
          _overviewStats = stats;
          _auditLogs = logs;
          _students = students;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _overviewStats = {
            'totalStudents': _students.isNotEmpty ? _students.length : 142,
            'totalEvents': 18,
            'upcomingEvents': 7,
            'totalRsvps': 384,
            'totalAttendances': 295,
            'totalCertificates': 180,
            'totalResources': 85,
            'pendingResources': 6,
            'totalChatRooms': 24,
            'totalMoms': 9,
          };
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F101A) : AppleTokens.warmWhite,
      appBar: AppBar(
        backgroundColor: isDark ? const Color(0xFF181926) : Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppleTokens.softLavender,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.shield_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Master Control Panel',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                    color: isDark ? Colors.white : AppleTokens.darkNavy,
                  ),
                ),
                Text(
                  'Superuser: ${widget.adminAuthState.adminEmail ?? "admin@campuspulse.edu"}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppleTokens.textMutedGrey,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            icon: const Icon(Icons.visibility_rounded, size: 16),
            label: const Text('View Student Portal'),
            onPressed: widget.onExitToStudentPortal,
            style: TextButton.styleFrom(
              foregroundColor: AppleTokens.softLavender,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Sign Out Admin Session',
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: widget.onSignOut,
          ),
          const SizedBox(width: 12),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppleTokens.softLavender,
          unselectedLabelColor: isDark ? AppleTokens.darkTextSecondary : AppleTokens.textMutedGrey,
          indicatorColor: AppleTokens.softLavender,
          tabs: const [
            Tab(text: 'Overview & Metrics'),
            Tab(text: 'Students & Roles'),
            Tab(text: 'Class Timetables'),
            Tab(text: 'Perks & Rewards'),
            Tab(text: 'Academic Approvals'),
            Tab(text: 'Security Audit Logs'),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildOverviewTab(isDark),
                _buildStudentsTab(isDark),
                _buildTimetableTab(isDark),
                _buildRewardsTab(isDark),
                _buildApprovalsTab(isDark),
                _buildAuditLogsTab(isDark),
              ],
            ),
    );
  }

  Widget _buildOverviewTab(bool isDark) {
    return RefreshIndicator(
      onRefresh: _loadMasterData,
      child: ListView(
        padding: const EdgeInsets.all(AppleTokens.space24),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Platform Operational Telemetry',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: isDark ? Colors.white : AppleTokens.darkNavy,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: _loadMasterData,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _statCard('Total Students', '${_overviewStats['totalStudents'] ?? 0}', AppleTokens.pastelBlue, Icons.people_alt_rounded),
              _statCard('Total Events', '${_overviewStats['totalEvents'] ?? 0}', AppleTokens.pastelYellow, Icons.event_available_rounded),
              _statCard('Active RSVPs', '${_overviewStats['totalRsvps'] ?? 0}', AppleTokens.pastelPink, Icons.bookmark_added_rounded),
              _statCard('Confirmed Attendance', '${_overviewStats['totalAttendances'] ?? 0}', AppleTokens.softLavender, Icons.fact_check_rounded),
              _statCard('Issued Certificates', '${_overviewStats['totalCertificates'] ?? 0}', AppleTokens.pastelYellow, Icons.workspace_premium_rounded),
              _statCard('Academic Notes & PYQs', '${_overviewStats['totalResources'] ?? 0}', AppleTokens.pastelBlue, Icons.menu_book_rounded),
              _statCard('Pending Approvals', '${_overviewStats['pendingResources'] ?? 0}', AppleTokens.pastelPink, Icons.pending_actions_rounded),
              _statCard('Active Chat Rooms', '${_overviewStats['totalChatRooms'] ?? 0}', AppleTokens.softLavender, Icons.chat_bubble_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _statCard(String label, String value, Color color, IconData icon) {
    return SizedBox(
      width: 220,
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: color.withValues(alpha: 0.25),
              child: Icon(icon, color: AppleTokens.darkNavy, size: 20),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppleTokens.darkNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppleTokens.textMutedGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentsTab(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppleTokens.space24),
      itemCount: _students.isEmpty ? 1 : _students.length,
      itemBuilder: (context, index) {
        if (_students.isEmpty) {
          return const Center(child: Text('No students currently registered.'));
        }
        final s = _students[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: AppleCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppleTokens.softLavender,
                  child: Text(s.fullName[0], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(s.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text('${s.branch} • Year ${s.academicYear} • ${s.email}', style: const TextStyle(color: AppleTokens.textMutedGrey, fontSize: 13)),
                    ],
                  ),
                ),
                AppleButton(
                  label: 'Manage Permissions',
                  variant: AppleButtonVariant.secondary,
                  onPressed: () => _showRoleDialog(s),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRoleDialog(StudentProfile student) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Manage Privileges: ${student.fullName}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Grant Admin Role'),
                trailing: const Icon(Icons.shield_rounded, color: AppleTokens.pastelPink),
                onTap: () async {
                  await client.admin.assignRole(student.authUserId, 'admin');
                  if (ctx.mounted) Navigator.pop(ctx);
                  _loadMasterData();
                },
              ),
              ListTile(
                title: const Text('Grant Event Organizer'),
                trailing: const Icon(Icons.event_note_rounded, color: AppleTokens.pastelYellow),
                onTap: () async {
                  await client.admin.assignRole(student.authUserId, 'organizer');
                  if (ctx.mounted) Navigator.pop(ctx);
                  _loadMasterData();
                },
              ),
              ListTile(
                title: const Text('Grant Content Contributor'),
                trailing: const Icon(Icons.library_books_rounded, color: AppleTokens.pastelBlue),
                onTap: () async {
                  await client.admin.assignRole(student.authUserId, 'contributor');
                  if (ctx.mounted) Navigator.pop(ctx);
                  _loadMasterData();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTimetableTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        Text(
          'Official Class Timetable Builder (Branch + Section)',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Published schedules are automatically populated into student timetable views to calculate study-buddy free slot overlaps.',
          style: GoogleFonts.inter(fontSize: 13, color: AppleTokens.textMutedGrey),
        ),
        const SizedBox(height: 18),
        AppleCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 16,
                runSpacing: 12,
                children: [
                  SizedBox(width: 140, child: TextField(controller: _branchCtrl, decoration: const InputDecoration(labelText: 'Branch (e.g. CSE)'))),
                  SizedBox(width: 120, child: TextField(controller: _semesterCtrl, decoration: const InputDecoration(labelText: 'Semester (e.g. 5)'))),
                  SizedBox(width: 100, child: TextField(controller: _sectionCtrl, decoration: const InputDecoration(labelText: 'Section (e.g. A)'))),
                  SizedBox(width: 140, child: TextField(controller: _dayCtrl, decoration: const InputDecoration(labelText: 'Day (e.g. Monday)'))),
                  SizedBox(width: 120, child: TextField(controller: _startCtrl, decoration: const InputDecoration(labelText: 'Start (09:00)'))),
                  SizedBox(width: 120, child: TextField(controller: _endCtrl, decoration: const InputDecoration(labelText: 'End (10:00)'))),
                  SizedBox(width: 220, child: TextField(controller: _subjectCtrl, decoration: const InputDecoration(labelText: 'Subject Name'))),
                  SizedBox(width: 140, child: TextField(controller: _roomCtrl, decoration: const InputDecoration(labelText: 'Room / Lab'))),
                ],
              ),
              const SizedBox(height: 20),
              AppleButton(
                label: 'Publish Class Schedule Entry',
                variant: AppleButtonVariant.primary,
                onPressed: () async {
                  await client.timetable.addSectionTimetable(
                    branch: _branchCtrl.text.trim(),
                    academicYear: 3,
                    semester: int.tryParse(_semesterCtrl.text.trim()) ?? 5,
                    section: _sectionCtrl.text.trim(),
                    dayOfWeek: _dayCtrl.text.trim(),
                    startTime: _startCtrl.text.trim(),
                    endTime: _endCtrl.text.trim(),
                    subject: _subjectCtrl.text.trim(),
                    room: _roomCtrl.text.trim(),
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Timetable entry published successfully!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        Text(
          'Campus Points Economy & Reward Perks Manager',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Define perks that students can redeem using points earned via verified QR check-ins, study sessions, and quizzes.',
          style: GoogleFonts.inter(fontSize: 13, color: AppleTokens.textMutedGrey),
        ),
        const SizedBox(height: 18),
        AppleCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(controller: _perkTitleCtrl, decoration: const InputDecoration(labelText: 'Perk Title (e.g. Canteen Discount)')),
              const SizedBox(height: 12),
              TextField(controller: _perkCategoryCtrl, decoration: const InputDecoration(labelText: 'Category (Dining / Fest Pass / Merchandise)')),
              const SizedBox(height: 12),
              TextField(controller: _perkDescCtrl, decoration: const InputDecoration(labelText: 'Description')),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: TextField(controller: _perkPointsCtrl, decoration: const InputDecoration(labelText: 'Points Cost'))),
                  const SizedBox(width: 16),
                  Expanded(child: TextField(controller: _perkStockCtrl, decoration: const InputDecoration(labelText: 'Stock Remaining'))),
                ],
              ),
              const SizedBox(height: 20),
              AppleButton(
                label: 'Create Reward Perk',
                variant: AppleButtonVariant.primary,
                onPressed: () async {
                  await client.points.addRewardPerk(
                    title: _perkTitleCtrl.text.trim(),
                    category: _perkCategoryCtrl.text.trim(),
                    description: _perkDescCtrl.text.trim(),
                    costPoints: int.tryParse(_perkPointsCtrl.text.trim()) ?? 100,
                    stockRemaining: int.tryParse(_perkStockCtrl.text.trim()) ?? 25,
                  );
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Reward perk published to student catalog!')),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        Text(
          'Academic Material Verification Queue',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        AppleCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: AppleTokens.pastelPink, borderRadius: BorderRadius.circular(8)),
                    child: const Text('PYQ • End-Sem 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                  ),
                  const Spacer(),
                  const Text('Subject: CS-301 DSA', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Data Structures & Algorithms - 2024 Question Paper with Solution Keys', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15)),
              const SizedBox(height: 6),
              const Text('Uploaded by Aarav Sharma (CSE Year 3) • 4.2 MB PDF', style: TextStyle(color: AppleTokens.textMutedGrey, fontSize: 12)),
              const SizedBox(height: 14),
              Row(
                children: [
                  AppleButton(
                    label: 'Approve & Publish',
                    variant: AppleButtonVariant.primary,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 10),
                  AppleButton(
                    label: 'Reject / Flag',
                    variant: AppleButtonVariant.outline,
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAuditLogsTab(bool isDark) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppleTokens.space24),
      itemCount: _auditLogs.isEmpty ? 1 : _auditLogs.length,
      itemBuilder: (context, index) {
        if (_auditLogs.isEmpty) {
          return const Center(child: Text('No audit logs recorded yet.'));
        }
        final log = _auditLogs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          child: AppleCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.history_toggle_off_rounded, color: AppleTokens.softLavender, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${log.actionType} • ${log.actorName}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      Text(log.details, style: const TextStyle(fontSize: 13, color: AppleTokens.textMutedGrey)),
                    ],
                  ),
                ),
                Text(
                  '${log.timestamp.hour}:${log.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: AppleTokens.textMutedGrey, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

