import 'package:flutter/material.dart';

enum NavTab { feed, study, quiz, leaderboard }

extension NavTabExtension on NavTab {
  String get title {
    switch (this) {
      case NavTab.feed:
        return 'Feed';
      case NavTab.study:
        return 'Study';
      case NavTab.quiz:
        return 'Quiz';
      case NavTab.leaderboard:
        return 'Leaderboard';
    }
  }

  IconData get icon {
    switch (this) {
      case NavTab.feed:
        return Icons.local_fire_department_rounded;
      case NavTab.study:
        return Icons.school_rounded;
      case NavTab.quiz:
        return Icons.psychology_rounded;
      case NavTab.leaderboard:
        return Icons.emoji_events_rounded;
    }
  }
}
