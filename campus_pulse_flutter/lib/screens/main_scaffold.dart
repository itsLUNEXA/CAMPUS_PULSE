import 'package:flutter/material.dart';
import '../models/navigation_tab.dart';
import '../services/auth_state.dart';
import '../theme/app_theme.dart';
import 'home/home_feed_page.dart';
import 'study/study_tab_page.dart';
import 'quiz/quiz_page.dart';
import 'leaderboard/leaderboard_page.dart';

class MainScaffold extends StatefulWidget {
  final VoidCallback onLogout;

  const MainScaffold({super.key, required this.onLogout});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  NavTab _currentTab = NavTab.feed;

  void _switchTab(NavTab tab) {
    setState(() => _currentTab = tab);
  }

  @override
  Widget build(BuildContext context) {
    final currentStudent = AuthState.instance.currentStudent;

    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppTheme.surfaceDark,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppTheme.borderDark)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppTheme.primary,
                      child: Text(
                        currentStudent != null && currentStudent.name.isNotEmpty
                            ? currentStudent.name[0].toUpperCase()
                            : 'C',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      currentStudent?.name ?? 'Campus Student',
                      style: const TextStyle(
                        color: AppTheme.textPrimary,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      currentStudent?.email ?? 'student@campus.edu',
                      style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.bgDark,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${currentStudent?.branch ?? "Engineering"} • Year ${currentStudent?.year ?? 1}',
                        style: const TextStyle(color: AppTheme.accent, fontSize: 11, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_work_outlined, color: AppTheme.textSecondary),
                title: const Text('Hostel Area', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
                subtitle: Text(currentStudent?.hostelArea ?? 'Campus Resident', style: const TextStyle(color: AppTheme.textMuted, fontSize: 12)),
              ),
              ListTile(
                leading: const Icon(Icons.tag_rounded, color: AppTheme.textSecondary),
                title: const Text('Interests', style: TextStyle(color: AppTheme.textPrimary, fontSize: 14)),
                subtitle: Text(
                  currentStudent?.interests.join(', ') ?? 'DSA, AI, DBMS',
                  style: const TextStyle(color: AppTheme.textMuted, fontSize: 12),
                ),
              ),
              const Spacer(),
              const Divider(color: AppTheme.borderDark),
              ListTile(
                leading: const Icon(Icons.logout_rounded, color: Color(0xFFEF4444)),
                title: const Text(
                  'Log Out',
                  style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  AuthState.instance.logout();
                  widget.onLogout();
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentTab.index,
        children: [
          const HomeFeedPage(),
          const StudyTabPage(),
          QuizPage(
            onNavigateToLeaderboard: () => _switchTab(NavTab.leaderboard),
          ),
          const LeaderboardPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.borderDark, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentTab.index,
          onTap: (index) => _switchTab(NavTab.values[index]),
          items: NavTab.values.map((tab) {
            return BottomNavigationBarItem(
              icon: Icon(tab.icon),
              label: tab.title,
            );
          }).toList(),
        ),
      ),
    );
  }
}
