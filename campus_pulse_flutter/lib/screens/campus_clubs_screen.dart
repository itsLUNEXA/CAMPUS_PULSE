import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class CampusClubsScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBackToHome;

  const CampusClubsScreen({
    super.key,
    required this.authState,
    required this.onBackToHome,
  });

  @override
  State<CampusClubsScreen> createState() => _CampusClubsScreenState();
}

class _CampusClubsScreenState extends State<CampusClubsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CampusClub> _clubs = [];
  List<ClubQueryRequest> _myQueries = [];
  bool _isLoading = true;
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'Technical',
    'Management & Entrepreneurship',
    'Cultural & Arts',
    'Management & Finance',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
      final clubs = await client.club.listClubs(
        category: _selectedCategory == 'All' ? null : _selectedCategory,
      );
      List<ClubQueryRequest> myQueries = [];
      if (widget.authState.isAuthenticated) {
        try {
          myQueries = await client.club.getMyClubQueries();
        } catch (_) {}
      }

      if (mounted) {
        setState(() {
          _clubs = clubs;
          _myQueries = myQueries;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _openQueryDialog(CampusClub club, {required String initialTeam}) {
    if (!widget.authState.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please log in to submit a query to campus clubs.'),
          backgroundColor: AppleTokens.error,
        ),
      );
      return;
    }

    String targetTeam = initialTeam; // 'Tech Team' or 'Management Team'
    String queryCategory = 'Project Collaboration';
    final subjectCtrl = TextEditingController();
    final messageCtrl = TextEditingController();
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
                                'Send Query to ${club.name}',
                                style: GoogleFonts.inter(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppleTokens.darkTextPrimary
                                      : AppleTokens.primaryText,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Direct request to the team leads for guidance, collaborations or recruitments.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppleTokens.darkTextSecondary
                                      : AppleTokens.secondaryText,
                                ),
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
                    const Divider(height: 24),

                    // Team selector
                    Text(
                      'Choose Target Team:',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(
                              child: Text('Tech Team 💻'),
                            ),
                            selected: targetTeam == 'Tech Team',
                            selectedColor: AppleTokens.primaryTeal.withValues(alpha: 0.2),
                            onSelected: (val) {
                              if (val) setModalState(() => targetTeam = 'Tech Team');
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ChoiceChip(
                            label: const Center(
                              child: Text('Management Team 📊'),
                            ),
                            selected: targetTeam == 'Management Team',
                            selectedColor: AppleTokens.primaryTeal.withValues(alpha: 0.2),
                            onSelected: (val) {
                              if (val) setModalState(() => targetTeam = 'Management Team');
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Query Category
                    DropdownButtonFormField<String>(
                      initialValue: queryCategory,
                      decoration: const InputDecoration(
                        labelText: 'Query Category',
                        prefixIcon: Icon(Icons.category_outlined, size: 20),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Recruitment',
                          child: Text('Recruitment & Auditions'),
                        ),
                        DropdownMenuItem(
                          value: 'Project Collaboration',
                          child: Text('Project Collaboration / Hackathon Team'),
                        ),
                        DropdownMenuItem(
                          value: 'Event Query',
                          child: Text('Upcoming Event Query'),
                        ),
                        DropdownMenuItem(
                          value: 'Technical Doubt',
                          child: Text('Technical Guidance / Doubt'),
                        ),
                        DropdownMenuItem(
                          value: 'Sponsorship',
                          child: Text('Sponsorship & Brand Collaboration'),
                        ),
                      ],
                      onChanged: (val) {
                        if (val != null) setModalState(() => queryCategory = val);
                      },
                    ),
                    const SizedBox(height: 16),

                    // Subject
                    TextFormField(
                      controller: subjectCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Subject',
                        hintText: 'e.g. Flutter developer role / Joint IoT project proposal',
                        prefixIcon: Icon(Icons.title_rounded, size: 20),
                      ),
                      validator: (v) => v == null || v.trim().isEmpty ? 'Enter subject' : null,
                    ),
                    const SizedBox(height: 16),

                    // Message
                    TextFormField(
                      controller: messageCtrl,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Query Message',
                        hintText: 'Describe your query or what you would like to collaborate on...',
                        alignLabelWithHint: true,
                      ),
                      validator: (v) => v == null || v.trim().length < 10
                          ? 'Message must be at least 10 characters'
                          : null,
                    ),
                    const SizedBox(height: 24),

                    // Submit Button
                    AppleButton(
                      label: isSubmitting ? 'Sending Request...' : 'Send Query to $targetTeam',
                      isLoading: isSubmitting,
                      onPressed: isSubmitting
                          ? null
                          : () async {
                              if (!formKey.currentState!.validate()) return;
                              setModalState(() => isSubmitting = true);
                              try {
                                await client.club.submitClubQuery(
                                  clubId: club.id!,
                                  targetTeam: targetTeam,
                                  category: queryCategory,
                                  subject: subjectCtrl.text.trim(),
                                  message: messageCtrl.text.trim(),
                                );
                                if (mounted) {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Query sent successfully to ${club.name} $targetTeam!',
                                      ),
                                      backgroundColor: AppleTokens.primaryTeal,
                                    ),
                                  );
                                  _loadData();
                                }
                              } catch (e) {
                                setModalState(() => isSubmitting = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Failed to submit query: $e'),
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
    final filteredClubs = _clubs.where((c) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase();
      return c.name.toLowerCase().contains(q) ||
          c.tagline.toLowerCase().contains(q) ||
          c.techTeamLead.toLowerCase().contains(q) ||
          c.managementLead.toLowerCase().contains(q);
    }).toList();

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
              child: const Icon(Icons.groups_rounded, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Campus Clubs & Societies',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    'Connect with Tech & Management Teams directly',
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
            Tab(text: 'Discover Clubs (${_clubs.length})'),
            Tab(text: 'My Query Requests (${_myQueries.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDiscoverClubsTab(isDark, filteredClubs),
          _buildMyQueriesTab(isDark),
        ],
      ),
    );
  }

  Widget _buildDiscoverClubsTab(bool isDark, List<CampusClub> clubs) {
    return RefreshIndicator(
      onRefresh: _loadData,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Search & Category Chips
          TextField(
            decoration: InputDecoration(
              hintText: 'Search club by name, domain, tech team lead...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: () => setState(() => _searchQuery = ''),
                    )
                  : null,
            ),
            onChanged: (val) => setState(() => _searchQuery = val),
          ),
          const SizedBox(height: 12),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _categories.map((cat) {
                final isSelected = _selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: AppleTokens.primaryTeal.withValues(alpha: 0.15),
                    checkmarkColor: AppleTokens.primaryTeal,
                    labelStyle: TextStyle(
                      color: isSelected
                          ? AppleTokens.primaryTeal
                          : (isDark ? AppleTokens.darkTextSecondary : AppleTokens.neutralDark),
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: 12,
                    ),
                    onSelected: (val) {
                      setState(() => _selectedCategory = cat);
                      _loadData();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),

          if (_isLoading)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(40),
                child: CircularProgressIndicator(),
              ),
            )
          else if (clubs.isEmpty)
            AppleCard(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Column(
                  children: [
                    const Icon(Icons.groups_outlined, size: 48, color: AppleTokens.mutedText),
                    const SizedBox(height: 12),
                    Text(
                      'No campus clubs found matching "$_searchQuery".',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          else
            ...clubs.map((club) => _buildClubCard(club, isDark)),
        ],
      ),
    );
  }

  Widget _buildClubCard(CampusClub club, bool isDark) {
    return AppleCard(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    club.name.isNotEmpty ? club.name.substring(0, 1).toUpperCase() : 'C',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppleTokens.primaryTeal,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      club.name,
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppleTokens.white : AppleTokens.primaryText,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      club.tagline,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppleTokens.secondaryText,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              // Category badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppleTokens.lightMint,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  club.category,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppleTokens.primaryTeal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            club.description,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppleTokens.darkTextSecondary : AppleTokens.neutralDark,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 14),

          // Metadata row
          Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _infoPill(Icons.people_outline, '${club.membersCount} Members'),
              if (club.recruitmentOpen)
                _infoPill(Icons.how_to_reg_outlined, 'Recruitment Open', isHighlight: true),
              if (club.meetingSchedule != null)
                _infoPill(Icons.schedule, club.meetingSchedule!),
            ],
          ),
          const Divider(height: 24),

          // TECH TEAM & MANAGEMENT TEAM DIRECT QUERY CARDS
          Text(
            'Direct Query Channels:',
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),

          Row(
            children: [
              // Tech Team box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppleTokens.darkSurfaceElevated : const Color(0xFFF3F9F9),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppleTokens.primaryTeal.withValues(alpha: 0.25)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.terminal_rounded, size: 16, color: AppleTokens.primaryTeal),
                          SizedBox(width: 6),
                          Text(
                            'Tech Team',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        club.techTeamLead,
                        style: const TextStyle(fontSize: 11, color: AppleTokens.secondaryText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.send_rounded, size: 14),
                          label: const Text('Ask Tech Team', style: TextStyle(fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppleTokens.primaryTeal,
                            side: const BorderSide(color: AppleTokens.primaryTeal),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () => _openQueryDialog(club, initialTeam: 'Tech Team'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Management Team box
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppleTokens.darkSurfaceElevated : const Color(0xFFFAF7FF),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.business_center_outlined, size: 16, color: Colors.purple),
                          SizedBox(width: 6),
                          Text(
                            'Management Team',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        club.managementLead,
                        style: const TextStyle(fontSize: 11, color: AppleTokens.secondaryText),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.send_rounded, size: 14),
                          label: const Text('Ask Mgmt Team', style: TextStyle(fontSize: 12)),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.purple,
                            side: const BorderSide(color: Colors.purple),
                            padding: const EdgeInsets.symmetric(vertical: 8),
                          ),
                          onPressed: () => _openQueryDialog(club, initialTeam: 'Management Team'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoPill(IconData icon, String label, {bool isHighlight = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 14,
          color: isHighlight ? AppleTokens.primaryTeal : AppleTokens.mutedText,
        ),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
            color: isHighlight ? AppleTokens.primaryTeal : AppleTokens.secondaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildMyQueriesTab(bool isDark) {
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
                'Please sign in to track your sent club queries.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    if (_myQueries.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mark_email_unread_outlined, size: 48, color: AppleTokens.mutedText),
              const SizedBox(height: 12),
              const Text(
                'You haven\'t sent any club queries yet.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 6),
              const Text(
                'Select any club on the Discover tab and send a request to their Tech or Management team.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppleTokens.secondaryText, fontSize: 13),
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
        itemCount: _myQueries.length,
        itemBuilder: (context, idx) {
          final q = _myQueries[idx];
          final isAnswered = q.status == 'ANSWERED';

          return AppleCard(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${q.clubName} • ${q.targetTeam}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: isAnswered
                            ? const Color(0xFFE6F4EA)
                            : const Color(0xFFFEF3D6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        q.status,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isAnswered ? Colors.green[800] : Colors.orange[900],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  q.subject,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  q.message,
                  style: const TextStyle(fontSize: 13, color: AppleTokens.secondaryText),
                ),
                if (isAnswered && q.responseMessage != null) ...[
                  const Divider(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? AppleTokens.darkSurfaceElevated : const Color(0xFFF3F9F9),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppleTokens.primaryTeal.withValues(alpha: 0.3)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline, color: AppleTokens.primaryTeal, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'Response from ${q.responderName ?? "Team"}:',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          q.responseMessage!,
                          style: const TextStyle(fontSize: 13, height: 1.4),
                        ),
                      ],
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

