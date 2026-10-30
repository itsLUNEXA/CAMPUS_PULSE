import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import '../widgets/copy_button.dart';

class QuizResultsScreen extends StatelessWidget {
  final QuizResultSummary result;
  final VoidCallback onRetake;
  final VoidCallback onViewLeaderboard;
  final VoidCallback onDone;

  const QuizResultsScreen({
    super.key,
    required this.result,
    required this.onRetake,
    required this.onViewLeaderboard,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isPassed = result.percentage >= 60.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 780),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Hero Card
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space32),
                child: Column(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color:
                            (isPassed
                                    ? AppleTokens.success
                                    : AppleTokens.warning)
                                .withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isPassed
                            ? Icons.emoji_events_rounded
                            : Icons.replay_rounded,
                        color: isPassed
                            ? AppleTokens.success
                            : AppleTokens.warning,
                        size: 36,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space16),

                    Text(
                      isPassed ? 'Challenge Completed!' : 'Keep Practicing!',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: AppleTokens.space4),
                    Text(
                      '${result.subject} Academic Challenge',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppleTokens.secondaryBlue
                            : AppleTokens.primaryBlue,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space24),

                    // Metrics Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _metricColumn(
                          context,
                          'Final Score',
                          '${result.score} / ${result.totalQuestions}',
                        ),
                        _metricColumn(
                          context,
                          'Accuracy',
                          '${result.percentage.toStringAsFixed(1)}%',
                        ),
                        _metricColumn(
                          context,
                          'Time Taken',
                          '${result.durationSeconds}s',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppleTokens.space32),

                    Wrap(
                      spacing: AppleTokens.space16,
                      runSpacing: AppleTokens.space12,
                      alignment: WrapAlignment.center,
                      children: [
                        AppleButton(
                          label: 'Retake Challenge',
                          variant: AppleButtonVariant.secondary,
                          icon: Icons.refresh,
                          height: 40,
                          onPressed: onRetake,
                        ),
                        AppleButton(
                          label: 'View Campus Leaderboard',
                          icon: Icons.leaderboard_rounded,
                          height: 40,
                          onPressed: onViewLeaderboard,
                        ),
                        CopyButton(
                          textToCopy:
                              'I scored ${result.score}/${result.totalQuestions} (${result.percentage.toStringAsFixed(1)}%) in the Campus Pulse ${result.subject} Quiz!',
                          label: 'Share Score',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppleTokens.space32),

              // Detailed Question Review Breakdown
              Text(
                'Authoritative Answer Key & Explanations',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: AppleTokens.space16),

              ...List.generate(result.items.length, (idx) {
                final item = result.items[idx];
                return _reviewCard(context, item, idx + 1, isDark);
              }),

              const SizedBox(height: AppleTokens.space24),

              Center(
                child: AppleButton(
                  label: 'Done',
                  variant: AppleButtonVariant.subtle,
                  height: 40,
                  onPressed: onDone,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _metricColumn(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _reviewCard(
    BuildContext context,
    QuizResultItem item,
    int questionNumber,
    bool isDark,
  ) {
    final statusColor = item.isCorrect
        ? AppleTokens.success
        : AppleTokens.error;

    return Container(
      margin: const EdgeInsets.only(bottom: AppleTokens.space16),
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      item.isCorrect ? Icons.check : Icons.close,
                      color: statusColor,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(width: AppleTokens.space12),
                Text(
                  'Question $questionNumber',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                Text(
                  item.isCorrect ? 'Correct (+1)' : 'Incorrect (0)',
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppleTokens.space12),

            Text(
              item.question,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppleTokens.space16),

            // Options feedback
            ...List.generate(item.options.length, (optIdx) {
              final optText = item.options[optIdx];
              final isUserChoice = item.selectedOptionIndex == optIdx;
              final isCorrectChoice = item.correctOptionIndex == optIdx;

              Color bg = Colors.transparent;
              Color border = isDark
                  ? AppleTokens.darkBorder
                  : AppleTokens.lightBorder;
              Color text = isDark
                  ? AppleTokens.darkTextPrimary
                  : AppleTokens.primaryText;

              if (isCorrectChoice) {
                bg = AppleTokens.success.withValues(alpha: 0.1);
                border = AppleTokens.success;
                text = AppleTokens.success;
              } else if (isUserChoice && !item.isCorrect) {
                bg = AppleTokens.error.withValues(alpha: 0.1);
                border = AppleTokens.error;
                text = AppleTokens.error;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 6),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: bg,
                  borderRadius: BorderRadius.circular(AppleTokens.radius8),
                  border: Border.all(color: border),
                ),
                child: Row(
                  children: [
                    Text(
                      '${String.fromCharCode(65 + optIdx)}. ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: text,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        optText,
                        style: TextStyle(
                          color: text,
                          fontWeight: (isCorrectChoice || isUserChoice)
                              ? FontWeight.w600
                              : FontWeight.w400,
                        ),
                      ),
                    ),
                    if (isCorrectChoice)
                      const Text(
                        '(Correct Answer)',
                        style: TextStyle(
                          color: AppleTokens.success,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    else if (isUserChoice)
                      const Text(
                        '(Your Answer)',
                        style: TextStyle(
                          color: AppleTokens.error,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
              );
            }),
            const SizedBox(height: AppleTokens.space12),

            // Server-Provided Authoritative Explanation
            Container(
              padding: const EdgeInsets.all(AppleTokens.space12),
              decoration: BoxDecoration(
                color:
                    (isDark
                            ? AppleTokens.darkSurfaceElevated
                            : AppleTokens.lightNeutral)
                        .withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppleTokens.radius8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    size: 16,
                    color: AppleTokens.primaryBlue,
                  ),
                  const SizedBox(width: AppleTokens.space8),
                  Expanded(
                    child: Text(
                      'Explanation: ${item.explanation}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
