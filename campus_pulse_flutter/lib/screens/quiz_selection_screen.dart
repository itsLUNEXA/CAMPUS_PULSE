import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class QuizSelectionScreen extends StatefulWidget {
  final AuthState authState;
  final Function(String subject) onStartQuiz;
  final VoidCallback onViewLeaderboard;

  const QuizSelectionScreen({
    super.key,
    required this.authState,
    required this.onStartQuiz,
    required this.onViewLeaderboard,
  });

  @override
  State<QuizSelectionScreen> createState() => _QuizSelectionScreenState();
}

class _QuizSelectionScreenState extends State<QuizSelectionScreen> {
  final Map<String, int> _bestScores = {};
  Set<String> _recommendedSubjects = {};
  bool _isLoading = true;

  final List<Map<String, dynamic>> _quizSubjects = [
    {
      'title': 'DBMS',
      'subtitle': 'Relational Database Management Systems',
      'description':
          'Normal forms (1NF-BCNF), ACID properties, B+ Tree indexing, and PostgreSQL transaction isolation levels.',
      'icon': Icons.storage_rounded,
      'color': AppleTokens.primaryBlue,
      'duration': '3 mins',
      'questions': '5 questions',
    },
    {
      'title': 'Operating Systems',
      'subtitle': 'Concurrency, Memory & Process Scheduling',
      'description':
          'Process synchronization, Semaphores, Coffman deadlock conditions, SJF scheduling, and Belady\'s paging anomaly.',
      'icon': Icons.memory_rounded,
      'color': AppleTokens.warning,
      'duration': '3 mins',
      'questions': '5 questions',
    },
    {
      'title': 'Data Structures and Algorithms',
      'subtitle': 'Asymptotic Complexity & Tree Structures',
      'description':
          'QuickSort worst-case analysis, AVL Tree balance factors, Dijkstra algorithm mechanics, and amortized array bounds.',
      'icon': Icons.account_tree_rounded,
      'color': AppleTokens.success,
      'duration': '3 mins',
      'questions': '5 questions',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadPastScores();
  }

  Future<void> _loadPastScores() async {
    if (!widget.authState.isAuthenticated) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final attempts = await client.quiz.getMyAttempts();
      for (final att in attempts) {
        final currentBest = _bestScores[att.subject] ?? 0;
        if (att.score > currentBest) {
          _bestScores[att.subject] = att.score;
        }
      }
      try {
        final recs = await client.quiz.getRecommendedQuizSubjects();
        _recommendedSubjects = recs.toSet();
      } catch (_) {}
      if (mounted) setState(() => _isLoading = false);
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
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
          constraints: const BoxConstraints(maxWidth: 1040),
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
                        'Academic Timed Quizzes',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppleTokens.space4),
                      Text(
                        'Test your foundational engineering knowledge with server-evaluated challenges.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  AppleButton(
                    label: 'Campus Leaderboard',
                    variant: AppleButtonVariant.secondary,
                    icon: Icons.leaderboard_rounded,
                    onPressed: widget.onViewLeaderboard,
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space32),

              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                // Subject Cards List
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _quizSubjects.length,
                  itemBuilder: (context, index) {
                    final subj = _quizSubjects[index];
                    final title = subj['title'] as String;
                    final color = subj['color'] as Color;
                    final bestScore = _bestScores[title];

                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: AppleTokens.space20,
                      ),
                      child: AppleCard(
                        padding: const EdgeInsets.all(AppleTokens.space28),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 54,
                              height: 54,
                              decoration: BoxDecoration(
                                color: color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(
                                  AppleTokens.radius12,
                                ),
                              ),
                              child: Icon(
                                subj['icon'] as IconData,
                                color: color,
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: AppleTokens.space20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                      const SizedBox(
                                        width: AppleTokens.space12,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? AppleTokens.darkSurfaceElevated
                                              : AppleTokens.lightNeutral,
                                          borderRadius: BorderRadius.circular(
                                            AppleTokens.radius999,
                                          ),
                                        ),
                                        child: Text(
                                          subj['questions'] as String,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? AppleTokens.darkSurfaceElevated
                                              : AppleTokens.lightNeutral,
                                          borderRadius: BorderRadius.circular(
                                            AppleTokens.radius999,
                                          ),
                                        ),
                                        child: Text(
                                          subj['duration'] as String,
                                          style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      if (_recommendedSubjects.contains(
                                        title,
                                      )) ...[
                                        const SizedBox(width: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppleTokens.primaryBlue
                                                .withValues(alpha: 0.15),
                                            borderRadius: BorderRadius.circular(
                                              AppleTokens.radius999,
                                            ),
                                          ),
                                          child: const Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 11,
                                                color: AppleTokens.primaryBlue,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                'Recommended',
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      AppleTokens.primaryBlue,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: AppleTokens.space4),
                                  Text(
                                    subj['subtitle'] as String,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: isDark
                                          ? AppleTokens.secondaryBlue
                                          : AppleTokens.primaryBlue,
                                    ),
                                  ),
                                  const SizedBox(height: AppleTokens.space8),
                                  Text(
                                    subj['description'] as String,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: isDark
                                              ? AppleTokens.darkTextSecondary
                                              : AppleTokens.secondaryText,
                                          height: 1.5,
                                        ),
                                  ),
                                  const SizedBox(height: AppleTokens.space16),

                                  Row(
                                    children: [
                                      if (bestScore != null) ...[
                                        const Icon(
                                          Icons.star_rounded,
                                          size: 16,
                                          color: AppleTokens.warning,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Your Best: $bestScore pts',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: AppleTokens.space16,
                                        ),
                                      ],
                                      const Spacer(),
                                      AppleButton(
                                        label: 'Start Challenge',
                                        icon: Icons.play_arrow_rounded,
                                        height: 38,
                                        onPressed: () =>
                                            widget.onStartQuiz(title),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
