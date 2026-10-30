import 'package:campus_pulse_client/campus_pulse_client.dart';
import 'package:flutter/material.dart';
import '../client.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';

class StudyRequestDialog extends StatefulWidget {
  final StudentProfile targetStudent;
  final VoidCallback onSuccess;

  const StudyRequestDialog({
    super.key,
    required this.targetStudent,
    required this.onSuccess,
  });

  @override
  State<StudyRequestDialog> createState() => _StudyRequestDialogState();
}

class _StudyRequestDialogState extends State<StudyRequestDialog> {
  final _formKey = GlobalKey<FormState>();
  final _messageCtrl = TextEditingController(
    text:
        'Hi! I saw we share academic interests. Would you like to form a study group and prepare together?',
  );

  late String _selectedSubject;
  String _selectedUrgency = 'medium';
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _selectedSubject = widget.targetStudent.subjectInterests.isNotEmpty
        ? widget.targetStudent.subjectInterests.first
        : 'DSA';
  }

  @override
  void dispose() {
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
      await client.studyRequest.sendRequest(
        recipientAuthUserId: widget.targetStudent.authUserId,
        subject: _selectedSubject,
        message: _messageCtrl.text.trim(),
        urgency: _selectedUrgency,
      );

      setState(() => _isLoading = false);
      if (mounted) {
        Navigator.of(context).pop();
        widget.onSuccess();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not send study request. Please try again.';
      });
    }
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
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(AppleTokens.space24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Send Study Request',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                Text(
                  'To ${widget.targetStudent.fullName} (${widget.targetStudent.branch} - Year ${widget.targetStudent.academicYear})',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: AppleTokens.space16),

                if (_errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(AppleTokens.space12),
                    decoration: BoxDecoration(
                      color: AppleTokens.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppleTokens.radius8),
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

                // Subject Focus
                DropdownButtonFormField<String>(
                  initialValue: _selectedSubject,
                  decoration: const InputDecoration(
                    labelText: 'Primary Subject Focus',
                  ),
                  items: widget.targetStudent.subjectInterests
                      .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                      .toList(),
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedSubject = v);
                  },
                ),
                const SizedBox(height: AppleTokens.space16),

                // Urgency
                DropdownButtonFormField<String>(
                  initialValue: _selectedUrgency,
                  decoration: const InputDecoration(
                    labelText: 'Preparation Urgency',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'low',
                      child: Text('Low (Casual Study)'),
                    ),
                    DropdownMenuItem(
                      value: 'medium',
                      child: Text('Medium (Upcoming Midterm / Quiz)'),
                    ),
                    DropdownMenuItem(
                      value: 'high',
                      child: Text('High (Final Exams / Immediate Focus)'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) setState(() => _selectedUrgency = v);
                  },
                ),
                const SizedBox(height: AppleTokens.space16),

                TextFormField(
                  controller: _messageCtrl,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Invitation Message',
                  ),
                  validator: (v) => v == null || v.trim().isEmpty
                      ? 'Please enter a message'
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
                      label: 'Send Request',
                      isLoading: _isLoading,
                      height: 38,
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
