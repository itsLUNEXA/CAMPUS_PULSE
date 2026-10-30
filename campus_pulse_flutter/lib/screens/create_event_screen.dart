import 'package:flutter/material.dart';
import '../client.dart';
import '../services/auth_state.dart';
import '../theme/apple_tokens.dart';
import '../widgets/apple_button.dart';
import '../widgets/apple_card.dart';

class CreateEventScreen extends StatefulWidget {
  final AuthState authState;
  final VoidCallback onEventCreated;
  final VoidCallback onCancel;

  const CreateEventScreen({
    super.key,
    required this.authState,
    required this.onEventCreated,
    required this.onCancel,
  });

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _venueCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _bannerCtrl = TextEditingController();

  String _category = 'Tech';
  final List<String> _categories = [
    'Tech',
    'Sports',
    'Cultural',
    'Workshop',
    'Hackathon',
  ];

  final DateTime _startDate = DateTime.now().add(
    const Duration(days: 2, hours: 10),
  );
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _venueCtrl.dispose();
    _descCtrl.dispose();
    _bannerCtrl.dispose();
    super.dispose();
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    if (!widget.authState.isAuthenticated) {
      setState(
        () => _errorMessage = 'Please sign in to organize campus events.',
      );
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await client.event.createEvent(
        title: _titleCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        category: _category,
        startTime: _startDate,
        endTime: _startDate.add(const Duration(hours: 3)),
        venue: _venueCtrl.text.trim(),
        bannerUrl: _bannerCtrl.text.trim().isNotEmpty
            ? _bannerCtrl.text.trim()
            : null,
      );

      setState(() => _isLoading = false);
      widget.onEventCreated();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Could not create event. Please verify all details.';
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
                onPressed: widget.onCancel,
              ),
              const SizedBox(height: AppleTokens.space16),

              Text(
                'Organize a Campus Event',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: AppleTokens.space8),
              const Text(
                'Publish an event to the campus feed for your club, department, or student community.',
              ),
              const SizedBox(height: AppleTokens.space24),

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
                        controller: _titleCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Event Title',
                          hintText: 'e.g. AI & Robotics Showcase',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter a title'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      DropdownButtonFormField<String>(
                        initialValue: _category,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                        ),
                        items: _categories
                            .map(
                              (c) => DropdownMenuItem(value: c, child: Text(c)),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) setState(() => _category = v);
                        },
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      TextFormField(
                        controller: _venueCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Venue / Location',
                          hintText: 'e.g. Seminar Hall 3',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please enter a venue'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      TextFormField(
                        controller: _bannerCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Banner Image URL (Optional)',
                          hintText: 'https://images.unsplash.com/...',
                        ),
                      ),
                      const SizedBox(height: AppleTokens.space16),

                      TextFormField(
                        controller: _descCtrl,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          labelText: 'Description & Highlights',
                          hintText:
                              'Provide complete details for participants...',
                        ),
                        validator: (v) => v == null || v.trim().isEmpty
                            ? 'Please provide a description'
                            : null,
                      ),
                      const SizedBox(height: AppleTokens.space24),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppleButton(
                            label: 'Cancel',
                            variant: AppleButtonVariant.subtle,
                            height: 40,
                            onPressed: widget.onCancel,
                          ),
                          const SizedBox(width: AppleTokens.space12),
                          AppleButton(
                            label: 'Publish Event',
                            isLoading: _isLoading,
                            height: 40,
                            onPressed: _submit,
                          ),
                        ],
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
