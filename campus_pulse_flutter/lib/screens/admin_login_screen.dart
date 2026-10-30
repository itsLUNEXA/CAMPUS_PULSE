import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/admin_auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class AdminLoginScreen extends StatefulWidget {
  final AdminAuthState adminAuthState;
  final VoidCallback onAdminAuthenticated;
  final VoidCallback? onLibraryStaffAuthenticated;
  final VoidCallback onBackToStudentPortal;

  const AdminLoginScreen({
    super.key,
    required this.adminAuthState,
    required this.onAdminAuthenticated,
    this.onLibraryStaffAuthenticated,
    required this.onBackToStudentPortal,
  });

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _emailController = TextEditingController(text: 'admin@campuspulse.edu');
  final _passwordController = TextEditingController(
    text: 'AdminMasterPassword2026!',
  );
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) return;

    final success = await widget.adminAuthState.loginAdmin(
      email: email,
      password: password,
    );

    if (success && mounted) {
      widget.onAdminAuthenticated();
    }
  }

  Future<void> _handleDemoLogin() async {
    final success = await widget.adminAuthState.loginMasterAdminDemo();
    if (success && mounted) {
      widget.onAdminAuthenticated();
    }
  }

  Future<void> _handleLibraryStaffLogin() async {
    final success = await widget.adminAuthState.loginLibraryStaffDemo();
    if (success && mounted) {
      if (widget.onLibraryStaffAuthenticated != null) {
        widget.onLibraryStaffAuthenticated!();
      } else {
        widget.onAdminAuthenticated();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? AppleTokens.darkBackground
          : AppleTokens.surfaceMuted,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppleTokens.space24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: AppleCard(
              padding: const EdgeInsets.all(AppleTokens.space32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Admin Security Shield Badge
                  Center(
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: AppleTokens.primaryTeal,
                        borderRadius: BorderRadius.circular(
                          AppleTokens.radius8,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.admin_panel_settings_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),

                  Text(
                    'CAMPULSE',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: AppleTokens.textMutedGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Master Admin Portal',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: isDark ? Colors.white : AppleTokens.darkNavy,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Restricted access. Only authorized campus administrators and superusers are permitted to authenticate.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppleTokens.textMutedGrey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Error notification if present
                  ListenableBuilder(
                    listenable: widget.adminAuthState,
                    builder: (context, _) {
                      if (widget.adminAuthState.errorMessage == null) {
                        return const SizedBox.shrink();
                      }
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.red.shade200),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.adminAuthState.errorMessage!,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Email input
                  Text(
                    'Administrator Email',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppleTokens.darkSurface
                          : AppleTokens.warmWhite,
                      borderRadius: BorderRadius.circular(AppleTokens.radius16),
                      border: Border.all(color: AppleTokens.borderPastel),
                    ),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        hintText: 'admin@campuspulse.edu',
                        prefixIcon: Icon(Icons.email_outlined, size: 18),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Password input
                  Text(
                    'Master Secret Password',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppleTokens.darkNavy,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppleTokens.darkSurface
                          : AppleTokens.warmWhite,
                      borderRadius: BorderRadius.circular(AppleTokens.radius16),
                      border: Border.all(color: AppleTokens.borderPastel),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        hintText: '••••••••••••',
                        prefixIcon: const Icon(Icons.lock_outline, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 18,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Authenticate Button
                  ListenableBuilder(
                    listenable: widget.adminAuthState,
                    builder: (context, _) {
                      return AppleButton(
                        label: 'Authenticate Master Admin',
                        variant: AppleButtonVariant.primary,
                        isLoading: widget.adminAuthState.isLoading,
                        onPressed: _handleLogin,
                      );
                    },
                  ),
                  const SizedBox(height: 12),

                  // Demo Instant Login for Setup
                  AppleButton(
                    label: '⚡ 1-Click Master Admin Access',
                    variant: AppleButtonVariant.secondary,
                    onPressed: _handleDemoLogin,
                  ),
                  const SizedBox(height: 10),

                  // Library Staff Quick Access
                  AppleButton(
                    label: '🖨️ 1-Click Library Staff Access',
                    variant: AppleButtonVariant.outline,
                    onPressed: _handleLibraryStaffLogin,
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 8),

                  // Return to Student App link
                  TextButton.icon(
                    onPressed: widget.onBackToStudentPortal,
                    icon: const Icon(Icons.arrow_back_rounded, size: 16),
                    label: const Text('Return to Student Portal'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppleTokens.textMutedGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
