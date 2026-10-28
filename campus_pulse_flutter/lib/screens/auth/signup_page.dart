import 'package:flutter/material.dart';
import '../../services/client_service.dart';
import '../../theme/app_theme.dart';

class SignupPage extends StatefulWidget {
  final VoidCallback onSignupSuccess;

  const SignupPage({super.key, required this.onSignupSuccess});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _interestsController = TextEditingController(text: 'DSA, AI, DBMS');
  final _hostelAreaController = TextEditingController(text: 'Hostel Block A');

  String _selectedBranch = 'Computer Science';
  int _selectedYear = 2;
  bool _isLoading = false;
  String? _errorMessage;

  final List<String> _branches = [
    'Computer Science',
    'Information Technology',
    'Electronics & Comm.',
    'Mechanical Eng.',
    'Civil Eng.',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _interestsController.dispose();
    _hostelAreaController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final hostel = _hostelAreaController.text.trim();
    final interests = _interestsController.text
        .split(',')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (name.isEmpty || email.isEmpty || password.isEmpty || hostel.isEmpty) {
      setState(() => _errorMessage = 'Please complete all required fields.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final res = await ClientService.instance.signup(
        name: name,
        email: email,
        password: password,
        branch: _selectedBranch,
        year: _selectedYear,
        interests: interests,
        hostelArea: hostel,
      );

      if (!mounted) return;

      if (res.success) {
        Navigator.of(context).pop();
        widget.onSignupSuccess();
      } else {
        setState(() => _errorMessage = res.message ?? 'Signup failed.');
      }
    } catch (e) {
      setState(() => _errorMessage = 'Connection error: $e');
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Registration')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEF4444).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.3)),
                  ),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Color(0xFFEF4444), fontSize: 13),
                  ),
                ),
              ],

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'e.g., Aarav Sharma',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'College Email',
                  hintText: 'name@campus.edu',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Create Password',
                  hintText: '••••••••',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 14),

              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<String>(
                      value: _selectedBranch,
                      decoration: const InputDecoration(labelText: 'Branch'),
                      dropdownColor: AppTheme.surfaceDark,
                      items: _branches
                          .map((b) => DropdownMenuItem(value: b, child: Text(b, overflow: TextOverflow.ellipsis)))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedBranch = val);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      value: _selectedYear,
                      decoration: const InputDecoration(labelText: 'Year'),
                      dropdownColor: AppTheme.surfaceDark,
                      items: [1, 2, 3, 4]
                          .map((y) => DropdownMenuItem(value: y, child: Text('Yr $y')))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedYear = val);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _hostelAreaController,
                decoration: const InputDecoration(
                  labelText: 'Hostel / Campus Area',
                  hintText: 'e.g., Hostel Block A / Day Scholar',
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
              const SizedBox(height: 14),

              TextField(
                controller: _interestsController,
                decoration: const InputDecoration(
                  labelText: 'Academic Interests (comma separated)',
                  hintText: 'e.g., DSA, AI, DBMS, Web3',
                  prefixIcon: Icon(Icons.tag_rounded),
                ),
              ),
              const SizedBox(height: 28),

              ElevatedButton(
                onPressed: _isLoading ? null : _handleSignup,
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('Complete Registration'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
