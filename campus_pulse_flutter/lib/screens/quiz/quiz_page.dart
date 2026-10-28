import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../services/auth_state.dart';
import '../../theme/app_theme.dart';
import '../../widgets/state_views.dart';
import 'quiz_result_dialog.dart';

class QuizPage extends StatefulWidget {
  final VoidCallback onNavigateToLeaderboard;

  const QuizPage({super.key, required this.onNavigateToLeaderboard});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<String> _subjects = ['DBMS', 'OS', 'DSA'];
  String _selectedSubject = 'DBMS';

  List<QuizQuestion> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  bool _isLoading = false;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    setState(() {
      _isLoading = true;
      _currentIndex = 0;
      _score = 0;
    });

    final questions = await ClientService.instance.getQuestions(_selectedSubject);

    if (mounted) {
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    }
  }

  void _onOptionSelected(int optionIndex) async {
    final currentQuestion = _questions[_currentIndex];
    final isCorrect = optionIndex == currentQuestion.correctIndex;
    if (isCorrect) {
      _score += 1;
    }

    if (_currentIndex < _questions.length - 1) {
      setState(() {
        _currentIndex += 1;
      });
    } else {
      // Completed all 5 questions
      await _submitFinalScore();
    }
  }

  Future<void> _submitFinalScore() async {
    setState(() => _isSubmitting = true);

    final currentStudent = AuthState.instance.currentStudent;
    final studentId = currentStudent?.id ?? 1;

    try {
      await ClientService.instance.submitScore(
        studentId,
        _selectedSubject,
        _score,
      );
    } catch (_) {}

    if (!mounted) return;

    setState(() => _isSubmitting = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => QuizResultDialog(
        subject: _selectedSubject,
        score: _score,
        totalQuestions: _questions.length,
        onViewLeaderboard: widget.onNavigateToLeaderboard,
        onRetake: _fetchQuestions,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Skill Challenge'),
      ),
      body: Column(
        children: [
          // Subject Selector Chips
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppTheme.surfaceDark,
              border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
            ),
            child: Row(
              children: [
                const Text(
                  'Select Subject: ',
                  style: TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: _subjects.map((sub) {
                        final isSelected = _selectedSubject == sub;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(sub),
                            selected: isSelected,
                            selectedColor: AppTheme.primary,
                            backgroundColor: AppTheme.cardDark,
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : AppTheme.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                            onSelected: (_) {
                              if (_selectedSubject != sub) {
                                setState(() => _selectedSubject = sub);
                                _fetchQuestions();
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Question Card
          Expanded(
            child: _isLoading
                ? const LoadingView(message: 'Loading quiz questions...')
                : _questions.isEmpty
                    ? EmptyStateView(
                        icon: Icons.help_outline_rounded,
                        title: 'No Questions Found',
                        subtitle: 'No quiz questions available for $_selectedSubject.',
                        actionLabel: 'Refresh',
                        onAction: _fetchQuestions,
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Progress bar & Step Counter
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Question ${_currentIndex + 1} of ${_questions.length}',
                                  style: const TextStyle(
                                    color: AppTheme.accent,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppTheme.surfaceDark,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    'Score: $_score',
                                    style: const TextStyle(
                                      color: AppTheme.success,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (_currentIndex + 1) / _questions.length,
                                minHeight: 6,
                                backgroundColor: AppTheme.surfaceDark,
                                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.primary),
                              ),
                            ),
                            const SizedBox(height: 28),

                            // Question Text
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: AppTheme.cardDark,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppTheme.borderDark),
                              ),
                              child: Text(
                                _questions[_currentIndex].question,
                                style: const TextStyle(
                                  color: AppTheme.textPrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  height: 1.45,
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Options List
                            ..._questions[_currentIndex].options.asMap().entries.map((entry) {
                              final optionIndex = entry.key;
                              final optionText = entry.value;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InkWell(
                                  onTap: _isSubmitting ? null : () => _onOptionSelected(optionIndex),
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                    decoration: BoxDecoration(
                                      color: AppTheme.surfaceDark,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: AppTheme.borderDark),
                                    ),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 14,
                                          backgroundColor: AppTheme.bgDark,
                                          child: Text(
                                            String.fromCharCode(65 + optionIndex),
                                            style: const TextStyle(
                                              color: AppTheme.textSecondary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 14),
                                        Expanded(
                                          child: Text(
                                            optionText,
                                            style: const TextStyle(
                                              color: AppTheme.textPrimary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.chevron_right_rounded,
                                          color: AppTheme.textMuted,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
