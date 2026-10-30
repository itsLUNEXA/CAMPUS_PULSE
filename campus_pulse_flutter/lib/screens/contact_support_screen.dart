import 'package:flutter/material.dart';
import '../client.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class ContactSupportScreen extends StatefulWidget {
  final VoidCallback onBack;

  const ContactSupportScreen({super.key, required this.onBack});

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();

  bool _isLoading = false;
  bool _isSuccess = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _subjectCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

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
    } catch (_) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not deliver your inquiry. Please try again.';
      });
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
                'Campus Support & Inquiries',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space4),
              const Text(
                'Send a message to the campus administrators or technical support team.',
              ),
              const SizedBox(height: AppleTokens.space24),

              if (_isSuccess)
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space32),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle_outline,
                          color: AppleTokens.success,
                          size: 48,
                        ),
                        const SizedBox(height: AppleTokens.space16),
                        Text(
                          'Inquiry Submitted',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: AppleTokens.space8),
                        const Text(
                          'Thank you! Your message has been saved to the campus database. A representative will contact you via email shortly.',
                        ),
                        const SizedBox(height: AppleTokens.space24),
                        AppleButton(
                          label: 'Back to Home',
                          onPressed: widget.onBack,
                        ),
                      ],
                    ),
                  ),
                )
              else
                AppleCard(
                  padding: const EdgeInsets.all(AppleTokens.space28),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                          const SizedBox(height: AppleTokens.space16),
                        ],

                        TextFormField(
                          controller: _nameCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Full Name',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Please enter your name'
                              : null,
                        ),
                        const SizedBox(height: AppleTokens.space16),

                        TextFormField(
                          controller: _emailCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Campus Email',
                          ),
                          validator: (v) => v == null || !v.contains('@')
                              ? 'Enter a valid campus email'
                              : null,
                        ),
                        const SizedBox(height: AppleTokens.space16),

                        TextFormField(
                          controller: _subjectCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Subject',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Please enter a subject'
                              : null,
                        ),
                        const SizedBox(height: AppleTokens.space16),

                        TextFormField(
                          controller: _messageCtrl,
                          maxLines: 4,
                          decoration: const InputDecoration(
                            labelText: 'Message / Inquiry Details',
                          ),
                          validator: (v) => v == null || v.trim().isEmpty
                              ? 'Please enter your message'
                              : null,
                        ),
                        const SizedBox(height: AppleTokens.space24),

                        AppleButton(
                          label: 'Submit Support Inquiry',
                          isLoading: _isLoading,
                          onPressed: _submit,
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
