import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class InterviewPrepScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBackToHome;

  const InterviewPrepScreen({
    super.key,
    required this.authState,
    required this.onBackToHome,
  });

  @override
  State<InterviewPrepScreen> createState() => _InterviewPrepScreenState();
}

class _InterviewPrepScreenState extends State<InterviewPrepScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CampusCompany> _companies = [];
  List<SeniorExperience> _experiences = [];
  List<MockInterviewSlot> _myMockSlots = [];
  bool _isLoading = true;
  String _selectedCompanyFilter = 'All';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);
    try {
      final companies = await client.interviewPrep.listCompanies();
      final experiences = await client.interviewPrep.listSeniorExperiences(
        companyName: _selectedCompanyFilter == 'All' ? null : _selectedCompanyFilter,
      );

      List<MockInterviewSlot> mySlots = [];
      if (widget.authState.isAuthenticated) {
        try {
          mySlots = await client.interviewPrep.getMyMockInterviewSlots();
        } catch (_) {}
      }

      if (mounted) {
        setState(() {
          _companies = companies;
          _experiences = experiences;
          _myMockSlots = mySlots;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openBookingDialog({String? preselectedCompany}) {
    if (!widget.authState.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please sign in to schedule a senior mock interview.'),
          backgroundColor: AppleTokens.error,
        ),
      );
      return;
    }

    String targetCompany = preselectedCompany ??
        (_companies.isNotEmpty ? _companies.first.name : 'Microsoft');
    String targetRole = 'Software Development Engineer - 1';
    String mockRound = 'Coding & DSA';
    DateTime selectedDate = DateTime.now().add(const Duration(days: 2));
    final resumeCtrl = TextEditingController();
    final notesCtrl = TextEditingController();
    final formKey = GlobalKey<FormState>();
    bool isSubmitting = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setModalState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
              top: 24,
              left: 24,
              right: 24,
            ),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.neutralBlack : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Book 1-on-1 Mock Interview',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? Colors.white : AppleTokens.primaryText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Practice with seniors placed in campus recruiters.',
                                style: TextStyle(fontSize: 12, color: AppleTokens.secondaryText),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.pop(ctx),
                        ),
                      ],
                    ),
                    const Divider(height: 20),

                    // Target Company
                    DropdownButtonFormField<String>(
                      initialValue: targetCompany,
                      decoration: const InputDecoration(
                        labelText: 'Target Campus Recruiter',
                        prefixIcon: Icon(Icons.business_rounded, size: 20),
                      ),
                      items: _companies
                          .map((c) => DropdownMenuItem(
                                value: c.name,
                                child: Text('${c.name} (${c.tier.split(' ').first})'),
                              ))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setModalState(() => targetCompany = val);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Target Role
                    TextFormField(
                      initialValue: targetRole,
                      decoration: const InputDecoration(
                        labelText: 'Target Job Role',
                        prefixIcon: Icon(Icons.work_outline_rounded, size: 20),
                      ),
                      onChanged: (val) => targetRole = val,
                    ),
                    const SizedBox(height: 14),

                    // Mock Round
                    DropdownButtonFormField<String>(
                      initialValue: mockRound,
                      decoration: const InputDecoration(
                        labelText: 'Mock Round Type',
                        prefixIcon: Icon(Icons.psychology_outlined, size: 20),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Coding & DSA',
                          child: Text('Coding Assessment & DSA (Trees/Graphs/DP)'),
                        ),
                        DropdownMenuItem(
                          value: 'System Design & Core CS',
                          child: Text('System Design & Core CS (OS/Networks/DBMS)'),
                        ),
                        DropdownMenuItem(
                          value: 'HR & Resume Walkthrough',
                          child: Text('Behavioral, HR & Project Deep-Dive'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) setModalState(() => mockRound = val);
                      },
                    ),
                    const SizedBox(height: 14),

                    // Preferred Date Picker
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_month_rounded, color: AppleTokens.primaryTeal),
                      title: const Text('Preferred Mock Date', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                        style: const TextStyle(fontSize: 12),
                      ),
                      trailing: TextButton(
                        child: const Text('Change Date'),
                        onPressed: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now().add(const Duration(days: 1)),
                            lastDate: DateTime.now().add(const Duration(days: 30)),
                          );
                          if (picked != null) {
                            setModalState(() => selectedDate = picked);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Resume Link
                    TextFormField(
                      controller: resumeCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Resume Link / Portfolio (Drive/LinkedIn)',
                        hintText: 'https://drive.google.com/...',
                        prefixIcon: Icon(Icons.link_rounded, size: 20),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Notes
                    TextFormField(
                      controller: notesCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Specific topics or weak areas you want feedback on',
                        hintText: 'e.g. Need help with Graph BFS and Amazon Leadership questions',
                      ),
                    ),
                    const SizedBox(height: 20),

                    AppleButton(
                      label: isSubmitting ? 'Queueing Mock...' : 'Confirm Mock Request',
                      isLoading: isSubmitting,
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) return;
                              setModalState(() => isSubmitting = true);
                              try {
                                await client.interviewPrep.requestMockInterview(
                                  targetCompany: targetCompany,
                                  targetRole: targetRole.trim(),
                                  mockRound: mockRound,
                                  preferredDate: selectedDate,
                                  resumeUrl: resumeCtrl.text.trim().isNotEmpty ? resumeCtrl.text.trim() : null,
                                  notes: notesCtrl.text.trim().isNotEmpty ? notesCtrl.text.trim() : null,
                                );
                                if (mounted) {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Mock interview request for $targetCompany queued successfully!',
                                      ),
                                      backgroundColor: AppleTokens.primaryTeal,
                                    ),
                                  );
                                  _loadData();
                                  _tabController.animateTo(2); // Switch to My Mocks tab
                                }
                              } catch (e) {
                                setModalState(() => isSubmitting = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to book mock interview: $e'),
                                    backgroundColor: AppleTokens.error,
                                  ),
                                );
                              }
                            },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppleTokens.neutralBlack : AppleTokens.pageBackground,
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: AppleTokens.primaryTeal,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus Placement & Mock Hub',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'Company rounds, senior experiences & 1-on-1 mocks',
                    style: TextStyle(
                      fontSize: 11,
                      color: AppleTokens.secondaryText,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Book 1-on-1 Mock',
            icon: const Icon(Icons.add_task_rounded),
            onPressed: () => _openBookingDialog(),
          ),
          IconButton(
            tooltip: 'Back to Home',
            icon: const Icon(Icons.home_outlined),
            onPressed: widget.onBackToHome,
          ),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppleTokens.primaryTeal,
          indicatorColor: AppleTokens.primaryTeal,
          tabs: [
            Tab(text: 'Campus Companies (${_companies.length})'),
            Tab(text: 'Senior Experiences (${_experiences.length})'),
            Tab(text: 'My Mock Sessions (${_myMockSlots.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCompaniesTab(isDark),
          _buildExperiencesTab(isDark),
          _buildMyMocksTab(isDark),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppleTokens.primaryTeal,
        icon: const Icon(Icons.person_search_rounded, color: Colors.white),
        label: const Text(
          'Book Senior Mock',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        onPressed: () => _openBookingDialog(),
      ),
    );
  }

  // ==================== TAB 1: COMPANIES ====================

  Widget _buildCompaniesTab(bool isDark) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: _companies.length,
        itemBuilder: (context, idx) {
          final comp = _companies[idx];
          return AppleCard(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: AppleTokens.primaryTeal.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              comp.name.substring(0, 1),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: AppleTokens.primaryTeal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comp.name,
                              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'CTC: ₹${comp.avgPackageLpa} LPA • Cutoff: ${comp.cgpaCutoff} CGPA',
                              style: const TextStyle(fontSize: 12, color: AppleTokens.secondaryText),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppleTokens.lightMint,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        comp.tier,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppleTokens.primaryTeal,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  comp.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? AppleTokens.darkTextSecondary : AppleTokens.neutralDark,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 14),

                // Eligible branches
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: comp.eligibleBranches
                      .map((b) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: isDark ? AppleTokens.darkSurfaceElevated : Colors.grey[100],
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(b, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                          ))
                      .toList(),
                ),
                const Divider(height: 24),

                // Hiring rounds breakdown
                Text(
                  'Campus Hiring Workflow & Selection Rounds:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 8),
                ...comp.hiringRounds.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.arrow_right_rounded, size: 20, color: AppleTokens.primaryTeal),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: const TextStyle(fontSize: 12, height: 1.3),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 14),

                // Key focus topics
                Text(
                  'High-Yield Topics Asked in Campus Drive:',
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
                ),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: comp.keyFocusAreas
                      .map((topic) => Chip(
                            backgroundColor: const Color(0xFFEFF7F7),
                            label: Text(
                              topic,
                              style: const TextStyle(fontSize: 11, color: AppleTokens.neutralDark),
                            ),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
                const SizedBox(height: 16),

                // CTA row
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton.icon(
                      icon: const Icon(Icons.history_edu_rounded, size: 16),
                      label: const Text('Read Senior Experiences', style: TextStyle(fontSize: 12)),
                      onPressed: () {
                        setState(() => _selectedCompanyFilter = comp.name);
                        _tabController.animateTo(1);
                        _loadData();
                      },
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.record_voice_over_rounded, size: 16, color: Colors.white),
                      label: const Text('Request Mock Interview', style: TextStyle(fontSize: 12, color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: AppleTokens.primaryTeal),
                      onPressed: () => _openBookingDialog(preselectedCompany: comp.name),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // ==================== TAB 2: SENIOR EXPERIENCES ====================

  Widget _buildExperiencesTab(bool isDark) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Company Filter selector
          Row(
            children: [
              const Text('Filter Company: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedCompanyFilter,
                items: ['All', 'Microsoft', 'Amazon', 'Cisco', 'TCS Digital / Prime']
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (val) {
                  if (val != null) {
                    setState(() => _selectedCompanyFilter = val);
                    _loadData();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 12),

          if (_experiences.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(32),
              child: const Center(
                child: Text('No senior experiences found for this filter.'),
              ),
            )
          else
            ..._experiences.map((exp) => _buildExperienceCard(exp, isDark)),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(SeniorExperience exp, bool isDark) {
    return AppleCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        exp.seniorName,
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      if (exp.verified)
                        const Icon(Icons.verified, size: 16, color: AppleTokens.primaryTeal),
                    ],
                  ),
                  Text(
                    '${exp.placedRole} • ${exp.companyName} (${exp.packageOffered ?? "Dream CTC"})',
                    style: const TextStyle(fontSize: 12, color: AppleTokens.secondaryText),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  5,
                  (starIdx) => Icon(
                    starIdx < exp.difficultyRating ? Icons.star_rounded : Icons.star_outline_rounded,
                    size: 16,
                    color: Colors.amber,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 20),

          // Actual Questions Asked
          Text(
            'Actual Questions Asked in Campus Interview:',
            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 8),
          ...exp.interviewQuestions.map((q) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.help_outline_rounded, size: 16, color: AppleTokens.primaryTeal),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        q,
                        style: const TextStyle(fontSize: 13, height: 1.35),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 14),

          // Review of rounds
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurfaceElevated : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.rate_review_outlined, size: 15, color: AppleTokens.secondaryText),
                    SizedBox(width: 6),
                    Text(
                      'Experience Breakdown:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  exp.experienceReview,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Tips for Juniors
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppleTokens.darkSurfaceElevated : const Color(0xFFF3F9F9),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppleTokens.primaryTeal.withValues(alpha: 0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.tips_and_updates_outlined, size: 16, color: AppleTokens.primaryTeal),
                    SizedBox(width: 6),
                    Text(
                      'Senior Tips for Juniors:',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppleTokens.primaryTeal),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  exp.tipsForJuniors,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
          if (exp.contactHandle != null) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Reach out: ${exp.contactHandle!}',
                  style: const TextStyle(fontSize: 11, color: AppleTokens.secondaryText),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ==================== TAB 3: MY MOCKS ====================

  Widget _buildMyMocksTab(bool isDark) {
    if (!widget.authState.isAuthenticated) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 48, color: AppleTokens.mutedText),
              const SizedBox(height: 12),
              const Text(
                'Please sign in to schedule and review your 1-on-1 mock interviews.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
      );
    }

    if (_myMockSlots.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.event_available_outlined, size: 48, color: AppleTokens.mutedText),
              const SizedBox(height: 12),
              const Text(
                'No mock interviews requested yet.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              const Text(
                'Tap "Book Senior Mock" to schedule a personalized session for your target campus company.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppleTokens.secondaryText, fontSize: 13),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text('Book Mock Now', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(backgroundColor: AppleTokens.primaryTeal),
                onPressed: () => _openBookingDialog(),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemCount: _myMockSlots.length,
        itemBuilder: (context, idx) {
          final slot = _myMockSlots[idx];
          Color statusColor;
          switch (slot.status) {
            case 'CONFIRMED':
              statusColor = Colors.green;
              break;
            case 'COMPLETED':
              statusColor = Colors.blueGrey;
              break;
            default:
              statusColor = Colors.orange;
          }

          return AppleCard(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${slot.targetCompany} • ${slot.mockRound}',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: statusColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        slot.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Scheduled Date: ${slot.preferredDate.day}/${slot.preferredDate.month}/${slot.preferredDate.year}',
                  style: const TextStyle(fontSize: 12, color: AppleTokens.secondaryText),
                ),
                if (slot.seniorMentorName != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    'Assigned Senior Mentor: ${slot.seniorMentorName!}',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
                if (slot.meetingLink != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.video_call_rounded, color: AppleTokens.primaryTeal, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        'Meeting Link: ${slot.meetingLink!}',
                        style: const TextStyle(fontSize: 12, color: AppleTokens.primaryTeal),
                      ),
                    ],
                  ),
                ],
                if (slot.feedbackNotes != null) ...[
                  const Divider(height: 16),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F9F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Mentor Feedback: ${slot.feedbackNotes!}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

