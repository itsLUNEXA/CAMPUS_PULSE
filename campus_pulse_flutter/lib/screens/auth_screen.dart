import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';
import '../widgets/password_text_field.dart';

class AuthScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onAuthenticated;

  const AuthScreen({
    super.key,
    required this.authState,
    required this.onAuthenticated,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  // Login Controllers
  final _loginFormKey = GlobalKey<FormState>();
  final _loginEmailCtrl = TextEditingController();
  final _loginPassCtrl = TextEditingController();

  // Registration Controllers
  final _regFormKey = GlobalKey<FormState>();
  final _regNameCtrl = TextEditingController();
  final _regEmailCtrl = TextEditingController();
  final _regPassCtrl = TextEditingController();
  final _regHostelCtrl = TextEditingController();
  final _regBioCtrl = TextEditingController();

  // Admin Quick Login Controllers
  final _adminFormKey = GlobalKey<FormState>();
  final _adminEmailCtrl = TextEditingController(text: 'admin@campuspulse.edu');
  final _adminPassCtrl = TextEditingController(
    text: 'AdminMasterPassword2026!',
  );

  String _selectedBranch = 'CSE';
  int _selectedYear = 2;
  final Set<String> _selectedSubjects = {'DSA', 'DBMS'};

  final List<String> _availableBranches = [
    'CSE',
    'IT',
    'ECE',
    'Mechanical',
    'Civil',
  ];
  final List<String> _availableSubjects = [
    'DSA',
    'DBMS',
    'Operating Systems',
    'AI',
    'Networks',
    'Web Development',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _loginEmailCtrl.dispose();
    _loginPassCtrl.dispose();
    _regNameCtrl.dispose();
    _regEmailCtrl.dispose();
    _regPassCtrl.dispose();
    _regHostelCtrl.dispose();
    _regBioCtrl.dispose();
    _adminEmailCtrl.dispose();
    _adminPassCtrl.dispose();
    super.dispose();
  }

  void _onLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;
    final success = await widget.authState.login(
      _loginEmailCtrl.text.trim(),
      _loginPassCtrl.text,
    );
    if (success && mounted) {
      widget.onAuthenticated();
    }
  }

  void _onRegister() async {
    if (!_regFormKey.currentState!.validate()) return;
    final success = await widget.authState.registerStudent(
      fullName: _regNameCtrl.text.trim(),
      email: _regEmailCtrl.text.trim(),
      password: _regPassCtrl.text,
      branch: _selectedBranch,
      academicYear: _selectedYear,
      hostelOrArea: _regHostelCtrl.text.trim().isNotEmpty
          ? _regHostelCtrl.text.trim()
          : 'Campus Hostel',
      bio: _regBioCtrl.text.trim(),
      subjectInterests: _selectedSubjects.toList(),
    );

    if (success && mounted) {
      widget.onAuthenticated();
    }
  }

  /// Instant demo account helper for smooth testing
  void _loginAsDemoStudent() async {
    final success = await widget.authState.loginDemo();
    if (success && mounted) {
      widget.onAuthenticated();
    }
  }

  /// Instant Master Admin Quick Login
  void _loginAsDemoAdmin() async {
    final success = await widget.authState.loginMasterAdminDemo();
    if (success && mounted) {
      widget.onAuthenticated();
    }
  }

  /// Dedicated Administrator Login with credentials
  void _onAdminLogin() async {
    if (!_adminFormKey.currentState!.validate()) return;
    final success = await widget.authState.loginAdmin(
      _adminEmailCtrl.text.trim(),
      _adminPassCtrl.text,
    );
    if (success && mounted) {
      widget.onAuthenticated();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: AppleTokens.space24,
        vertical: AppleTokens.space40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              // Logo
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppleTokens.primaryTeal,
                  borderRadius: BorderRadius.circular(AppleTokens.radius8),
                ),
                child: const Center(
                  child: Text(
                    'C',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppleTokens.space16),
              Text(
                'Welcome to CAMPULSE',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? AppleTokens.darkTextPrimary
                      : AppleTokens.neutralDark,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: AppleTokens.space8),
              Text(
                'Connect with classmates, join campus events, and form study groups.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: isDark
                      ? AppleTokens.darkTextSecondary
                      : AppleTokens.neutralBrown,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: AppleTokens.space24),

              // Error feedback if any
              ListenableBuilder(
                listenable: widget.authState,
                builder: (context, _) {
                  if (widget.authState.errorMessage != null) {
                    return Container(
                      margin: const EdgeInsets.only(
                        bottom: AppleTokens.space16,
                      ),
                      padding: const EdgeInsets.all(AppleTokens.space12),
                      decoration: BoxDecoration(
                        color: AppleTokens.error.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                        border: Border.all(
                          color: AppleTokens.error.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: AppleTokens.error,
                            size: 20,
                          ),
                          const SizedBox(width: AppleTokens.space8),
                          Expanded(
                            child: Text(
                              widget.authState.errorMessage!,
                              style: const TextStyle(
                                color: AppleTokens.error,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),

              // Card with Tabs
              AppleCard(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Tabs
                    Container(
                      height: 40,
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: isDark
                            ? AppleTokens.darkSurfaceElevated
                            : AppleTokens.lightMint,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: AppleTokens.primaryTeal,
                          borderRadius: BorderRadius.circular(
                            AppleTokens.radius8,
                          ),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: isDark
                            ? AppleTokens.darkTextSecondary
                            : AppleTokens.neutralBrown,
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        labelStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                        tabs: const [
                          Tab(text: 'Sign In'),
                          Tab(text: 'Register'),
                          Tab(text: 'Admin Quick Login'),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space24),

                    // Tab View
                    AnimatedBuilder(
                      animation: _tabController,
                      builder: (context, _) {
                        if (_tabController.index == 0) {
                          return _buildLoginForm(isDark);
                        } else if (_tabController.index == 1) {
                          return _buildRegisterForm(isDark);
                        } else {
                          return _buildAdminQuickLoginForm(isDark);
                        }
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: AppleTokens.space24),

              // Instant Demo Student Login
              AppleButton(
                label: 'Instant Demo Student Login (Aarav - CSE Year 3)',
                variant: AppleButtonVariant.outline,
                icon: Icons.account_circle_outlined,
                onPressed: _loginAsDemoStudent,
              ),
              const SizedBox(height: AppleTokens.space12),

              // Instant Demo Admin Quick Login
              AppleButton(
                label: '⚡ 1-Click Master Admin Dashboard Access',
                variant: AppleButtonVariant.secondary,
                icon: Icons.admin_panel_settings_rounded,
                onPressed: _loginAsDemoAdmin,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(bool isDark) {
    return Form(
      key: _loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _loginEmailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Campus Email',
              hintText: 'student@campus.edu',
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Enter your campus email';
              }
              if (!v.contains('@')) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: AppleTokens.space16),
          PasswordTextField(
            controller: _loginPassCtrl,
            validator: (v) => v == null || v.length < 6
                ? 'Password must be at least 6 characters'
                : null,
            onFieldSubmitted: (_) => _onLogin(),
          ),
          const SizedBox(height: AppleTokens.space24),
          ListenableBuilder(
            listenable: widget.authState,
            builder: (context, _) {
              return AppleButton(
                label: 'Sign In',
                isLoading: widget.authState.isLoading,
                onPressed: _onLogin,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterForm(bool isDark) {
    return Form(
      key: _regFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _regNameCtrl,
            decoration: const InputDecoration(
              labelText: 'Full Name',
              hintText: 'e.g. Maya Patel',
              prefixIcon: Icon(Icons.person_outline, size: 20),
            ),
            validator: (v) =>
                v == null || v.trim().isEmpty ? 'Enter your full name' : null,
          ),
          const SizedBox(height: AppleTokens.space12),
          TextFormField(
            controller: _regEmailCtrl,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Campus Email',
              hintText: 'maya.patel@campus.edu',
              prefixIcon: Icon(Icons.email_outlined, size: 20),
            ),
            validator: (v) {
              if (v == null || v.trim().isEmpty) {
                return 'Enter your campus email';
              }
              if (!v.contains('@')) {
                return 'Enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: AppleTokens.space12),
          PasswordTextField(
            controller: _regPassCtrl,
            validator: (v) => v == null || v.length < 6
                ? 'Password must be at least 6 characters'
                : null,
          ),
          const SizedBox(height: AppleTokens.space16),

          // Branch & Year Row
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: _selectedBranch,
                  decoration: const InputDecoration(labelText: 'Branch'),
                  items: _availableBranches
                      .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedBranch = v);
                  },
                ),
              ),
              const SizedBox(width: AppleTokens.space12),
              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: _selectedYear,
                  decoration: const InputDecoration(labelText: 'Year'),
                  items: [1, 2, 3, 4]
                      .map(
                        (y) =>
                            DropdownMenuItem(value: y, child: Text('Year $y')),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedYear = v);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppleTokens.space12),

          TextFormField(
            controller: _regHostelCtrl,
            decoration: const InputDecoration(
              labelText: 'Hostel or Campus Area',
              hintText: 'e.g. Block C, Ganga Hostel',
              prefixIcon: Icon(Icons.home_outlined, size: 20),
            ),
          ),
          const SizedBox(height: AppleTokens.space16),

          // Subject Interests
          Text(
            'Subject Interests (For Study Matching):',
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontSize: 14),
          ),
          const SizedBox(height: AppleTokens.space8),
          Wrap(
            spacing: AppleTokens.space8,
            runSpacing: AppleTokens.space8,
            children: _availableSubjects.map((sub) {
              final isSelected = _selectedSubjects.contains(sub);
              return FilterChip(
                label: Text(sub),
                selected: isSelected,
                onSelected: (val) {
                  setState(() {
                    if (val) {
                      _selectedSubjects.add(sub);
                    } else {
                      _selectedSubjects.remove(sub);
                    }
                  });
                },
              );
            }).toList(),
          ),
          const SizedBox(height: AppleTokens.space24),

          ListenableBuilder(
            listenable: widget.authState,
            builder: (context, _) {
              return AppleButton(
                label: 'Create Student Account',
                isLoading: widget.authState.isLoading,
                onPressed: _onRegister,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAdminQuickLoginForm(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Admin Info Banner
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppleTokens.lightMint,
            borderRadius: BorderRadius.circular(AppleTokens.radius8),
            border: Border.all(
              color: AppleTokens.purple.withValues(alpha: 0.35),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.admin_panel_settings_rounded,
                color: AppleTokens.primaryTeal,
                size: 22,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Authorized Master Admin access to manage section timetables, campus events, syllabus quizzes, and rosters.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppleTokens.neutralDark,
                    height: 1.35,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppleTokens.space20),

        // 1-Click Instant Master Admin Quick Login
        AppleButton(
          label: '⚡ 1-Click Quick Login as Master Admin',
          variant: AppleButtonVariant.primary,
          isLoading: widget.authState.isLoading,
          onPressed: _loginAsDemoAdmin,
        ),
        const SizedBox(height: AppleTokens.space16),

        // Neutral divider
        Row(
          children: [
            Expanded(
              child: Container(
                height: 1,
                color: AppleTokens.borderSubtle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                'OR SIGN IN WITH ADMIN CREDENTIALS',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppleTokens.neutralBrown,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 1,
                color: AppleTokens.borderSubtle,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppleTokens.space16),

        // Admin Credentials Form
        Form(
          key: _adminFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _adminEmailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Admin Email',
                  hintText: 'admin@campuspulse.edu',
                  prefixIcon: Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 20,
                  ),
                ),
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Enter admin email' : null,
              ),
              const SizedBox(height: AppleTokens.space16),
              PasswordTextField(
                controller: _adminPassCtrl,
                validator: (v) => v == null || v.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                onFieldSubmitted: (_) => _onAdminLogin(),
              ),
              const SizedBox(height: AppleTokens.space20),
              AppleButton(
                label: 'Sign In as Administrator',
                variant: AppleButtonVariant.secondary,
                isLoading: widget.authState.isLoading,
                onPressed: _onAdminLogin,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
