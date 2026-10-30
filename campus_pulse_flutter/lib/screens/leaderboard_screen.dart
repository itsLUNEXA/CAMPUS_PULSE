import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../services/realtime_service.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class LeaderboardScreen extends StatefulWidget {
  final AuthState authState;
  final RealtimeService realtimeService;
  final VoidCallback onTakeQuiz;

  const LeaderboardScreen({
    super.key,
    required this.authState,
    required this.realtimeService,
    required this.onTakeQuiz,
  });

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedSubject = 'All';
  String _selectedBranch = 'All';

  final List<String> _subjects = [
    'All',
    'DBMS',
    'Operating Systems',
    'Data Structures and Algorithms',
  ];
  final List<String> _branches = [
    'All',
    'CSE',
    'IT',
    'ECE',
    'Mechanical',
    'Civil',
  ];

  List<LeaderboardEntry> _entries = [];
  LeaderboardEntry? _myRank;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();
    widget.realtimeService.addListener(_onRealtimeUpdate);
  }

  void _onRealtimeUpdate() {
    // Refresh ranking on new quiz attempt broadcast
    _loadLeaderboard();
  }

  Future<void> _loadLeaderboard() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.leaderboard.getLeaderboard(
        subject: _selectedSubject != 'All' ? _selectedSubject : null,
        branch: _selectedBranch != 'All' ? _selectedBranch : null,
        limit: 50,
        offset: 0,
      );

      LeaderboardEntry? rank;
      if (widget.authState.isAuthenticated) {
        rank = await client.leaderboard.getMyRank(
          subject: _selectedSubject != 'All' ? _selectedSubject : null,
        );
      }

      if (mounted) {
        setState(() {
          _entries = list;
          _myRank = rank;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    widget.realtimeService.removeListener(_onRealtimeUpdate);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: _loadLeaderboard,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space24,
          vertical: AppleTokens.space32,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Campus Leaderboard',
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppleTokens.space4),
                        Text(
                          'Authoritative rankings computed from verified academic quiz attempts.',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: isDark
                                    ? AppleTokens.darkTextSecondary
                                    : AppleTokens.secondaryText,
                              ),
                        ),
                      ],
                    ),
                    AppleButton(
                      label: 'Take a Quiz',
                      icon: Icons.quiz_outlined,
                      onPressed: widget.onTakeQuiz,
                    ),
                  ],
                ),
                const SizedBox(height: AppleTokens.space24),

                // My Rank Highlight Banner (Mindly warm cream style)
                if (_myRank != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppleTokens.space16),
                    decoration: BoxDecoration(
                      color:
                          isDark
                              ? AppleTokens.darkSurfaceElevated
                              : AppleTokens.warmCream,
                      borderRadius: BorderRadius.circular(AppleTokens.radius12),
                      border: Border.all(
                        color:
                            isDark
                                ? AppleTokens.darkBorder
                                : AppleTokens.yellowAccent.withValues(
                                  alpha: 0.5,
                                ),
                        width: 1.2,
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor:
                              isDark
                                  ? AppleTokens.palePurple
                                  : AppleTokens.deepNavy,
                          child: Text(
                            '#${_myRank!.rank}',
                            style: TextStyle(
                              color:
                                  isDark ? AppleTokens.deepNavy : Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppleTokens.space16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Your Current Ranking: #${_myRank!.rank}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color:
                                      isDark
                                          ? AppleTokens.darkTextPrimary
                                          : AppleTokens.deepNavy,
                                ),
                              ),
                              Text(
                                '${_myRank!.score} total points across ${_myRank!.quizzesTaken} quiz challenges (${_myRank!.accuracy}% accuracy)',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color:
                                          isDark
                                              ? AppleTokens.darkTextSecondary
                                              : AppleTokens.bodyText,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppleTokens.space20),
                ],

                // Filter Card
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space16),
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _subjects.map((sub) {
                            final isSelected = _selectedSubject == sub;
                            return Padding(
                              padding: const EdgeInsets.only(
                                right: AppleTokens.space8,
                              ),
                              child: ChoiceChip(
                                label: Text(sub),
                                selected: isSelected,
                                onSelected: (val) {
                                  if (val) {
                                    setState(() => _selectedSubject = sub);
                                    _loadLeaderboard();
                                  }
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: AppleTokens.space12),

                      DropdownButtonFormField<String>(
                        initialValue: _selectedBranch,
                        decoration: const InputDecoration(
                          labelText: 'Filter by Department / Branch',
                        ),
                        items: _branches
                            .map(
                              (b) => DropdownMenuItem(value: b, child: Text(b)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) {
                            setState(() => _selectedBranch = v);
                            _loadLeaderboard();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space24),

                // Leaderboard Table / Cards
                if (_isLoading)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(48),
                      child: CircularProgressIndicator(),
                    ),
                  )
                else if (_entries.isEmpty)
                  AppleCard(
                    padding: const EdgeInsets.all(AppleTokens.space40),
                    child: Center(
                      child: Column(
                        children: [
                          const Icon(
                            Icons.emoji_events_outlined,
                            size: 48,
                            color: AppleTokens.secondaryText,
                          ),
                          const SizedBox(height: AppleTokens.space16),
                          Text(
                            'No Leaderboard Scores Yet',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: AppleTokens.space8),
                          const Text(
                            'Be the first to complete a quiz in this subject and take rank #1!',
                          ),
                          const SizedBox(height: AppleTokens.space16),
                          AppleButton(
                            label: 'Take Quiz Now',
                            onPressed: widget.onTakeQuiz,
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _entries.length,
                    itemBuilder: (context, index) {
                      final entry = _entries[index];
                      return _leaderboardTile(context, entry, isDark);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leaderboardTile(
    BuildContext context,
    LeaderboardEntry entry,
    bool isDark,
  ) {
    Widget rankWidget;
    if (entry.rank == 1) {
      rankWidget = const Icon(
        Icons.military_tech,
        color: Color(0xFFFFD700),
        size: 28,
      ); // Gold
    } else if (entry.rank == 2) {
      rankWidget = const Icon(
        Icons.military_tech,
        color: Color(0xFFC0C0C0),
        size: 28,
      ); // Silver
    } else if (entry.rank == 3) {
      rankWidget = const Icon(
        Icons.military_tech,
        color: Color(0xFFCD7F32),
        size: 28,
      ); // Bronze
    } else {
      rankWidget = Text(
        '#${entry.rank}',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: isDark
              ? AppleTokens.darkTextSecondary
              : AppleTokens.secondaryText,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space12),
      child: AppleCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppleTokens.space20,
          vertical: AppleTokens.space16,
        ),
        child: Row(
          children: [
            SizedBox(width: 36, child: Center(child: rankWidget)),
            const SizedBox(width: AppleTokens.space16),

            CircleAvatar(
              radius: 18,
              backgroundColor: isDark
                  ? AppleTokens.darkSurfaceElevated
                  : AppleTokens.lightNeutral,
              child: Text(
                entry.studentName.isNotEmpty
                    ? entry.studentName[0].toUpperCase()
                    : 'S',
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: AppleTokens.space16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.studentName,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '${entry.branch} • ${entry.quizzesTaken} Challenges • ${entry.accuracy}% Accuracy',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${entry.score} pts',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    color: isDark
                        ? AppleTokens.secondaryBlue
                        : AppleTokens.primaryBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
