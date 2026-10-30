import 'dart:async';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import '../widgets/confirmation_dialog.dart';

class QuizGameplayScreen extends StatefulWidget {
  final String subject;
  final AuthState authState;
  final Function(QuizResultSummary result) onFinished;
  final VoidCallback onCancel;

  const QuizGameplayScreen({
    super.key,
    required this.subject,
    required this.authState,
    required this.onFinished,
    required this.onCancel,
  });

  @override
  State<QuizGameplayScreen> createState() => _QuizGameplayScreenState();
}

class _QuizGameplayScreenState extends State<QuizGameplayScreen> {
  List<QuizQuestionView> _questions = [];
  final Map<int, int> _selectedAnswers =
      {}; // questionId -> selectedOptionIndex

  int _currentIndex = 0;
  bool _isLoading = true;
  bool _isSubmitting = false;
  String? _errorMessage;

  // Timer
  int _secondsRemaining = 180; // 3 minutes total
  Timer? _countdownTimer;
  final DateTime _startTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.quiz.getQuestionsForSubject(
        widget.subject,
        limit: 10,
      );
      if (mounted) {
        setState(() {
          _questions = list;
          _isLoading = false;
        });
        _startTimer();
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Could not load quiz questions from server.';
        });
      }
    }
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
        _submitQuiz(isTimeUp: true);
      }
    });
  }

  void _selectOption(int questionId, int optionIndex) {
    if (_isSubmitting) return;
    setState(() {
      _selectedAnswers[questionId] = optionIndex;
    });
  }

  void _submitQuiz({bool isTimeUp = false}) async {
    if (_isSubmitting) return; // Prevent double submission!

    if (!isTimeUp) {
      final unansweredCount = _questions.length - _selectedAnswers.length;
      if (unansweredCount > 0) {
        final confirmed = await ConfirmationDialog.show(
          context,
          title: 'Submit Incomplete Quiz?',
          message:
              'You still have $unansweredCount unanswered question(s). Are you sure you want to finalize your attempt?',
          confirmLabel: 'Submit Now',
        );
        if (!confirmed) return;
      }
    }

    _countdownTimer?.cancel();
    setState(() => _isSubmitting = true);

    try {
      final duration = DateTime.now().difference(_startTime).inSeconds;
      final answerList = _questions.map((q) {
        final chosen = _selectedAnswers[q.id] ?? -1;
        return QuizAnswerSubmission(
          questionId: q.id,
          selectedOptionIndex: chosen,
        );
      }).toList();

      final submission = QuizSubmission(
        subject: widget.subject,
        answers: answerList,
        durationSeconds: duration,
      );

      final result = await client.quiz.submitQuiz(submission);

      if (mounted) {
        widget.onFinished(result);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
          _errorMessage =
              'Could not evaluate submission on server. Please try submitting again.';
        });
      }
    }
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (_isLoading) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_errorMessage != null && _questions.isEmpty) {
      return Center(
        child: AppleCard(
          padding: const EdgeInsets.all(AppleTokens.space32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline,
                size: 40,
                color: AppleTokens.error,
              ),
              const SizedBox(height: AppleTokens.space12),
              Text(_errorMessage!),
              const SizedBox(height: AppleTokens.space16),
              AppleButton(label: 'Retry', onPressed: _loadQuestions),
            ],
          ),
        ),
      );
    }

    final currentQuestion = _questions[_currentIndex];
    final selectedOption = _selectedAnswers[currentQuestion.id];
    final progress = (_currentIndex + 1) / _questions.length;
    final isLast = _currentIndex == _questions.length - 1;

    final timerColor = _secondsRemaining < 30
        ? AppleTokens.error
        : (isDark ? AppleTokens.secondaryBlue : AppleTokens.primaryBlue);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Subject, Question Counter and Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppleButton(
                    label: 'Exit',
                    variant: AppleButtonVariant.subtle,
                    icon: Icons.close_rounded,
                    height: 36,
                    onPressed: () async {
                      final confirmed = await ConfirmationDialog.show(
                        context,
                        title: 'Leave Challenge?',
                        message:
                            'Your progress in this quiz will be discarded.',
                        confirmLabel: 'Leave Quiz',
                        isDestructive: true,
                      );
                      if (confirmed && mounted) widget.onCancel();
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: timerColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(
                        AppleTokens.radius999,
                      ),
                      border: Border.all(
                        color: timerColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined, size: 16, color: timerColor),
                        const SizedBox(width: 6),
                        Text(
                          _formatTimer(_secondsRemaining),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: timerColor,
                            fontFeatures: const [FontFeature.tabularFigures()],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space16),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(AppleTokens.radius999),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: isDark
                      ? AppleTokens.darkBorder
                      : AppleTokens.lightNeutral,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    isDark
                        ? AppleTokens.secondaryBlue
                        : AppleTokens.primaryBlue,
                  ),
                ),
              ),
              const SizedBox(height: AppleTokens.space12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Question ${_currentIndex + 1} of ${_questions.length}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: isDark
                          ? AppleTokens.darkTextSecondary
                          : AppleTokens.secondaryText,
                    ),
                  ),
                  Text(
                    widget.subject,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark
                          ? AppleTokens.secondaryBlue
                          : AppleTokens.primaryBlue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space24),

              // Question Card
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentQuestion.question,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space24),

                    // Options List
                    ...List.generate(currentQuestion.options.length, (optIdx) {
                      final optionText = currentQuestion.options[optIdx];
                      final isSelected = selectedOption == optIdx;

                      Color optBorder = isDark
                          ? AppleTokens.darkBorder
                          : AppleTokens.lightBorder;
                      Color optBg = isDark
                          ? AppleTokens.darkSurfaceElevated
                          : AppleTokens.lightSurfaceElevated;
                      Color optText = isDark
                          ? AppleTokens.darkTextPrimary
                          : AppleTokens.primaryText;

                      if (isSelected) {
                        optBorder = isDark
                            ? AppleTokens.secondaryBlue
                            : AppleTokens.primaryBlue;
                        optBg =
                            (isDark
                                    ? AppleTokens.secondaryBlue
                                    : AppleTokens.primaryBlue)
                                .withValues(alpha: 0.12);
                        optText = isDark
                            ? AppleTokens.secondaryBlue
                            : AppleTokens.primaryBlue;
                      }

                      return Container(
                        margin: const EdgeInsets.only(
                          bottom: AppleTokens.space12,
                        ),
                        child: InkWell(
                          onTap: () =>
                              _selectOption(currentQuestion.id, optIdx),
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius12,
                          ),
                          child: AnimatedContainer(
                            duration: AppleTokens.duration160,
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppleTokens.space20,
                              vertical: AppleTokens.space16,
                            ),
                            decoration: BoxDecoration(
                              color: optBg,
                              borderRadius: BorderRadius.circular(
                                AppleTokens.radius12,
                              ),
                              border: Border.all(
                                color: optBorder,
                                width: isSelected ? 2.0 : 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 26,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? (isDark
                                              ? AppleTokens.secondaryBlue
                                              : AppleTokens.primaryBlue)
                                        : Colors.transparent,
                                    border: Border.all(
                                      color: isSelected
                                          ? (isDark
                                                ? AppleTokens.secondaryBlue
                                                : AppleTokens.primaryBlue)
                                          : (isDark
                                                ? AppleTokens.darkBorder
                                                : AppleTokens.lightBorder),
                                      width: 1.5,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(
                                        65 + optIdx,
                                      ), // A, B, C, D
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? (isDark
                                                  ? AppleTokens.black
                                                  : Colors.white)
                                            : (isDark
                                                  ? AppleTokens
                                                        .darkTextSecondary
                                                  : AppleTokens.secondaryText),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: AppleTokens.space16),
                                Expanded(
                                  child: Text(
                                    optionText,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: optText,
                                    ),
                                  ),
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

              const SizedBox(height: AppleTokens.space24),

              // Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentIndex > 0)
                    AppleButton(
                      label: 'Previous Question',
                      variant: AppleButtonVariant.subtle,
                      icon: Icons.arrow_back,
                      onPressed: () => setState(() => _currentIndex--),
                    )
                  else
                    const SizedBox.shrink(),

                  if (!isLast)
                    AppleButton(
                      label: 'Next Question',
                      icon: Icons.arrow_forward,
                      onPressed: () => setState(() => _currentIndex++),
                    )
                  else
                    AppleButton(
                      label: 'Submit Answers',
                      icon: Icons.check_circle_outline,
                      isLoading: _isSubmitting,
                      onPressed: () => _submitQuiz(),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTimer(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
