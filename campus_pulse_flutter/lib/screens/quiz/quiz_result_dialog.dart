import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class QuizResultDialog extends StatelessWidget {
  final String subject;
  final int score;
  final int totalQuestions;
  final VoidCallback onViewLeaderboard;
  final VoidCallback onRetake;

  const QuizResultDialog({
    super.key,
    required this.subject,
    required this.score,
    required this.totalQuestions,
    required this.onViewLeaderboard,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    final percentage = (score / totalQuestions) * 100;

    return Dialog(
      backgroundColor: AppTheme.surfaceDark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: percentage >= 60
                    ? AppTheme.success.withOpacity(0.15)
                    : AppTheme.warning.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                percentage >= 60 ? Icons.military_tech_rounded : Icons.psychology_rounded,
                size: 48,
                color: percentage >= 60 ? AppTheme.success : AppTheme.warning,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Quiz Completed!',
              style: TextStyle(
                color: AppTheme.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Subject: $subject',
              style: const TextStyle(color: AppTheme.accent, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: AppTheme.bgDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppTheme.borderDark),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$score',
                    style: const TextStyle(
                      color: AppTheme.primary,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    ' / $totalQuestions',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your score has been submitted to the Live Leaderboard broadcast!',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  onViewLeaderboard();
                },
                icon: const Icon(Icons.emoji_events_rounded, size: 18),
                label: const Text('View Live Leaderboard'),
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onRetake();
              },
              child: const Text('Play Another Quiz', style: TextStyle(color: AppTheme.textSecondary)),
            ),
          ],
        ),
      ),
    );
  }
}
