import 'package:flutter/material.dart';
import '../client.dart';
import '../theme/apple_tokens.dart';
import 'apple_button.dart';

class FloatingContactButton extends StatelessWidget {
  const FloatingContactButton({super.key});

  void _openContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => const _ContactDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FloatingActionButton.extended(
      heroTag: 'campus_pulse_contact_fab',
      onPressed: () => _openContactDialog(context),
      backgroundColor: isDark
          ? AppleTokens.darkSurfaceElevated
          : AppleTokens.deepViolet,
      foregroundColor: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppleTokens.radius8),
      ),
      icon: const Icon(Icons.help_outline_rounded, size: 18),
      label: const Text(
        'Campus Support',
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }
}

class _ContactDialog extends StatefulWidget {
  const _ContactDialog();

  @override
  State<_ContactDialog> createState() => _ContactDialogState();
}

class _ContactDialogState extends State<_ContactDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await client.search.submitContact(
        name: _nameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        subject: _subjectCtrl.text.trim(),
        message: _messageCtrl.text.trim(),
      );

      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not submit message. Please try again.';
      });
    }
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppleTokens.radius16),
      ),
      backgroundColor: isDark
          ? AppleTokens.darkSurfaceElevated
          : AppleTokens.white,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(AppleTokens.space24),
          child: _isSuccess
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check_circle_outline,
                      color: AppleTokens.success,
                      size: 48,
                    ),
                    const SizedBox(height: AppleTokens.space16),
                    Text(
                      'Message Received',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppleTokens.space8),
                    Text(
                      'Thank you for reaching out. The campus administration or support team will respond to your email.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppleTokens.space24),
                    AppleButton(
                      label: 'Close',
                      variant: AppleButtonVariant.primary,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                )
              : Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'CAMPULSE Help & Support',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppleTokens.space16),
                      if (_errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(AppleTokens.space12),
                          decoration: BoxDecoration(
                            color: AppleTokens.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(
                              AppleTokens.radius8,
                            ),
                          ),
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(
                              color: AppleTokens.error,
                              fontSize: 13,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppleTokens.space12),
                      ],
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Your Name',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space12),
                      TextFormField(
                        controller: _emailCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Campus Email',
                        ),
                        validator: (v) => v == null || !v.contains('@')
                            ? 'Valid campus email required'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space12),
                      TextFormField(
                        controller: _subjectCtrl,
                        decoration: const InputDecoration(labelText: 'Subject'),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter a subject'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space12),
                      TextFormField(
                        controller: _messageCtrl,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: 'How can we help?',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please describe your request'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppleButton(
                            label: 'Cancel',
                            variant: AppleButtonVariant.subtle,
                            height: 38,
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          const SizedBox(width: AppleTokens.space12),
                          AppleButton(
                            label: 'Send Message',
                            variant: AppleButtonVariant.primary,
                            height: 38,
                            isLoading: _isLoading,
                            onPressed: _submit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
