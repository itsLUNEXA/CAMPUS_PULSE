import 'package:flutter/material.dart';
import 'package:campus_pulse_client/campus_pulse_client.dart';
import '../../services/client_service.dart';
import '../../services/auth_state.dart';
import '../../theme/app_theme.dart';

class CreateEventSheet extends StatefulWidget {
  final VoidCallback onEventCreated;

  const CreateEventSheet({super.key, required this.onEventCreated});

  @override
  State<CreateEventSheet> createState() => _CreateEventSheetState();
}

class _CreateEventSheetState extends State<CreateEventSheet> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _venueController = TextEditingController();
  String _category = 'Tech';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 2));
  bool _isLoading = false;

  final List<String> _categories = ['Tech', 'Sports', 'Cultural', 'Workshop'];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _venueController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();
    final venue = _venueController.text.trim();

    if (title.isEmpty || desc.isEmpty || venue.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all event fields.')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final currentStudent = AuthState.instance.currentStudent;
    final newEvent = CampusEvent(
      title: title,
      description: desc,
      category: _category,
      venue: venue,
      startTime: _selectedDate,
      createdBy: currentStudent?.name ?? 'Campus Organizers',
      rsvpCount: 1,
    );

    try {
      await ClientService.instance.createEvent(newEvent);
      if (!mounted) return;
      Navigator.of(context).pop();
      widget.onEventCreated();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎉 Event posted live to Campus Pulse!')),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error posting event: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Post Campus Event',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppTheme.textMuted),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Event Title', hintText: 'e.g. AI Hackathon 2026'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descController,
              maxLines: 2,
              decoration: const InputDecoration(labelText: 'Description', hintText: 'What is this event about?'),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _category,
              dropdownColor: AppTheme.surfaceDark,
              decoration: const InputDecoration(labelText: 'Category'),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _category = val);
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _venueController,
              decoration: const InputDecoration(labelText: 'Venue / Hall', hintText: 'e.g. Seminar Hall 3'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Post Event Now'),
            ),
          ],
        ),
      ),
    );
  }
}
