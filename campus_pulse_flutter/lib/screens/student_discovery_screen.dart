import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import 'study_request_dialog.dart';

class StudentDiscoveryScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onViewRequests;

  const StudentDiscoveryScreen({
    super.key,
    required this.authState,
    required this.onViewRequests,
  });

  @override
  State<StudentDiscoveryScreen> createState() => _StudentDiscoveryScreenState();
}

class _StudentDiscoveryScreenState extends State<StudentDiscoveryScreen> {
  String _selectedSubject = 'All';
  String _selectedBranch = 'All';
  int _selectedYear = 0; // 0 = All

  final List<String> _subjects = [
    'All',
    'DSA',
    'DBMS',
    'Operating Systems',
    'AI',
    'Networks',
    'Web Development',
  ];
  final List<String> _branches = [
    'All',
    'CSE',
    'IT',
    'ECE',
    'Mechanical',
    'Civil',
  ];

  List<StudentProfile> _students = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    setState(() => _isLoading = true);
    try {
      final list = await client.student.discoverStudents(
        subject: _selectedSubject != 'All' ? _selectedSubject : null,
        branch: _selectedBranch != 'All' ? _selectedBranch : null,
        academicYear: _selectedYear > 0 ? _selectedYear : null,
        limit: 30,
        offset: 0,
      );

      if (mounted) {
        setState(() {
          _students = list;
          _isLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _openRequestDialog(StudentProfile targetStudent) {
    if (!widget.authState.isAuthenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to send study requests.')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => StudyRequestDialog(
        targetStudent: targetStudent,
        onSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Study request sent to ${targetStudent.fullName}!'),
            ),
          );
        },
      ),
    );
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
              // Header Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Smart Study Buddy Finder',
                        style: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: AppleTokens.space4),
                      Text(
                        'Find peer classmates for collaborative exam preparation and group projects.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppleTokens.darkTextSecondary
                              : AppleTokens.secondaryText,
                        ),
                      ),
                    ],
                  ),
                  AppleButton(
                    label: 'My Study Requests',
                    variant: AppleButtonVariant.secondary,
                    icon: Icons.mail_outline_rounded,
                    onPressed: widget.onViewRequests,
                  ),
                ],
              ),
              const SizedBox(height: AppleTokens.space24),

              // Filter Controls Card
              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Filter by Shared Academic Interests:',
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(height: AppleTokens.space12),

                    // Subject Chips
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
                                  _loadStudents();
                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space16),

                    // Branch & Year Row
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: _selectedBranch,
                            decoration: const InputDecoration(
                              labelText: 'Branch',
                            ),
                            items: _branches
                                .map(
                                  (b) => DropdownMenuItem(
                                    value: b,
                                    child: Text(b),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => _selectedBranch = v);
                                _loadStudents();
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: AppleTokens.space16),
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            initialValue: _selectedYear,
                            decoration: const InputDecoration(
                              labelText: 'Academic Year',
                            ),
                            items: [0, 1, 2, 3, 4]
                                .map(
                                  (y) => DropdownMenuItem(
                                    value: y,
                                    child: Text(
                                      y == 0 ? 'All Years' : 'Year $y',
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => _selectedYear = v);
                                _loadStudents();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppleTokens.space28),

              // Results Grid
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(48),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_students.isEmpty)
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space40),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.people_outline,
                          size: 48,
                          color: AppleTokens.secondaryText,
                        ),
                        const SizedBox(height: AppleTokens.space16),
                        Text(
                          'No Study Partners Match Current Filters',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppleTokens.space8),
                        const Text(
                          'Try selecting "All" subjects or branches to broaden your discovery.',
                        ),
                      ],
                    ),
                  ),
                )
              else
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 700;
                    final cardWidth = isWide
                        ? (constraints.maxWidth - AppleTokens.space16) / 2
                        : constraints.maxWidth;

                    return Wrap(
                      spacing: AppleTokens.space16,
                      runSpacing: AppleTokens.space16,
                      children: _students
                          .map(
                            (st) =>
                                _studentCard(context, st, cardWidth, isDark),
                          )
                          .toList(),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _studentCard(
    BuildContext context,
    StudentProfile student,
    double width,
    bool isDark,
  ) {
    final myInterests = widget.authState.currentProfile?.subjectInterests ?? [];
    final sharedCount = student.subjectInterests
        .where((s) => myInterests.contains(s))
        .length;
    final matchPercentage = sharedCount > 0
        ? (sharedCount * 33).clamp(35, 98)
        : 50;

    return SizedBox(
      width: width,
      child: AppleCard(
        padding: const EdgeInsets.all(AppleTokens.space24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: isDark
                      ? AppleTokens.secondaryBlue
                      : AppleTokens.primaryBlue,
                  child: Text(
                    student.fullName.isNotEmpty
                        ? student.fullName[0].toUpperCase()
                        : 'S',
                    style: TextStyle(
                      color: isDark ? AppleTokens.black : Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: AppleTokens.space16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.fullName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        '${student.branch} • Year ${student.academicYear} • ${student.hostelOrArea}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppleTokens.success.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                  ),
                  child: Text(
                    '$matchPercentage% Match',
                    style: const TextStyle(
                      color: AppleTokens.success,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppleTokens.space12),

            if (student.bio != null && student.bio!.isNotEmpty) ...[
              Text(
                student.bio!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDark
                      ? AppleTokens.darkTextSecondary
                      : AppleTokens.secondaryText,
                ),
              ),
              const SizedBox(height: AppleTokens.space12),
            ],

            Text(
              'Subject Focus:',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isDark
                    ? AppleTokens.darkTextSecondary
                    : AppleTokens.secondaryText,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: student.subjectInterests.map((sub) {
                final isShared = myInterests.contains(sub);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: isShared
                        ? (isDark
                                  ? AppleTokens.secondaryBlue
                                  : AppleTokens.primaryBlue)
                              .withValues(alpha: 0.15)
                        : (isDark
                              ? AppleTokens.darkSurfaceElevated
                              : AppleTokens.lightNeutral),
                    borderRadius: BorderRadius.circular(AppleTokens.radius999),
                    border: isShared
                        ? Border.all(
                            color: isDark
                                ? AppleTokens.secondaryBlue
                                : AppleTokens.primaryBlue,
                            width: 1,
                          )
                        : null,
                  ),
                  child: Text(
                    sub,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: isShared ? FontWeight.w700 : FontWeight.w500,
                      color: isShared
                          ? (isDark
                                ? AppleTokens.secondaryBlue
                                : AppleTokens.primaryBlue)
                          : null,
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: AppleTokens.space20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AppleButton(
                  label: 'Connect & Study',
                  icon: Icons.send_rounded,
                  height: 36,
                  onPressed: () => _openRequestDialog(student),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
