import 'dart:async';
import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/leaderboard_card.dart';
import '../../widgets/state_views.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  final List<String> _filters = ['All', 'DBMS', 'OS', 'DSA'];
  String _selectedFilter = 'All';

  List<LeaderboardEntry> _entries = [];
  bool _isLoading = true;
  StreamSubscription<LeaderboardEntry>? _liveScoreSub;

  @override
  void initState() {
    super.initState();
    _loadLeaderboard();

    // Listen to real-time WebSocket score broadcasts
    _liveScoreSub = ClientService.instance.leaderboardUpdates.listen((newEntry) {
      if (mounted) {
        setState(() {
          if (_selectedFilter == 'All' ||
              _selectedFilter.toLowerCase() == newEntry.subject.toLowerCase()) {
            _entries.insert(0, newEntry);
            _entries.sort((a, b) => b.score.compareTo(a.score));
          }
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('⚡ Live Update: ${newEntry.studentName} scored ${newEntry.score}/5 in ${newEntry.subject}!'),
            duration: const Duration(seconds: 3),
            backgroundColor: AppTheme.secondary,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _liveScoreSub?.cancel();
    super.dispose();
  }

  Future<void> _loadLeaderboard() async {
    setState(() => _isLoading = true);
    final filter = _selectedFilter == 'All' ? null : _selectedFilter;
    final results = await ClientService.instance.getLeaderboard(subject: filter);
    if (mounted) {
      setState(() {
        _entries = results;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.emoji_events_rounded, color: Color(0xFFFBBF24), size: 24),
            const SizedBox(width: 10),
            const Text('Campus Leaderboard'),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppTheme.success.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppTheme.success.withOpacity(0.3)),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(radius: 3, backgroundColor: AppTheme.success),
                SizedBox(width: 5),
                Text('LIVE', style: TextStyle(color: AppTheme.success, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: AppTheme.textSecondary),
            onPressed: _loadLeaderboard,
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: _filters.map((filter) {
                return CategoryFilterChip(
                  label: filter,
                  isSelected: _selectedFilter == filter,
                  onSelected: () {
                    setState(() => _selectedFilter = filter);
                    _loadLeaderboard();
                  },
                );
              }).toList(),
            ),
          ),

          // Leaderboard List
          Expanded(
            child: _isLoading
                ? const LoadingView(message: 'Streaming real-time rankings...')
                : _entries.isEmpty
                    ? EmptyStateView(
                        icon: Icons.military_tech_outlined,
                        title: 'No Scores Recorded Yet',
                        subtitle: 'Be the first to take a quiz in $_selectedFilter and top the board!',
                      )
                    : RefreshIndicator(
                        color: AppTheme.primary,
                        backgroundColor: AppTheme.surfaceDark,
                        onRefresh: _loadLeaderboard,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          itemCount: _entries.length,
                          itemBuilder: (context, index) {
                            return LeaderboardCard(
                              rank: index + 1,
                              entry: _entries[index],
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
