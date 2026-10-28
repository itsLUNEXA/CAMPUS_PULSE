import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../theme/app_theme.dart';

class LeaderboardCard extends StatelessWidget {
  final int rank;
  final LeaderboardEntry entry;

  const LeaderboardCard({
    super.key,
    required this.rank,
    required this.entry,
  });

  Widget _buildRankBadge() {
    if (rank == 1) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFFBBF24),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Icon(Icons.emoji_events, color: Colors.black, size: 18),
      );
    } else if (rank == 2) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFF94A3B8),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text('2', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      );
    } else if (rank == 3) {
      return Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Color(0xFFD97706),
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: const Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      );
    }
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      child: Text(
        '#$rank',
        style: const TextStyle(color: AppTheme.textMuted, fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            _buildRankBadge(),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.studentName,
                    style: const TextStyle(
                      color: AppTheme.textPrimary,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${entry.branch} • Year ${entry.year}',
                    style: const TextStyle(
                      color: AppTheme.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: AppTheme.surfaceDark,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                entry.subject,
                style: const TextStyle(
                  color: AppTheme.accent,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${entry.score}/5',
                  style: const TextStyle(
                    color: AppTheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Text(
                  'Score',
                  style: TextStyle(
                    color: AppTheme.textMuted,
                    fontSize: 10,
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
