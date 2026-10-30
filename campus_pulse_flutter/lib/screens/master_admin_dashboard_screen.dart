import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class MasterAdminDashboardScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onSignOut;
  final VoidCallback onExitToStudentPortal;

  const MasterAdminDashboardScreen({
    super.key,
    required this.authState,
    required this.onSignOut,
    required this.onExitToStudentPortal,
  });

  @override
  State<MasterAdminDashboardScreen> createState() =>
      _MasterAdminDashboardScreenState();
}

class _MasterAdminDashboardScreenState extends State<MasterAdminDashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // General state
  bool _isLoadingOverview = true;
  String? _errorMessage;
  DateTime? _lastUpdated;
  Map<String, int> _overviewStats = {};
  List<AdminAuditLog> _recentActivity = [];

  // Students tab state
  bool _isLoadingStudents = false;
  List<StudentProfile> _students = [];
  int _totalStudentsCount = 0;
  int _studentPage = 0;
  static const int _studentPageSize = 10;
  final _studentSearchCtrl = TextEditingController();

  // Timetable tab state
  bool _isLoadingTimetable = false;
  List<SectionTimetable> _timetables = [];
  String _selectedBranch = 'All';
  String _selectedSemester = 'All';
  String _selectedSection = 'All';

  // Timetable form controllers
  final _ttBranchCtrl = TextEditingController(text: 'CSE');
  final _ttSemesterCtrl = TextEditingController(text: '5');
  final _ttSectionCtrl = TextEditingController(text: 'A');
  final _ttDayCtrl = TextEditingController(text: 'Monday');
  final _ttStartCtrl = TextEditingController(text: '09:00');
  final _ttEndCtrl = TextEditingController(text: '10:00');
  final _ttSubjectCtrl = TextEditingController(text: 'Operating Systems');
  final _ttFacultyCtrl = TextEditingController(text: 'Dr. Sharma');
  final _ttRoomCtrl = TextEditingController(text: 'Lab 3');

  // Rewards tab state
  bool _isLoadingRewards = false;
  int _rewardSubTab = 0; // 0 = Perks, 1 = Redemptions
  List<RewardPerk> _rewards = [];
  List<PointsLedger> _redemptions = [];

  // Perk form controllers
  final _perkTitleCtrl = TextEditingController();
  final _perkCategoryCtrl = TextEditingController(text: 'Food & Dining');
  final _perkDescCtrl = TextEditingController();
  final _perkPointsCtrl = TextEditingController(text: '150');
  final _perkStockCtrl = TextEditingController(text: '50');

  // Event Approvals tab state
  bool _isLoadingEventApprovals = false;
  String? _eventApprovalsError;
  List<CampusEvent> _pendingEvents = [];
  int _pendingEventsCount = 0;

  // Approvals tab state
  bool _isLoadingApprovals = false;
  List<AcademicResource> _pendingResources = [];

  // Audit logs tab state
  bool _isLoadingLogs = false;
  List<AdminAuditLog> _auditLogs = [];
  final _logSearchCtrl = TextEditingController();
  String _selectedActionType = 'All';
  int _logPage = 0;
  static const int _logPageSize = 20;

  final List<String> _actionTypes = [
    'All',
    'ADMIN_LOGIN',
    'ROLE_ASSIGN',
    'ROLE_REVOKE',
    'TIMETABLE_CREATE',
    'TIMETABLE_UPDATE',
    'TIMETABLE_DELETE',
    'RESOURCE_APPROVE',
    'RESOURCE_REJECT',
    'REWARD_CREATE',
    'REWARD_UPDATE',
    'REWARD_DELETE',
    'EVENT_REVIEW',
    'EVENT_APPROVE',
    'EVENT_REJECT',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _onTabChanged(_tabController.index);
      }
    });

    _loadOverviewData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _studentSearchCtrl.dispose();
    _ttBranchCtrl.dispose();
    _ttSemesterCtrl.dispose();
    _ttSectionCtrl.dispose();
    _ttDayCtrl.dispose();
    _ttStartCtrl.dispose();
    _ttEndCtrl.dispose();
    _ttSubjectCtrl.dispose();
    _ttFacultyCtrl.dispose();
    _ttRoomCtrl.dispose();
    _perkTitleCtrl.dispose();
    _perkCategoryCtrl.dispose();
    _perkDescCtrl.dispose();
    _perkPointsCtrl.dispose();
    _perkStockCtrl.dispose();
    _logSearchCtrl.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    switch (index) {
      case 0:
        _loadOverviewData();
        break;
      case 1:
        _loadEventApprovalsData();
        break;
      case 2:
        _loadStudentsData();
        break;
      case 3:
        _loadTimetableData();
        break;
      case 4:
        _loadRewardsData();
        break;
      case 5:
        _loadApprovalsData();
        break;
      case 6:
        _loadAuditLogsData();
        break;
    }
  }

  // ==================== DATA LOADERS ====================

  Future<void> _loadOverviewData() async {
    setState(() {
      _isLoadingOverview = true;
      _errorMessage = null;
    });

    try {
      final stats = await client.admin.getDashboardOverview();
      final logs = await client.admin.listAuditLogs(limit: 5, offset: 0);
      int pendingCount = stats['pendingEvents'] ?? 0;
      try {
        pendingCount = await client.event.getPendingEventsCount();
      } catch (_) {
        try {
          final pendingList = await client.event.listEvents(
            approvalStatus: 'pending',
            limit: 100,
            offset: 0,
          );
          pendingCount = pendingList.length;
        } catch (_) {}
      }

      if (mounted) {
        setState(() {
          _overviewStats = stats;
          _pendingEventsCount = pendingCount;
          _recentActivity = logs;
          _lastUpdated = DateTime.now();
          _isLoadingOverview = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingOverview = false;
          _errorMessage = 'Failed to load metrics telemetry: $e';
        });
      }
    }
  }

  Future<void> _loadEventApprovalsData() async {
    setState(() {
      _isLoadingEventApprovals = true;
      _eventApprovalsError = null;
    });

    try {
      List<CampusEvent> events;
      try {
        events = await client.event.getPendingEvents(
          limit: 50,
          offset: 0,
        );
      } catch (_) {
        events = await client.event.listEvents(
          approvalStatus: 'pending',
          limit: 50,
          offset: 0,
        );
      }

      int count = events.length;
      try {
        count = await client.event.getPendingEventsCount();
      } catch (_) {
        count = events.length;
      }

      if (mounted) {
        setState(() {
          _pendingEvents = events;
          _pendingEventsCount = count;
          _isLoadingEventApprovals = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingEventApprovals = false;
          _eventApprovalsError = 'Failed to load event approvals queue: $e';
        });
        _showToast('Error loading event approvals: $e', isError: true);
      }
    }
  }

  Future<void> _approveEvent(CampusEvent event) async {
    if (event.id == null) return;
    try {
      await client.event.reviewEvent(
        eventId: event.id!,
        decision: 'approved',
      );
      if (mounted) {
        setState(() {
          _pendingEvents.removeWhere((e) => e.id == event.id);
          _pendingEventsCount = (_pendingEventsCount - 1).clamp(0, 1000);
        });
        _showToast(
          'Event "${event.title}" approved and published to campus feed!',
        );
        _loadOverviewData();
      }
    } catch (e) {
      _showToast('Failed to approve event: $e', isError: true);
    }
  }

  void _showRejectEventDialog(CampusEvent event) {
    final reasonCtrl = TextEditingController(
      text: 'Event details do not adhere to campus guidelines.',
    );
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: Text('Reject Event: ${event.title}'),
          content: SizedBox(
            width: 480,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please specify a clear rejection reason. This will be recorded in the audit log and delivered to the student creator.',
                    style: TextStyle(
                      fontSize: 13,
                      color: AppleTokens.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: reasonCtrl,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Rejection Reason *',
                      hintText:
                          'e.g. Incomplete venue approval or duplicate scheduling.',
                    ),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Rejection reason is required.';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Confirm Rejection',
              variant: AppleButtonVariant.primary,
              onPressed: () async {
                if (!formKey.currentState!.validate()) return;
                final reason = reasonCtrl.text.trim();
                Navigator.pop(ctx);

                try {
                  await client.event.reviewEvent(
                    eventId: event.id!,
                    decision: 'rejected',
                    rejectionReason: reason,
                  );
                  if (mounted) {
                    setState(() {
                      _pendingEvents.removeWhere((e) => e.id == event.id);
                      _pendingEventsCount = (_pendingEventsCount - 1).clamp(
                        0,
                        1000,
                      );
                    });
                    _showToast(
                      'Event "${event.title}" rejected. Creator notified.',
                    );
                    _loadOverviewData();
                  }
                } catch (e) {
                  _showToast('Failed to reject event: $e', isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showPreviewEventDialog(CampusEvent event) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(AppleTokens.radius999),
                ),
                child: Text(
                  event.category.toUpperCase(),
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: 540,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (event.bannerUrl != null &&
                      event.bannerUrl!.isNotEmpty) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppleTokens.radius12),
                      child: Image.network(
                        event.bannerUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  _previewMetaRow(Icons.place_rounded, 'Venue', event.venue),
                  const SizedBox(height: 8),
                  _previewMetaRow(
                    Icons.schedule_rounded,
                    'Start Time',
                    _formatDateTime(event.startTime),
                  ),
                  if (event.endTime != null) ...[
                    const SizedBox(height: 8),
                    _previewMetaRow(
                      Icons.timer_off_rounded,
                      'End Time',
                      _formatDateTime(event.endTime!),
                    ),
                  ],
                  const SizedBox(height: 8),
                  _previewMetaRow(
                    Icons.person_rounded,
                    'Organizer',
                    '${event.organizerName} (${event.organizerAuthUserId})',
                  ),
                  const SizedBox(height: 8),
                  _previewMetaRow(
                    Icons.history_rounded,
                    'Submitted At',
                    _formatDateTime(event.createdAt),
                  ),
                  if (event.isTeamEvent) ...[
                    const SizedBox(height: 8),
                    _previewMetaRow(
                      Icons.groups_rounded,
                      'Team Size',
                      '${event.minTeamSize} to ${event.maxTeamSize} members',
                    ),
                  ],
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    event.description,
                    style: const TextStyle(fontSize: 13, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            AppleButton(
              label: 'Close',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Reject...',
              variant: AppleButtonVariant.subtle,
              icon: Icons.close_rounded,
              onPressed: () {
                Navigator.pop(ctx);
                _showRejectEventDialog(event);
              },
            ),
            AppleButton(
              label: 'Approve Event',
              variant: AppleButtonVariant.primary,
              icon: Icons.check_rounded,
              onPressed: () {
                Navigator.pop(ctx);
                _approveEvent(event);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _previewMetaRow(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppleTokens.primaryTeal),
        const SizedBox(width: 8),
        Text(
          '$label: ',
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              color: AppleTokens.secondaryText,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _loadStudentsData() async {
    setState(() => _isLoadingStudents = true);

    try {
      final query = _studentSearchCtrl.text.trim();
      final list = await client.admin.listStudents(
        search: query.isEmpty ? null : query,
        limit: _studentPageSize,
        offset: _studentPage * _studentPageSize,
      );
      final count = await client.admin.getStudentCount(
        search: query.isEmpty ? null : query,
      );

      if (mounted) {
        setState(() {
          _students = list;
          _totalStudentsCount = count;
          _isLoadingStudents = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingStudents = false);
        _showToast('Error loading students: $e', isError: true);
      }
    }
  }

  Future<void> _loadTimetableData() async {
    setState(() => _isLoadingTimetable = true);

    try {
      final list = await client.timetable.listAllTimetables(
        branch: _selectedBranch == 'All' ? null : _selectedBranch,
        semester: _selectedSemester == 'All'
            ? null
            : int.tryParse(_selectedSemester),
        section: _selectedSection == 'All' ? null : _selectedSection,
      );

      if (mounted) {
        setState(() {
          _timetables = list;
          _isLoadingTimetable = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingTimetable = false);
        _showToast('Error loading timetables: $e', isError: true);
      }
    }
  }

  Future<void> _loadRewardsData() async {
    setState(() => _isLoadingRewards = true);

    try {
      if (_rewardSubTab == 0) {
        final list = await client.points.listAllRewards();
        if (mounted) {
          setState(() {
            _rewards = list;
            _isLoadingRewards = false;
          });
        }
      } else {
        final redemptions = await client.points.listRedemptions(limit: 50);
        if (mounted) {
          setState(() {
            _redemptions = redemptions;
            _isLoadingRewards = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingRewards = false);
        _showToast('Error loading rewards data: $e', isError: true);
      }
    }
  }

  Future<void> _loadApprovalsData() async {
    setState(() => _isLoadingApprovals = true);

    try {
      final list = await client.academicResource.listPendingResources();
      if (mounted) {
        setState(() {
          _pendingResources = list;
          _isLoadingApprovals = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingApprovals = false);
        _showToast('Error loading approvals queue: $e', isError: true);
      }
    }
  }

  Future<void> _loadAuditLogsData() async {
    setState(() => _isLoadingLogs = true);

    try {
      final query = _logSearchCtrl.text.trim();
      final logs = await client.admin.listAuditLogs(
        search: query.isEmpty ? null : query,
        actionType: _selectedActionType == 'All' ? null : _selectedActionType,
        limit: _logPageSize,
        offset: _logPage * _logPageSize,
      );

      if (mounted) {
        setState(() {
          _auditLogs = logs;
          _isLoadingLogs = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingLogs = false);
        _showToast('Error loading audit logs: $e', isError: true);
      }
    }
  }

  void _showToast(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : AppleTokens.primaryTeal,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ==================== BUILD UI ====================

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.darkBackground
          : AppleTokens.pageBackground,
      appBar: AppBar(
        backgroundColor: isDark ? AppleTokens.darkSurface : Colors.white,
        elevation: 0,
        titleSpacing: AppleTokens.space24,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                color: AppleTokens.primaryTeal,
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
              ),
              child: const Icon(
                Icons.admin_panel_settings_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Pulse Master Control Panel',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                    color: isDark
                        ? AppleTokens.darkTextPrimary
                        : AppleTokens.primaryText,
                  ),
                ),
                Text(
                  'Admin: ${widget.authState.currentProfile?.email ?? "admin@campuspulse.edu"}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          // View Student Portal
          TextButton.icon(
            icon: const Icon(
              Icons.visibility_rounded,
              size: 16,
              color: AppleTokens.primaryTeal,
            ),
            label: const Text(
              'View Student Portal',
              style: TextStyle(
                color: AppleTokens.primaryTeal,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
            onPressed: widget.onExitToStudentPortal,
          ),
          const SizedBox(width: 8),

          // Sign Out Admin
          IconButton(
            tooltip: 'Sign Out Admin Session',
            icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
            onPressed: () {
              _showConfirmDialog(
                title: 'Sign Out of Admin Portal?',
                content:
                    'Your active administrative session will be terminated.',
                confirmLabel: 'Sign Out',
                confirmColor: Colors.redAccent,
                onConfirm: widget.onSignOut,
              );
            },
          ),
          const SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppleTokens.primaryTeal,
          unselectedLabelColor: isDark
              ? AppleTokens.darkTextSecondary
              : AppleTokens.secondaryText,
          indicatorColor: AppleTokens.primaryTeal,
          indicatorWeight: 3,
          labelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: 13,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 13,
          ),
          tabs: [
            const Tab(text: 'Overview & Metrics'),
            Tab(
              text: _pendingEventsCount > 0
                  ? 'Event Approvals ($_pendingEventsCount)'
                  : 'Event Approvals',
            ),
            const Tab(text: 'Students & Roles'),
            const Tab(text: 'Class Timetables'),
            const Tab(text: 'Perks & Rewards'),
            const Tab(text: 'Academic Approvals'),
            const Tab(text: 'Security Audit Logs'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(isDark),
          _buildEventApprovalsTab(isDark),
          _buildStudentsTab(isDark),
          _buildTimetableTab(isDark),
          _buildRewardsTab(isDark),
          _buildApprovalsTab(isDark),
          _buildAuditLogsTab(isDark),
        ],
      ),
    );
  }

  // ==================== TAB 1: OVERVIEW & METRICS ====================

  Widget _buildOverviewTab(bool isDark) {
    if (_isLoadingOverview) {
      return const Center(
        child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            AppleButton(
              label: 'Retry Fetch',
              variant: AppleButtonVariant.primary,
              icon: Icons.refresh_rounded,
              onPressed: _loadOverviewData,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      color: AppleTokens.primaryTeal,
      onRefresh: _loadOverviewData,
      child: ListView(
        padding: const EdgeInsets.all(AppleTokens.space24),
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Platform Operational Telemetry',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppleTokens.primaryText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _lastUpdated != null
                        ? 'Live database telemetry • Last updated: ${_formatDateTime(_lastUpdated!)}'
                        : 'Live database telemetry',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.secondaryText,
                    ),
                  ),
                ],
              ),
              AppleButton(
                label: 'Refresh',
                variant: AppleButtonVariant.subtle,
                icon: Icons.refresh_rounded,
                height: 38,
                onPressed: _loadOverviewData,
              ),
            ],
          ),
          const SizedBox(height: AppleTokens.space20),

          // Metrics Grid (Clickable to jump to relevant tab!)
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _metricCard(
                label: 'Total Students',
                count: _overviewStats['totalStudents'] ?? 0,
                icon: Icons.people_alt_rounded,
                bgColor: AppleTokens.lightMint,
                iconColor: AppleTokens.primaryTeal,
                tooltip: 'Click to manage students and roles',
                onTap: () {
                  _tabController.animateTo(2);
                  _loadStudentsData();
                },
              ),
              _metricCard(
                label: 'Total Events',
                count: _overviewStats['totalEvents'] ?? 0,
                icon: Icons.event_available_rounded,
                bgColor: AppleTokens.lightBlue,
                iconColor: AppleTokens.highlightBlue,
                tooltip: 'Campus events count',
                onTap: () {
                  _tabController.animateTo(1);
                  _loadEventApprovalsData();
                },
              ),
              _metricCard(
                label: 'Pending Event Approvals',
                count: _pendingEventsCount,
                icon: Icons.pending_actions_rounded,
                bgColor: AppleTokens.lightMint,
                iconColor: AppleTokens.primaryTeal,
                tooltip: 'Click to review pending student event submissions',
                onTap: () {
                  _tabController.animateTo(1);
                  _loadEventApprovalsData();
                },
              ),
              _metricCard(
                label: 'Active RSVPs',
                count: _overviewStats['totalRsvps'] ?? 0,
                icon: Icons.bookmark_added_rounded,
                bgColor: AppleTokens.lightCyan,
                iconColor: AppleTokens.primaryTeal,
                tooltip: 'Total registered student RSVPs',
                onTap: () {},
              ),
              _metricCard(
                label: 'Confirmed Attendance',
                count: _overviewStats['totalAttendances'] ?? 0,
                icon: Icons.fact_check_rounded,
                bgColor: AppleTokens.lightMint,
                iconColor: AppleTokens.primaryTeal,
                tooltip: 'QR-verified event check-ins',
                onTap: () {},
              ),
              _metricCard(
                label: 'Issued Certificates',
                count: _overviewStats['totalCertificates'] ?? 0,
                icon: Icons.workspace_premium_rounded,
                bgColor: AppleTokens.lightLavender,
                iconColor: const Color(0xFF705EFF),
                tooltip: 'Event participation certificates',
                onTap: () {},
              ),
              _metricCard(
                label: 'Academic Notes & PYQs',
                count: _overviewStats['totalResources'] ?? 0,
                icon: Icons.menu_book_rounded,
                bgColor: AppleTokens.lightBlue,
                iconColor: AppleTokens.highlightBlue,
                tooltip: 'Approved academic materials in library',
                onTap: () {
                  _tabController.animateTo(5);
                  _loadApprovalsData();
                },
              ),
              _metricCard(
                label: 'Pending Material Approvals',
                count: _overviewStats['pendingResources'] ?? 0,
                icon: Icons.hourglass_top_rounded,
                bgColor: AppleTokens.lightLavender,
                iconColor: Colors.deepOrangeAccent,
                tooltip: 'Click to review pending student submissions',
                onTap: () {
                  _tabController.animateTo(5);
                  _loadApprovalsData();
                },
              ),
              _metricCard(
                label: 'Active Chat Rooms',
                count: _overviewStats['totalChatRooms'] ?? 0,
                icon: Icons.chat_bubble_rounded,
                bgColor: AppleTokens.lightCyan,
                iconColor: AppleTokens.primaryTeal,
                tooltip: 'Branch & club communication channels',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: AppleTokens.space32),

          // Recent Activity Preview Section
          Text(
            'Recent Platform Activity & Audit Stream',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? Colors.white : AppleTokens.primaryText,
            ),
          ),
          const SizedBox(height: 12),
          if (_recentActivity.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(AppleTokens.space24),
              child: const Center(
                child: Text(
                  'No recent audit events recorded.',
                  style: TextStyle(color: AppleTokens.secondaryText),
                ),
              ),
            )
          else
            AppleCard(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: _recentActivity.map((log) {
                  return ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppleTokens.lightMint,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                      ),
                      child: const Icon(
                        Icons.history_rounded,
                        color: AppleTokens.primaryTeal,
                        size: 16,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          log.actionType,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'by ${log.actorName}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppleTokens.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      log.details,
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Text(
                      _formatDateTime(log.timestamp),
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppleTokens.mutedText,
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

  Widget _metricCard({
    required String label,
    required int count,
    required IconData icon,
    required Color bgColor,
    required Color iconColor,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppleTokens.radius12),
        child: SizedBox(
          width: 220,
          child: AppleCard(
            padding: const EdgeInsets.all(AppleTokens.space20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                      ),
                      child: Icon(icon, color: iconColor, size: 20),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 12,
                      color: AppleTokens.mutedText,
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  '$count',
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppleTokens.primaryText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ==================== TAB 2: EVENT APPROVALS ====================

  Widget _buildEventApprovalsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Event Approvals & Moderation Queue',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (_pendingEventsCount > 0) ...[
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius999,
                          ),
                        ),
                        child: Text(
                          '$_pendingEventsCount PENDING',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  'Review student-submitted campus events, verify venues and schedules, and publish them to the official feed.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
            AppleButton(
              label: 'Refresh Queue',
              variant: AppleButtonVariant.subtle,
              icon: Icons.refresh_rounded,
              height: 38,
              onPressed: _loadEventApprovalsData,
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space20),

        if (_isLoadingEventApprovals)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
            ),
          )
        else if (_eventApprovalsError != null)
          AppleCard(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    size: 44,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _eventApprovalsError!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  AppleButton(
                    label: 'Retry Fetch',
                    variant: AppleButtonVariant.primary,
                    icon: Icons.refresh_rounded,
                    onPressed: _loadEventApprovalsData,
                  ),
                ],
              ),
            ),
          )
        else if (_pendingEvents.isEmpty)
          AppleCard(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppleTokens.lightMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 32,
                      color: AppleTokens.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Pending Event Submissions',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'All student-created events have been reviewed. New submissions will appear here in real time.',
                    style: TextStyle(
                      color: AppleTokens.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pendingEvents.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final event = _pendingEvents[index];
              return AppleCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppleTokens.lightMint,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                          ),
                          child: Text(
                            event.category.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              color: AppleTokens.primaryTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppleTokens.lightLavender,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                          ),
                          child: const Text(
                            'PENDING REVIEW',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              color: Color(0xFF705EFF),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          'Submitted: ${_formatDateTime(event.createdAt)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppleTokens.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      event.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppleTokens.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 16,
                      runSpacing: 6,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.place_outlined,
                              size: 15,
                              color: AppleTokens.primaryTeal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.venue,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.schedule_rounded,
                              size: 15,
                              color: AppleTokens.primaryTeal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _formatDateTime(event.startTime),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.person_outline_rounded,
                              size: 15,
                              color: AppleTokens.primaryTeal,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'Submitted by ${event.organizerName}',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppleButton(
                          label: 'Preview',
                          variant: AppleButtonVariant.subtle,
                          icon: Icons.visibility_outlined,
                          height: 36,
                          onPressed: () => _showPreviewEventDialog(event),
                        ),
                        const SizedBox(width: 10),
                        AppleButton(
                          label: 'Approve & Publish',
                          variant: AppleButtonVariant.primary,
                          icon: Icons.check_rounded,
                          height: 36,
                          onPressed: () => _approveEvent(event),
                        ),
                        const SizedBox(width: 10),
                        AppleButton(
                          label: 'Reject with Reason...',
                          variant: AppleButtonVariant.subtle,
                          icon: Icons.close_rounded,
                          height: 36,
                          onPressed: () => _showRejectEventDialog(event),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  // ==================== TAB 3: STUDENTS & ROLES ====================

  Widget _buildStudentsTab(bool isDark) {
    return Column(
      children: [
        // Search & Controls Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: AppleTokens.space16,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _studentSearchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search by student name, email, or branch...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppleTokens.secondaryText,
                    ),
                    suffixIcon: _studentSearchCtrl.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _studentSearchCtrl.clear();
                              _studentPage = 0;
                              _loadStudentsData();
                            },
                          )
                        : null,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
                      borderSide: const BorderSide(color: AppleTokens.border),
                    ),
                  ),
                  onSubmitted: (_) {
                    _studentPage = 0;
                    _loadStudentsData();
                  },
                ),
              ),
              const SizedBox(width: 12),
              AppleButton(
                label: 'Search',
                variant: AppleButtonVariant.primary,
                height: 40,
                onPressed: () {
                  _studentPage = 0;
                  _loadStudentsData();
                },
              ),
            ],
          ),
        ),

        // Students List
        Expanded(
          child: _isLoadingStudents
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppleTokens.primaryTeal,
                  ),
                )
              : _students.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.person_search_rounded,
                        size: 48,
                        color: AppleTokens.mutedText,
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'No students found matching your criteria.',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AppleButton(
                        label: 'Reset Search',
                        variant: AppleButtonVariant.subtle,
                        onPressed: () {
                          _studentSearchCtrl.clear();
                          _studentPage = 0;
                          _loadStudentsData();
                        },
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppleTokens.space24),
                  itemCount: _students.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final s = _students[index];
                    return AppleCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppleTokens.lightMint,
                            ),
                            child: Center(
                              child: Text(
                                s.fullName.isNotEmpty
                                    ? s.fullName[0].toUpperCase()
                                    : 'S',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppleTokens.primaryTeal,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      s.fullName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppleTokens.lightCyan,
                                        borderRadius: BorderRadius.circular(
                                          AppleTokens.radius999,
                                        ),
                                      ),
                                      child: Text(
                                        '${s.branch} • Year ${s.academicYear}',
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          color: AppleTokens.primaryTeal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  s.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppleTokens.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AppleButton(
                            label: 'Manage Roles',
                            variant: AppleButtonVariant.secondary,
                            icon: Icons.shield_outlined,
                            height: 36,
                            onPressed: () => _manageStudentRoles(s),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),

        // Pagination Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${_students.length} of $_totalStudentsCount students',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppleTokens.secondaryText,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    tooltip: 'Previous Page',
                    onPressed: _studentPage > 0
                        ? () {
                            setState(() => _studentPage--);
                            _loadStudentsData();
                          }
                        : null,
                  ),
                  Text(
                    'Page ${_studentPage + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    tooltip: 'Next Page',
                    onPressed:
                        (_studentPage + 1) * _studentPageSize <
                            _totalStudentsCount
                        ? () {
                            setState(() => _studentPage++);
                            _loadStudentsData();
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _manageStudentRoles(StudentProfile student) async {
    List<String> currentRoles = [];
    try {
      currentRoles = await client.admin.getUserRoles(student.authUserId);
    } catch (_) {}

    if (!mounted) return;

    showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppleTokens.radius16),
              ),
              title: Row(
                children: [
                  const Icon(
                    Icons.admin_panel_settings_rounded,
                    color: AppleTokens.primaryTeal,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Roles & Privileges: ${student.fullName}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 440,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email: ${student.email}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppleTokens.secondaryText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Currently Assigned Roles:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (currentRoles.isEmpty)
                      const Text(
                        'Standard Student (no elevated roles)',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppleTokens.secondaryText,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    else
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: currentRoles.map((role) {
                          return Chip(
                            backgroundColor: AppleTokens.lightMint,
                            label: Text(
                              role.toUpperCase(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 11,
                                color: AppleTokens.primaryTeal,
                              ),
                            ),
                            deleteIcon: const Icon(
                              Icons.close_rounded,
                              size: 14,
                            ),
                            onDeleted: () async {
                              try {
                                final res = await client.admin.revokeRole(
                                  student.authUserId,
                                  role,
                                );
                                if (res) {
                                  setDialogState(() {
                                    currentRoles.remove(role);
                                  });
                                  _showToast(
                                    'Role $role revoked successfully.',
                                  );
                                  _loadStudentsData();
                                }
                              } catch (e) {
                                _showToast('$e', isError: true);
                              }
                            },
                          );
                        }).toList(),
                      ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 12),
                    const Text(
                      'Grant New Privilege Role:',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        if (!currentRoles.contains('admin'))
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AppleButton(
                              label: '+ Admin',
                              variant: AppleButtonVariant.subtle,
                              height: 34,
                              onPressed: () async {
                                _showConfirmDialog(
                                  title: 'Grant Superadmin Privilege?',
                                  content:
                                      'Granting Admin role allows full control over student roles, timetables, and system audit logs.',
                                  confirmLabel: 'Grant Admin',
                                  confirmColor: AppleTokens.primaryTeal,
                                  onConfirm: () async {
                                    try {
                                      await client.admin.assignRole(
                                        student.authUserId,
                                        'admin',
                                      );
                                      setDialogState(() {
                                        currentRoles.add('admin');
                                      });
                                      _showToast(
                                        'Admin role granted to ${student.fullName}',
                                      );
                                      _loadStudentsData();
                                    } catch (e) {
                                      _showToast('$e', isError: true);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        if (!currentRoles.contains('organizer'))
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: AppleButton(
                              label: '+ Organizer',
                              variant: AppleButtonVariant.subtle,
                              height: 34,
                              onPressed: () async {
                                try {
                                  await client.admin.assignRole(
                                    student.authUserId,
                                    'organizer',
                                  );
                                  setDialogState(() {
                                    currentRoles.add('organizer');
                                  });
                                  _showToast(
                                    'Organizer role granted to ${student.fullName}',
                                  );
                                  _loadStudentsData();
                                } catch (e) {
                                  _showToast('$e', isError: true);
                                }
                              },
                            ),
                          ),
                        if (!currentRoles.contains('contributor'))
                          AppleButton(
                            label: '+ Contributor',
                            variant: AppleButtonVariant.subtle,
                            height: 34,
                            onPressed: () async {
                              try {
                                await client.admin.assignRole(
                                  student.authUserId,
                                  'contributor',
                                );
                                setDialogState(() {
                                  currentRoles.add('contributor');
                                });
                                _showToast(
                                  'Contributor role granted to ${student.fullName}',
                                );
                                _loadStudentsData();
                              } catch (e) {
                                _showToast('$e', isError: true);
                              }
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                AppleButton(
                  label: 'Done',
                  variant: AppleButtonVariant.primary,
                  height: 36,
                  onPressed: () => Navigator.pop(ctx),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // ==================== TAB 3: CLASS TIMETABLES ====================

  Widget _buildTimetableTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        // Title & Description
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Official Class Timetable Builder',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Manage official academic lectures, laboratories, and section schedules.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
            AppleButton(
              label: '+ Add Class Slot',
              variant: AppleButtonVariant.primary,
              icon: Icons.add_rounded,
              height: 38,
              onPressed: () => _showAddTimetableDialog(),
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space20),

        // Filter Bar
        AppleCard(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                'Filter By:',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              _buildDropdown(
                label: 'Branch',
                value: _selectedBranch,
                items: ['All', 'CSE', 'ECE', 'MECH', 'CIVIL', 'IT', 'AI'],
                onChanged: (val) {
                  setState(() => _selectedBranch = val ?? 'All');
                  _loadTimetableData();
                },
              ),
              _buildDropdown(
                label: 'Semester',
                value: _selectedSemester,
                items: ['All', '1', '2', '3', '4', '5', '6', '7', '8'],
                onChanged: (val) {
                  setState(() => _selectedSemester = val ?? 'All');
                  _loadTimetableData();
                },
              ),
              _buildDropdown(
                label: 'Section',
                value: _selectedSection,
                items: ['All', 'A', 'B', 'C', 'D'],
                onChanged: (val) {
                  setState(() => _selectedSection = val ?? 'All');
                  _loadTimetableData();
                },
              ),
              AppleButton(
                label: 'Reset Filters',
                variant: AppleButtonVariant.subtle,
                height: 36,
                onPressed: () {
                  setState(() {
                    _selectedBranch = 'All';
                    _selectedSemester = 'All';
                    _selectedSection = 'All';
                  });
                  _loadTimetableData();
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: AppleTokens.space20),

        // Timetable Items List
        if (_isLoadingTimetable)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
            ),
          )
        else if (_timetables.isEmpty)
          AppleCard(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 44,
                    color: AppleTokens.mutedText,
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'No timetable entries for selected branch/section.',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  AppleButton(
                    label: 'Add First Class Slot',
                    variant: AppleButtonVariant.primary,
                    icon: Icons.add_rounded,
                    onPressed: () => _showAddTimetableDialog(),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _timetables.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final item = _timetables[index];
              return AppleCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppleTokens.lightMint,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          item.dayOfWeek.length >= 3
                              ? item.dayOfWeek.substring(0, 3).toUpperCase()
                              : item.dayOfWeek,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppleTokens.primaryTeal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                item.subject,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppleTokens.lightCyan,
                                  borderRadius: BorderRadius.circular(
                                    AppleTokens.radius999,
                                  ),
                                ),
                                child: Text(
                                  '${item.branch} • Sem ${item.semester} • Sec ${item.section}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: AppleTokens.primaryTeal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${item.startTime} - ${item.endTime} • Room: ${item.room}${item.faculty != null && item.faculty!.isNotEmpty ? " • Faculty: ${item.faculty}" : ""}',
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppleTokens.secondaryText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.edit_outlined,
                        color: AppleTokens.primaryTeal,
                        size: 20,
                      ),
                      tooltip: 'Edit Slot',
                      onPressed: () => _showEditTimetableDialog(item),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      tooltip: 'Delete Slot',
                      onPressed: () {
                        _showConfirmDialog(
                          title: 'Delete Class Slot?',
                          content:
                              'Remove "${item.subject}" on ${item.dayOfWeek} (${item.startTime} - ${item.endTime})?',
                          confirmLabel: 'Delete',
                          confirmColor: Colors.redAccent,
                          onConfirm: () async {
                            if (item.id != null) {
                              try {
                                await client.timetable.deleteSectionTimetable(
                                  item.id!,
                                );
                                _showToast('Timetable entry deleted.');
                                _loadTimetableData();
                              } catch (e) {
                                _showToast('$e', isError: true);
                              }
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  void _showAddTimetableDialog() {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: const Text(
            'Publish Class Timetable Slot',
            style: TextStyle(fontWeight: FontWeight.w700),
          ),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ttBranchCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Branch (e.g. CSE)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ttSemesterCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Semester (e.g. 5)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ttSectionCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Section (e.g. A)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ttDayCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Day of Week',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ttStartCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Start (HH:mm)',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ttEndCtrl,
                          decoration: const InputDecoration(
                            labelText: 'End (HH:mm)',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _ttSubjectCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Subject Name',
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _ttFacultyCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Faculty In-Charge',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _ttRoomCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Room / Lab',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Publish Entry',
              variant: AppleButtonVariant.primary,
              onPressed: () async {
                try {
                  await client.timetable.addSectionTimetable(
                    branch: _ttBranchCtrl.text.trim(),
                    academicYear:
                        ((int.tryParse(_ttSemesterCtrl.text.trim()) ?? 1) +
                            1) ~/
                        2,
                    semester: int.tryParse(_ttSemesterCtrl.text.trim()) ?? 5,
                    section: _ttSectionCtrl.text.trim(),
                    dayOfWeek: _ttDayCtrl.text.trim(),
                    startTime: _ttStartCtrl.text.trim(),
                    endTime: _ttEndCtrl.text.trim(),
                    subject: _ttSubjectCtrl.text.trim(),
                    room: _ttRoomCtrl.text.trim(),
                    faculty: _ttFacultyCtrl.text.trim(),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                  _showToast('Class slot published successfully!');
                  _loadTimetableData();
                } catch (e) {
                  _showToast('Error: $e', isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditTimetableDialog(SectionTimetable item) {
    final editSubCtrl = TextEditingController(text: item.subject);
    final editFacultyCtrl = TextEditingController(text: item.faculty ?? '');
    final editRoomCtrl = TextEditingController(text: item.room);
    final editStartCtrl = TextEditingController(text: item.startTime);
    final editEndCtrl = TextEditingController(text: item.endTime);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: Text('Edit Slot: ${item.subject}'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: editSubCtrl,
                  decoration: const InputDecoration(labelText: 'Subject Name'),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: editFacultyCtrl,
                  decoration: const InputDecoration(labelText: 'Faculty'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: editStartCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Start Time (HH:mm)',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: editEndCtrl,
                        decoration: const InputDecoration(
                          labelText: 'End Time (HH:mm)',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: editRoomCtrl,
                  decoration: const InputDecoration(labelText: 'Room / Lab'),
                ),
              ],
            ),
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Save Changes',
              variant: AppleButtonVariant.primary,
              onPressed: () async {
                if (item.id == null) return;
                try {
                  final updated = item.copyWith(
                    subject: editSubCtrl.text.trim(),
                    room: editRoomCtrl.text.trim(),
                    faculty: editFacultyCtrl.text.trim(),
                    startTime: editStartCtrl.text.trim(),
                    endTime: editEndCtrl.text.trim(),
                  );
                  await client.timetable.updateSectionTimetable(updated);
                  if (ctx.mounted) Navigator.pop(ctx);
                  _showToast('Timetable entry updated successfully!');
                  _loadTimetableData();
                } catch (e) {
                  _showToast('Update failed: $e', isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ==================== TAB 4: PERKS & REWARDS ====================

  Widget _buildRewardsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Campus Points Economy & Reward Perks',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Configure rewards redeemable via academic streak, study session, and quiz points.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
            AppleButton(
              label: '+ Add New Perk',
              variant: AppleButtonVariant.primary,
              icon: Icons.add_rounded,
              height: 38,
              onPressed: () => _showAddRewardDialog(),
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space20),

        // Sub-Tab Switcher
        Row(
          children: [
            ChoiceChip(
              label: const Text('Reward Catalog'),
              selected: _rewardSubTab == 0,
              selectedColor: AppleTokens.primaryTeal,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: _rewardSubTab == 0
                    ? Colors.white
                    : AppleTokens.primaryText,
              ),
              onSelected: (val) {
                setState(() => _rewardSubTab = 0);
                _loadRewardsData();
              },
            ),
            const SizedBox(width: 8),
            ChoiceChip(
              label: const Text('Redemption History'),
              selected: _rewardSubTab == 1,
              selectedColor: AppleTokens.primaryTeal,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
                color: _rewardSubTab == 1
                    ? Colors.white
                    : AppleTokens.primaryText,
              ),
              onSelected: (val) {
                setState(() => _rewardSubTab = 1);
                _loadRewardsData();
              },
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space20),

        if (_isLoadingRewards)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
            ),
          )
        else if (_rewardSubTab == 0)
          // Rewards Catalog View
          _rewards.isEmpty
              ? AppleCard(
                  padding: const EdgeInsets.all(40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.card_giftcard_rounded,
                          size: 44,
                          color: AppleTokens.mutedText,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No reward perks in catalog yet.',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 12),
                        AppleButton(
                          label: 'Create First Perk',
                          variant: AppleButtonVariant.primary,
                          onPressed: () => _showAddRewardDialog(),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _rewards.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final perk = _rewards[index];
                    return AppleCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppleTokens.lightMint,
                              borderRadius: BorderRadius.circular(
                                AppleTokens.radius8,
                              ),
                            ),
                            child: const Icon(
                              Icons.redeem_rounded,
                              color: AppleTokens.primaryTeal,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      perk.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: perk.isActive
                                            ? AppleTokens.lightMint
                                            : Colors.grey.withValues(
                                                alpha: 0.2,
                                              ),
                                        borderRadius: BorderRadius.circular(
                                          AppleTokens.radius999,
                                        ),
                                      ),
                                      child: Text(
                                        perk.isActive ? 'ACTIVE' : 'INACTIVE',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: perk.isActive
                                              ? AppleTokens.primaryTeal
                                              : AppleTokens.secondaryText,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  perk.description,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppleTokens.secondaryText,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${perk.costPoints} points • Stock remaining: ${perk.stockRemaining} • ${perk.category}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: AppleTokens.primaryTeal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Switch(
                            value: perk.isActive,
                            activeThumbColor: AppleTokens.primaryTeal,
                            onChanged: (val) async {
                              if (perk.id == null) return;
                              try {
                                final updated = perk.copyWith(isActive: val);
                                await client.points.updateRewardPerk(updated);
                                _showToast(
                                  'Perk status updated to ${val ? "Active" : "Inactive"}.',
                                );
                                _loadRewardsData();
                              } catch (e) {
                                _showToast('$e', isError: true);
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete_outline_rounded,
                              color: Colors.redAccent,
                            ),
                            tooltip: 'Delete Perk',
                            onPressed: () {
                              _showConfirmDialog(
                                title: 'Delete Reward Perk?',
                                content:
                                    'Permanently remove "${perk.title}" from the student rewards store?',
                                confirmLabel: 'Delete',
                                confirmColor: Colors.redAccent,
                                onConfirm: () async {
                                  if (perk.id == null) return;
                                  try {
                                    await client.points.deleteRewardPerk(
                                      perk.id!,
                                    );
                                    _showToast('Reward perk deleted.');
                                    _loadRewardsData();
                                  } catch (e) {
                                    _showToast('$e', isError: true);
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                )
        else
          // Redemption History View
          _redemptions.isEmpty
              ? AppleCard(
                  padding: const EdgeInsets.all(40),
                  child: const Center(
                    child: Text(
                      'No student reward redemptions recorded yet.',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppleTokens.secondaryText,
                      ),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _redemptions.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final item = _redemptions[index];
                    return AppleCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline_rounded,
                            color: AppleTokens.primaryTeal,
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${item.studentName} redeemed ${item.description}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${item.points} points deducted • ${_formatDateTime(item.timestamp)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppleTokens.secondaryText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      ],
    );
  }

  void _showAddRewardDialog() {
    _perkTitleCtrl.clear();
    _perkDescCtrl.clear();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: const Text('Add Reward Perk to Store'),
          content: SizedBox(
            width: 440,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _perkTitleCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Perk Title (e.g. Canteen 20% Off)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _perkCategoryCtrl,
                  decoration: const InputDecoration(
                    labelText: 'Category (Dining, Books, Swag)',
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _perkDescCtrl,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _perkPointsCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Points Cost',
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _perkStockCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Stock Remaining',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Create Perk',
              variant: AppleButtonVariant.primary,
              onPressed: () async {
                try {
                  await client.points.addRewardPerk(
                    title: _perkTitleCtrl.text.trim(),
                    category: _perkCategoryCtrl.text.trim(),
                    description: _perkDescCtrl.text.trim(),
                    costPoints:
                        int.tryParse(_perkPointsCtrl.text.trim()) ?? 100,
                    stockRemaining:
                        int.tryParse(_perkStockCtrl.text.trim()) ?? 25,
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                  _showToast('Reward perk published successfully!');
                  _loadRewardsData();
                } catch (e) {
                  _showToast('Failed to create perk: $e', isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ==================== TAB 5: ACADEMIC APPROVALS ====================

  Widget _buildApprovalsTab(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(AppleTokens.space24),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Academic Material Verification Queue',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Review student-submitted lecture notes, PYQs, and syllabus question banks before publishing.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppleTokens.secondaryText,
                  ),
                ),
              ],
            ),
            AppleButton(
              label: 'Refresh Queue',
              variant: AppleButtonVariant.subtle,
              icon: Icons.refresh_rounded,
              height: 38,
              onPressed: _loadApprovalsData,
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space20),

        if (_isLoadingApprovals)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: CircularProgressIndicator(color: AppleTokens.primaryTeal),
            ),
          )
        else if (_pendingResources.isEmpty)
          AppleCard(
            padding: const EdgeInsets.all(40),
            child: Center(
              child: Column(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      color: AppleTokens.lightMint,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 32,
                      color: AppleTokens.primaryTeal,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No Pending Submissions Awaiting Review',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'All uploaded student notes and question banks have been reviewed and verified.',
                    style: TextStyle(
                      color: AppleTokens.secondaryText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _pendingResources.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = _pendingResources[index];
              return AppleCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppleTokens.lightMint,
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                          ),
                          child: Text(
                            item.resourceType.toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 11,
                              color: AppleTokens.primaryTeal,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${item.subjectCode} • ${item.subjectName}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${item.branch} • Sem ${item.semester}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppleTokens.secondaryText,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    if (item.description != null &&
                        item.description!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.description!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                    const SizedBox(height: 8),
                    Text(
                      'Uploaded by ${item.uploaderName} • ${item.fileSize ?? "PDF Document"}',
                      style: const TextStyle(
                        color: AppleTokens.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        AppleButton(
                          label: 'Approve & Publish',
                          variant: AppleButtonVariant.primary,
                          icon: Icons.check_rounded,
                          height: 36,
                          onPressed: () async {
                            if (item.id == null) return;
                            try {
                              await client.academicResource.setApprovalStatus(
                                item.id!,
                                true,
                              );
                              _showToast(
                                'Resource approved and published to student library!',
                              );
                              _loadApprovalsData();
                            } catch (e) {
                              _showToast('Approval error: $e', isError: true);
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        AppleButton(
                          label: 'Reject with Reason',
                          variant: AppleButtonVariant.subtle,
                          icon: Icons.close_rounded,
                          height: 36,
                          onPressed: () => _showRejectDialog(item),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  void _showRejectDialog(AcademicResource item) {
    final reasonCtrl = TextEditingController(
      text: 'Content does not meet quality or curriculum guidelines.',
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: Text('Reject Submission: ${item.title}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Provide feedback to the student explaining why this submission was rejected.',
                style: TextStyle(
                  fontSize: 13,
                  color: AppleTokens.secondaryText,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: reasonCtrl,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Rejection Reason',
                ),
              ),
            ],
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: 'Confirm Rejection',
              variant: AppleButtonVariant.primary,
              onPressed: () async {
                if (item.id == null) return;
                try {
                  await client.academicResource.setApprovalStatus(
                    item.id!,
                    false,
                    reason: reasonCtrl.text.trim(),
                  );
                  if (ctx.mounted) Navigator.pop(ctx);
                  _showToast('Submission rejected and submitter notified.');
                  _loadApprovalsData();
                } catch (e) {
                  _showToast('Error: $e', isError: true);
                }
              },
            ),
          ],
        );
      },
    );
  }

  // ==================== TAB 6: SECURITY AUDIT LOGS ====================

  Widget _buildAuditLogsTab(bool isDark) {
    return Column(
      children: [
        // Controls / Filters Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: 16,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: _logSearchCtrl,
                  decoration: InputDecoration(
                    hintText: 'Search audit records by actor or details...',
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: AppleTokens.secondaryText,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
                      borderSide: const BorderSide(color: AppleTokens.border),
                    ),
                  ),
                  onSubmitted: (_) {
                    _logPage = 0;
                    _loadAuditLogsData();
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: _buildDropdown(
                  label: 'Action Type',
                  value: _selectedActionType,
                  items: _actionTypes,
                  onChanged: (val) {
                    setState(() => _selectedActionType = val ?? 'All');
                    _logPage = 0;
                    _loadAuditLogsData();
                  },
                ),
              ),
              const SizedBox(width: 12),
              AppleButton(
                label: 'Search',
                variant: AppleButtonVariant.primary,
                height: 40,
                onPressed: () {
                  _logPage = 0;
                  _loadAuditLogsData();
                },
              ),
            ],
          ),
        ),

        // Logs List
        Expanded(
          child: _isLoadingLogs
              ? const Center(
                  child: CircularProgressIndicator(
                    color: AppleTokens.primaryTeal,
                  ),
                )
              : _auditLogs.isEmpty
              ? const Center(
                  child: Text(
                    'No security audit logs match the query.',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppleTokens.secondaryText,
                    ),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(AppleTokens.space24),
                  itemCount: _auditLogs.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final log = _auditLogs[index];
                    return AppleCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppleTokens.lightMint,
                              borderRadius: BorderRadius.circular(
                                AppleTokens.radius8,
                              ),
                            ),
                            child: const Icon(
                              Icons.security_rounded,
                              color: AppleTokens.primaryTeal,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppleTokens.primaryTeal
                                            .withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(
                                          AppleTokens.radius999,
                                        ),
                                      ),
                                      child: Text(
                                        log.actionType,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 11,
                                          color: AppleTokens.primaryTeal,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Actor: ${log.actorName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      _formatDateTime(log.timestamp),
                                      style: const TextStyle(
                                        fontSize: 11,
                                        color: AppleTokens.mutedText,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  log.details,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppleTokens.secondaryText,
                                  ),
                                ),
                                if (log.targetEntity.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    'Entity: ${log.targetEntity} (ID: ${log.targetId})',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppleTokens.mutedText,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),

        // Pagination Bar
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppleTokens.space24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppleTokens.darkSurface : Colors.white,
            border: Border(
              top: BorderSide(
                color: isDark ? AppleTokens.darkBorder : AppleTokens.border,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Showing ${_auditLogs.length} audit records',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppleTokens.secondaryText,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left_rounded),
                    onPressed: _logPage > 0
                        ? () {
                            setState(() => _logPage--);
                            _loadAuditLogsData();
                          }
                        : null,
                  ),
                  Text(
                    'Page ${_logPage + 1}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right_rounded),
                    onPressed: _auditLogs.length == _logPageSize
                        ? () {
                            setState(() => _logPage++);
                            _loadAuditLogsData();
                          }
                        : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ==================== HELPER WIDGETS ====================

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppleTokens.radius8),
        border: Border.all(color: AppleTokens.border),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppleTokens.primaryText,
          ),
          items: items.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Text('$label: $e'),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _showConfirmDialog({
    required String title,
    required String content,
    required String confirmLabel,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppleTokens.radius16),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
          ),
          content: Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: AppleTokens.secondaryText,
            ),
          ),
          actions: [
            AppleButton(
              label: 'Cancel',
              variant: AppleButtonVariant.subtle,
              height: 36,
              onPressed: () => Navigator.pop(ctx),
            ),
            AppleButton(
              label: confirmLabel,
              variant: AppleButtonVariant.primary,
              height: 36,
              onPressed: () {
                Navigator.pop(ctx);
                onConfirm();
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDateTime(DateTime dt) {
    final local = dt.toLocal();
    final hour = local.hour > 12
        ? local.hour - 12
        : (local.hour == 0 ? 12 : local.hour);
    final ampm = local.hour >= 12 ? 'PM' : 'AM';
    final minute = local.minute.toString().padLeft(2, '0');
    final second = local.second.toString().padLeft(2, '0');
    return '${local.day}/${local.month}/${local.year} $hour:$minute:$second $ampm';
  }
}
