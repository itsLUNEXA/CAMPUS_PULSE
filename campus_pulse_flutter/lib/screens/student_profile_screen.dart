import 'package:flutter/material.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class StudentProfileScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onBack;

  const StudentProfileScreen({
    super.key,
    required this.authState,
    required this.onBack,
  });

  @override
  State<StudentProfileScreen> createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _hostelCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  String _branch = 'CSE';
  int _year = 2;
  final Set<String> _subjects = {};
  final Set<String> _eventInterests = {};
  final Set<String> _quizSubjects = {};
  final Set<String> _quizTypes = {};

  final List<String> _branches = ['CSE', 'IT', 'ECE', 'Mechanical', 'Civil'];
  final List<String> _availableSubjects = [
    'DSA',
    'DBMS',
    'Operating Systems',
    'AI',
    'Networks',
    'Web Development',
  ];
  final List<String> _availableEventCategories = [
    'Tech',
    'Sports',
    'Cultural',
    'Workshop',
    'Hackathon',
  ];
  final List<String> _availableQuizSubjects = [
    'DBMS',
    'Operating Systems',
    'Data Structures and Algorithms',
    'AI',
    'Computer Networks',
    'Web Development',
  ];
  final List<String> _availableQuizTypes = [
    'Multiple Choice',
    'Code Analysis',
    'Scenario Based',
    'Conceptual',
  ];

  bool _isLoading = false;
  bool _isSuccess = false;

  @override
  void initState() {
    super.initState();
    final p = widget.authState.currentProfile;
    if (p != null) {
      _nameCtrl.text = p.fullName;
      _hostelCtrl.text = p.hostelOrArea;
      _bioCtrl.text = p.bio ?? '';
      _branch = p.branch;
      _year = p.academicYear;
      _subjects.addAll(p.subjectInterests);
      if (p.eventInterests != null) _eventInterests.addAll(p.eventInterests!);
      if (p.preferredQuizSubjects != null) {
        _quizSubjects.addAll(p.preferredQuizSubjects!);
      }
      if (p.preferredQuizTypes != null)
        _quizTypes.addAll(p.preferredQuizTypes!);
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _hostelCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _isSuccess = false;
    });

    final success = await widget.authState.updateProfile(
      fullName: _nameCtrl.text.trim(),
      branch: _branch,
      academicYear: _year,
      hostelOrArea: _hostelCtrl.text.trim(),
      bio: _bioCtrl.text.trim(),
      subjectInterests: _subjects.toList(),
      eventInterests: _eventInterests.toList(),
      preferredQuizSubjects: _quizSubjects.toList(),
      preferredQuizTypes: _quizTypes.toList(),
    );

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isSuccess = success;
      });
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 640),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppleButton(
                label: 'Back',
                variant: AppleButtonVariant.subtle,
                icon: Icons.arrow_back,
                height: 38,
                onPressed: widget.onBack,
              ),
              const SizedBox(height: AppleTokens.space16),

              Text(
                'Student Profile',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space8),
              const Text(
                'Manage your campus profile, branch details, and study matching preferences.',
              ),
              const SizedBox(height: AppleTokens.space24),

              if (_isSuccess) ...[
                Container(
                  padding: const EdgeInsets.all(AppleTokens.space12),
                  decoration: BoxDecoration(
                    color: AppleTokens.success.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppleTokens.radius8),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.check_circle,
                        color: AppleTokens.success,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Profile saved and synced with campus database.',
                        style: TextStyle(
                          color: AppleTokens.success,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppleTokens.space16),
              ],

              AppleCard(
                padding: const EdgeInsets.all(AppleTokens.space28),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Name cannot be empty'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      Row(
                        children: [
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              initialValue: _branch,
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
                                if (v != null) setState(() => _branch = v);
                              },
                            ),
                          ),
                          const SizedBox(width: AppleTokens.space16),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              initialValue: _year,
                              decoration: const InputDecoration(
                                labelText: 'Academic Year',
                              ),
                              items: [1, 2, 3, 4]
                                  .map(
                                    (y) => DropdownMenuItem(
                                      value: y,
                                      child: Text('Year $y'),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (v) {
                                if (v != null) setState(() => _year = v);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      TextFormField(
                        controller: _hostelCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Hostel or Campus Area',
                          hintText: 'e.g. Kaveri Hostel, Block B',
                        ),
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      TextFormField(
                        controller: _bioCtrl,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'Bio & Academic Goals',
                        ),
                      ),
                      const SizedBox(height: AppleTokens.space20),

                      Text(
                        'Academic Interests (Used for study partner matching):',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: AppleTokens.space8),
                      Wrap(
                        spacing: AppleTokens.space8,
                        runSpacing: AppleTokens.space8,
                        children: _availableSubjects.map((sub) {
                          final isSelected = _subjects.contains(sub);
                          return FilterChip(
                            label: Text(sub),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _subjects.add(sub);
                                } else {
                                  _subjects.remove(sub);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppleTokens.space20),

                      Text(
                        'Event Category Preferences (Tailors event recommendations):',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: AppleTokens.space8),
                      Wrap(
                        spacing: AppleTokens.space8,
                        runSpacing: AppleTokens.space8,
                        children: _availableEventCategories.map((cat) {
                          final isSelected = _eventInterests.contains(cat);
                          return FilterChip(
                            label: Text(cat),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _eventInterests.add(cat);
                                } else {
                                  _eventInterests.remove(cat);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppleTokens.space20),

                      Text(
                        'Preferred Quiz Subjects:',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: AppleTokens.space8),
                      Wrap(
                        spacing: AppleTokens.space8,
                        runSpacing: AppleTokens.space8,
                        children: _availableQuizSubjects.map((sub) {
                          final isSelected = _quizSubjects.contains(sub);
                          return FilterChip(
                            label: Text(sub),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _quizSubjects.add(sub);
                                } else {
                                  _quizSubjects.remove(sub);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppleTokens.space20),

                      Text(
                        'Preferred Quiz Question Types:',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: AppleTokens.space8),
                      Wrap(
                        spacing: AppleTokens.space8,
                        runSpacing: AppleTokens.space8,
                        children: _availableQuizTypes.map((qt) {
                          final isSelected = _quizTypes.contains(qt);
                          return FilterChip(
                            label: Text(qt),
                            selected: isSelected,
                            onSelected: (val) {
                              setState(() {
                                if (val) {
                                  _quizTypes.add(qt);
                                } else {
                                  _quizTypes.remove(qt);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppleTokens.space28),

                      AppleButton(
                        label: 'Save Profile Changes',
                        isLoading: _isLoading,
                        onPressed: _save,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
